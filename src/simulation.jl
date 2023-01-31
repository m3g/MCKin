#
# Function that performs the simulation
#

function simulation(v, T;
    nsamples::Int=100, ijsample=[0, 0],
    tmax=+Inf,
    startat::Int=1,
    R=0.001987204118 # kcal/mol
)
    RT = R * T
    nv = length(v)
    last_passage = zeros(nv)
    traj_start = zeros(nv, nv)
    n_fpt_samples = zeros(Int, nv, nv)
    fpt = zeros(nv, nv)
    t = 0.0
    x = startat
    if ijsample == [0, 0]
        ijsample = [1, nv]
    end
    minsample = 0
    while minsample < nsamples && t < tmax
        t = t + 1.0
        direction = rand((-1,+1))
        (direction == +1 & x == nv) && continue # last position and forward direction: skip
        (direction == -1 & x == 1 ) && continue # first position and backward direction: skip
        # Compute the energy difference
        dv = v[x+direction] - v[x]
        # Check metropolis criterium
        !accept(dv, RT) && continue
        # The new position was accepted, so lets move on
        x = x + direction
        # The particle moved, so lets compute first passage times from every other
        # position to this position
        for xprev in 1:nv
            # If the particle didn't pass by position xprev since the previous visit to x,
            # continue. The case "=" occurs when the particle returns to the same position after
            # having visited other positions in the meantime
            if last_passage[xprev] >= last_passage[x]
                # The particle reached x now, so we can compute the time required since the last
                # trajectory start from xprev
                dt = t - traj_start[xprev, x]
                # And we can update the first passage time vectors
                fpt[xprev, x] = fpt[xprev, x] + dt
                n_fpt_samples[xprev, x] = n_fpt_samples[xprev, x] + 1
                # This is the first time that particle passes by x after passing by xprev, thus
                # here a new trajectory starts from x to xprev 
                traj_start[x, xprev] = t
            end
        end
        last_passage[x] = t
        # The sampling is counted for the passages from the first to the last position
        if n_fpt_samples[ijsample[1], ijsample[2]] > minsample
            minsample = n_fpt_samples[ijsample[1], ijsample[2]]
            println(" t = ", t, " minimum sampling = ", minsample, " of ", nsamples, " for ", ijsample[1], "->", ijsample[2])
        end
    end
    # Average passage times over all samples
    for i in 1:nv
        for j in 1:nv
            if n_fpt_samples[i, j] != 0
                fpt[i, j] = fpt[i, j] / n_fpt_samples[i, j]
            end
        end
    end
    if t == tmax
        println(" Warning: Exit by tmax. Sampling: ", minsample)
    end
    return fpt, n_fpt_samples
end


#
# Function that performs the simulation
#

function simulation(v,T;
                    nsamples=100, ijsample=[0,0],
                    tmax=Inf,
                    startat=1,
                    R=0.001987204118 # kcal/mol
                    )
  RT = R*T
  nv = length(v)
  last_passage = zeros(Float64,nv)
  traj_start = zeros(Float64,nv,nv)
  n_fpt_samples = zeros(Int64,nv,nv)
  fpt = zeros(Float64,nv,nv)
  t = 0.
  x = startat
  if ijsample == [0,0]
    ijsample = [ 1, nv ]
  end
  minsample = 0
  @inbounds while minsample < nsamples && t < tmax
    t = t + 1.
    if rand(Float64) > 0.5
      # If this is the last position it is not possible to move further
      if x == nv
        continue
      end
      # Compute the energy difference
      dv = v[x+1] - v[x]
      # Check metropolis criterium
      if accept(dv,RT)
        x = x + 1 
      else # If the particle remained at the same position
        continue
      end
    else
      # If this is the last position it is not possible to move back
      if x == 1
        continue
      end
      # Compute energy difference
      dv = v[x-1] - v[x]
      # Test metropolis criterium
      if accept(dv,RT)
        x = x - 1
      else # If the particle remained at the same position
        continue
      end
    end
    # The particle moved, so lets compute first passage times from every other
    # position to this position
    for xprev in 1:nv
      # If the particle didn't pass by position xprev since the previous visit to x,
      # continue. The case "=" occurs when the particle returns to the same position after
      # having visited other positions in the meantime
      if last_passage[xprev] >= last_passage[x]
        # The particle reached x now, so we can compute the time required since the last
        # trajectory start from xprev
        dt = t - traj_start[xprev,x]
        # And we can update the first passage time vectors
        fpt[xprev,x] = fpt[xprev,x] + dt
        n_fpt_samples[xprev,x] = n_fpt_samples[xprev,x] + 1
        # This is the first time that particle passes by x after passing by xprev, thus
        # here a new trajectory starts from x to xprev 
        traj_start[x,xprev] = t
      end
    end
    last_passage[x] = t
    # The sampling is counted for the passages from the first to the last
    # position
    if n_fpt_samples[ijsample[1],ijsample[2]] > minsample
      minsample = n_fpt_samples[ijsample[1],ijsample[2]]
      println(" t = ",t," minimum sampling = ", minsample," of ",nsamples," for ", ijsample[1], "->", ijsample[2])
    end
  end
  # Average passage times over all samples
  for i in 1:nv
    for j in 1:nv
      if n_fpt_samples[i,j] != 0
        fpt[i,j] = fpt[i,j] / n_fpt_samples[i,j]
      end
    end
  end
  if t == tmax
    println(" Warning: Exit by tmax. Sampling: ", minsample)
  end
  return fpt, n_fpt_samples
end


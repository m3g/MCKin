#
# Function to retrive a specific matrix element given the reaction coordinate
# definition
#

function tstep(xini,xend,fptmatrix :: Matrix{Float64};z=nothing)
  n = size(fptmatrix)[1]
  if z == nothing
    z = collect(1:n)
  end
  i_ini = 1
  while( z[i_ini] < xini && i_ini < n )
    i_ini = i_ini + 1
  end
  i_end = 1
  while( z[i_end] < xend && i_end < n )
    i_end = i_end + 1
  end
  tstep = fptmatrix[i_ini,i_end]
  return tstep
end





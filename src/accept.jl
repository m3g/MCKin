#
# Function that computes the acceptance criterium 
#

function accept(dv,kT)
  if dv <= 0.
    return true
  else
    if exp(-dv/kT) > rand(Float64)
      return true
    else
      return false
    end
  end
end


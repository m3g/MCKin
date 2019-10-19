#
# Function that computes the acceptance criterium 
#

function accept(dv,RT)
  if dv <= 0.
    return true
  else
    if exp(-dv/RT) > rand(Float64)
      return true
    else
      return false
    end
  end
end


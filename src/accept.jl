#
# Function that computes the acceptance criterium 
#
function accept(dv, RT)
    if dv <= 0
        return true
    else
        return exp(-dv / RT) > rand()
    end
end


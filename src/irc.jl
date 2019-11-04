#
# Function to retrive a the index in the coordinates vector
# of a specific reaction coordinate. It returns the closest element
# of the vector to the desired coordinate.
#

function irc(ztarget,z)
  irc = 1 
  nz = length(z)
  while z[irc] < ztarget & irc < nz
    irc = irc + 1
  end
  if irc == 1 
    return 1
  end
  if irc == nz
    return nz
  end
  if (z[irc] - ztarget) < (ztarget - z[irc-1])
    return irc
  else
    return irc-1
  end
end


using DelimitedFiles
using Plots
using MCKin

# Read the data from a file

data = readdlm("./CC0.dat",comments=true,comment_char='#') 

# Here, the reaction coordinate is the first column
z = data[:,1]

# And the free energy profile is in the fifth column
PMF = data[:,5]

# Lets plot the free energy profile
plot(z,PMF,linewidth=2,xlabel="reaction coordinate",ylabel="Free energy")
savefig("./PMF.pdf")

# We will, in this case, use the last coordinate as the reference
# state (this is only for data visualization). In this case, the PMF is
# discretized in 350 data points (length(z)=350).
iref = length(z)
@. PMF = PMF - PMF[iref]

# Number of samples required for the trajectory
nsamples = 1000

# In this case, the minimum sampling will be counted for trajectories starting
# from the first coordinate to the last coordinate 
ijsample=[1,length(z)]

# Initial position (according to PMF vector)
startat=1

# Temperature
T = 298.15

# Perform the simulation (if the free energy is not in kcal/mol, add R=... to define the
# gas constant in alternative units).
fpt, nsamples = MCKin.simulation(PMF,T,nsamples=nsamples, startat=startat, ijsample=ijsample)

# The fpt matrix contains, for each [i,j], the mean first-passage time from i to j. The nsamples matrix
# contains the number of samples from which the mean was computed.
# Lets plot the mean passage time starting from the last coordinate to all other coordinates: 
plot(z,fpt[350,:],linewidth=2,xlabel="reaction coordinate - z",ylabel="mean passage time from 45 to z")
savefig("./fpt350.pdf")

# Using the contourf function it is possible to the complete matrix of mean first passage
# times form any coordinate to any other coordinate
contourf(z,z,fpt,transpose=true,nlevels=100,fill=true,color=cgrad(:tempo))
plot!(xlabel="starting position",ylabel="final position")
savefig("fpt.pdf")





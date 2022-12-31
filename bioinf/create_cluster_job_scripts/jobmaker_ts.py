#!/usr/bin/python
## creates cluster job files with n jobs per file for a batch system
## written by Tim Schäfer
import glob
import os
import fnmatch
import optparse
import re


parser = optparse.OptionParser()
parser.add_option("-f", "--factor", action="store", dest="fact", help="Factor X")
(options, args) = parser.parse_args()

filelist=[]
for file in os.listdir('.'):
    if fnmatch.fnmatch(file, '*.sh'):
        filelist.append(file)

if(len(filelist) > 0):
  print "ERROR: Found " + str(len(filelist)) + " job files which already exist in this directory. Remove them before running this script to avoid confusion."
  exit(1)

num_total_jobs = 8333
num_jobs_per_jobfile = 24
num_jobfiles = num_total_jobs / num_jobs_per_jobfile
num_in_last_file = num_jobs_per_jobfile
if(num_total_jobs % num_jobs_per_jobfile != 0):
  num_in_last_file = num_total_jobs % num_jobs_per_jobfile
  num_jobfiles += 1

print "Handling " + str(num_total_jobs) + " jobs total, " + str(num_jobs_per_jobfile) + " jobs per job file. Creating " + str(num_jobfiles) + " job files. The last file holds " + str(num_in_last_file) + " jobs."



for jobfilenumber in range(num_jobfiles):
  ## jobname looks like "job_loopy_factor_291_310.sh". extract the two numbers from the file name using regex
  lower_border = num_jobs_per_jobfile * jobfilenumber
  upper_border = (num_jobs_per_jobfile * (jobfilenumber + 1)) - 1
  
  if(jobfilenumber == (num_jobfiles - 1)):
    if(num_in_last_file != num_jobs_per_jobfile):
      upper_border = (lower_border + num_in_last_file - 1)
  
  jobname = "job_loopy_factor_" + str(lower_border) + "_" + str(upper_border) + ".sh"
  print " * Creating job file '" + jobname + "', adding jobs " + str(lower_border) + " to " + str(upper_border) + "."
  f = open(jobname,"w")
  f.write("#!/bin/sh\n#SBATCH --ntasks=24\n#SBATCH --nodes=1\n#SBATCH --mem-per-cpu=4000\n#SBATCH --time=03:30:00\n#SBATCH --partition=parallel\n")
	
  for x in range(lower_border,upper_border+1):
    f.write("./job_"+str(x)+"_factor.sh > prg"+str(x)+".out  2>&1 &\n")    
  f.write("wait") 
  f.close()

print "Done. All " + str(num_jobfiles) + " job files created. Exiting."

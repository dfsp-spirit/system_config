#!/usr/bin/python
## This script retrieves the CATH domains in PDB format for a given superfamily. ##
## Use it like this: 'python get_cath_pdb_files.py <c> <a> <t> <h>'
## <c>, <a> , <t>, <h>, ... are the CATH class, architecture, toplogy, homol superfamily. 
## example to get TIM barrels: 'python get_cath_pdb_files.py 3 20 20 150'

## NOTE: You should get the latest version of the CathDomainList.txt file from CATH

## written by Simon Cockel, see https://www.biostars.org/p/2808/
## updated for current Python with argparse by Tim Schäfer

import urllib
import os
import os.path
import argparse


def mymain ( superfamily ):
    #fetch the list of domains in the superfamily from the CathDomainList
    dom_lst = get_domain_list(superfamily)
    #for each domain, retrieve the PDB file from CATH
    get_domain_structures(dom_lst, superfamily)
    return

def get_domain_list(superfamily):
    count = 0
    domain_list = []
    sf_tokens = superfamily.split('.')
    fh = open(os.path.join("CathDomainList.txt"), 'r')
    for line in fh.readlines():
        if not line.startswith('#'):   #exclude comment lines
            tokens = line.rstrip().split()
            #if C, A, T and H match, the domain is a member of the right superfamily
            if int(tokens[1]) == int(sf_tokens[0]) \
              and int(tokens[2]) == int(sf_tokens[1]) \
              and int(tokens[3]) == int(sf_tokens[2]) \
              and int(tokens[4]) == int(sf_tokens[3]):
                domain_list.append(tokens[0])
                count += 1
    print("There are "+str(count)+" domains in superfamily "+superfamily)
    return domain_list

def get_domain_structures(domain_list, superfamily):
    for domain in domain_list:
        #can also get chain and full pdb entries by modifying the URL
        url = 'http://www.cathdb.info/api/data/pdb/'+domain
        pdb = urllib.urlopen(url).read()
        if not os.path.exists(os.path.join('data', 'pdb', superfamily)):
            os.mkdir(os.path.join('data', 'pdb', superfamily))
        out = open(os.path.join('data', 'pdb', superfamily, domain+'.pdb'), 'w')
        out.write(pdb)
    return url


if __name__ == '__main__':
  parser = argparse.ArgumentParser()
  parser.add_argument("c", help="class")
  parser.add_argument("a", help="arch")
  parser.add_argument("t", help="topology")
  parser.add_argument("s", help="homol superfamily")
  args = parser.parse_args()
  sf = args.c+'.'+args.a+'.'+args.t+'.'+args.s
  print sf
  mymain(sf)
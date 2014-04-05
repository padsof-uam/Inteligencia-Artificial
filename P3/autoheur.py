#!/usr/bin/python

import sys
import itertools
import os

inname = sys.argv[1]
infile = open(inname, "r")

contents = infile.read()
infile.close()

heurs = []
par_lev = 0
current_lambda = ""
in_lambda = False
ign_next = False

for i in range(len(contents)):
	if ign_next:
		ign_next = False
		continue

	if contents[i:].startswith("#'(lambda"):
		in_lambda = True
		current_lambda = "#'"
		ign_next = True
		par_lev = 0
		continue

	if in_lambda:
		current_lambda += contents[i]

		if contents[i] == '(':
			par_lev += 1
		elif contents[i] == ')':
			par_lev -= 1
 		
 		if par_lev == 0:
			in_lambda = False
			heurs.append(current_lambda)


combs = []
for l in range(1, len(heurs) + 1):
	combs += itertools.combinations([x.replace(';','') for x in heurs], l)

pnum = 0
for comb in combs:
	heurfile = open("heuristics.cl", "w")
	heurfile.write('(setf *heuristics* (list\n')

	for heur in comb:
		heurfile.write(heur)

	heurfile.write('))')
	heurfile.close()
	os.system("./exec_player")
	pnum += 1
	print 'exec player', pnum
	os.system("./save_player noin")


 

#!/usr/bin/python
import sys
source_name = 'Practica2.lisp'

fin = open(source_name, 'r')
f_general = open('Memoria/Memoria.tex', 'w')

intro = '\documentclass{aitemplate} \n \usepackage{textcomp}\n \usepackage{ai}\n \usepackage{alltt}\n \usepackage{tikz}\n \usepackage{listings} \n \lstset{numbers=left,numberstyle=\\tiny,numbersep=5pt,language=Lisp,  stringstyle=\\ttfamily\small,basicstyle=\\ttfamily\\footnotesize,  showstringspaces=false,breaklines} \n \\begin{document}\n\printtitle{1}'

f_general.write(intro)

f_aux = open('borrame','w')
plantilla = open('plantilla.tex','r')

line = fin.readline()
ignore=0
i=0
pos=0
num_fichero=0

while (line!=''):
	comments=''
	example=''
	name=''
	if ignore != 1:
		#Miramos si tenemos que ignorar algo.
		pos = line.find('Ignore') + len('Ignore ')
		# to_ign = -1 si no se ha encontrado.
		
		# Si tenemos que ignorar
		if pos > len('Ignore '):
			ignore=1
			stop_ignore = line[pos:]
		else:
		# Si no tenemos que ignorar escribimos en donde toque.
			if line[0:4]==';;;;':
				f_aux.close()
				num_fichero+=1
				f_general.write('\input{'+str(num_fichero)+'.tex}')
				f_aux = open('Memoria/'+str(num_fichero)+'.asdf','w')
			else:				
				#ahora tenemos que ir rellenando la plantilla.				
				comments=line
				while line.find(';; end'):
					if line.find('defun') > 0:
						name=line[line.find('defun')+len('defun '):]
					elif line.find('(') > 0:
						example=line
					if line.find(';;') == -1:
						f_aux.write(line)
					else:
						f_aux.write(line[3:])

					line = fin.readline()
							
				print 'name: ',name,'\t','ejemplos: ',example
				#end while


	elif stop_ignore == line[0:len(stop_ignore)]:
		#si estamos ignorando:
		i=i+1
		ignore=0

	line = fin.readline()
	line.replace('#','\#')
	line.replace('_','\_')
		

#Indentacion para indicar final del bucle.




f_general.write('\end{document}')

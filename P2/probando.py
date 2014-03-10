#!/usr/bin/python
import sys
source_name = 'Practica2.lisp'

fin = open(source_name, 'r')
plantilla = open('plantilla.tex','r')
f_general = open('Memoria/Memoria.tex', 'w')

f_aux = open('borrame','w')

intro = '\documentclass{aitemplate} \n \usepackage{textcomp}\n \usepackage{ai}\n \usepackage{alltt}\n \usepackage{tikz}\n \usepackage{listings} \n \lstset{numbers=left,numberstyle=\\tiny,numbersep=5pt,language=Lisp,  stringstyle=\\ttfamily\small,basicstyle=\\ttfamily\\footnotesize,  showstringspaces=false,breaklines} \n \\begin{document}\n\printtitle{1}'

f_general.write(intro)
line = fin.readline()
ignore=0
i=0
pos=0
num_fichero=0



while (line!=''):
	
	ended=0
	writed=0
	comments=''
	syntax=''
	pseudocode=''
	code=''
	to_write_aux=''
	examples=''

	print ignore
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
			print 'line: ',line[0:4]
			if line[0:4]==';;;;':

				f_aux.close()
				num_fichero+=1
				f_general.write('\input{'+str(num_fichero)+'.tex}')
				f_aux = open('Memoria/'+str(num_fichero)+'.tex','w')
				print ('asdf')
				f_aux.write('asdf')
				to_write_aux = plantilla.read()
			else:				
				while(ended==0):
					if line.find('IN:') == -1 and writed == 0:
						comments += line[2:]
					else:
						to_write_aux.replace('__COMENTS__',comments)
						writed = 1;
						syntax+=line[2:]	
					aux_reader = fin.readline()
					print('comments'+comments)
					# IN,OUT
					while(aux_reader.find('pseudocode') == -1):
						syntax += aux_reader
						aux_reader = fin.readline()

					to_write_aux.replace('__SYNTAX__',syntax)

					## Pseudocodigo
					aux_reader = fin.readline()
					while aux_reader.find(';;')==-1:
						pseudocode+=aux_reader
						aux_reader = fin.readline()

					to_write_aux+=pseudocode
					to_write_aux.replace('__pseudocodigo__',pseudocode)

					## Codigo
					aux_reader = fin.readline()
					while aux_reader.find(';; Examples') == -1:
						code += aux_reader
						aux_reader = fin.readline()

					to_write_aux.replace('__codigo__',code)

					## Examples
					
					aux_reader = fin.readline()
					while aux_reader.find(';; end') == -1:	
						examples+=aux_reader
						aux_reader = fin.readline()

					to_write_aux.replace('__EJEMPLOS__',examples)

					ended=1

				
				to_write_aux+=comments
				to_write_aux+=syntax
				to_write_aux+=code
				to_write_aux+=to_write_aux
				to_write_aux+=examples
				to_write_aux+=syntax

				f_aux.write(to_write_aux)


	elif stop_ignore == line[0:len(stop_ignore)]:
		#si estamos ignorando:
		i=i+1
		ignore=0

	line = fin.readline()
	print line
		

#Indentacion para indicar final del bucle.




f_general.write('\end{document}')
fin.close()
plantilla.close()
f_aux.close()

#!/usr/bin/python
import sys
	source_name = 'Practica2.lisp'
lines=[]
fin = open(source_name, 'r')
f_general = open('Memoria/Memoria.tex', 'w')
practica=2
intro = '\documentclass{aitemplate} \n \usepackage{textcomp}\n \usepackage{ai}\n \usepackage{alltt}\n \usepackage{tikz}\n \usepackage{listings} \n \lstset{numbers=left,numberstyle=\\tiny,numbersep=5pt,language=Lisp,  stringstyle=\\ttfamily\small,basicstyle=\\ttfamily\\footnotesize,  showstringspaces=false,breaklines} \n \\begin{document}\n\printtitle{'+str(practica)+'}\section{Ejercicios}'

f_general.write(intro)
f_aux = open('borrame','w')
line = fin.readline()
ignore=0
i=0
pos=0
num_fichero=0
while (line!=''):
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
				f_general.write('\subsection*{Ejercicio '+str(num_fichero)+'}')
				f_general.write('\input{'+str(num_fichero)+'.tex}\n\\newpage')
				f_aux = open('Memoria/'+str(num_fichero)+'.code','w')
			else:				
				#ahora tenemos que ir rellenando la plantilla.
				f_aux.write(line)
	elif stop_ignore == line[0:len(stop_ignore)]:
		#si estamos ignorando:
		i=i+1
		ignore=0
	line = fin.readline()

f_aux.close()
		


#########GENERADOS LOS .CODE VAMOS A INTERPRETAR

#Indentacion para indicar final del bucle.
#plantilla= [x for x in open('plantilla.tex','r').readline()]

plantilla = open('plantilla.tex','r').read()
plantilla_aux = plantilla
comments=''
ejemplos=''
pseudocodigo=''
codigo=''
nombre=''
syntax=''

for i in xrange(1,num_fichero+1):

	fcode = open('Memoria/'+str(i)+'.code','r')
	todo = fcode.readlines()
	print i,num_fichero
	if i==10:
		print todo
	comments=''
	ejemplos=''
	pseudocodigo=''
	codigo=''
	nombre=''
	syntax=''
	end_aux=0
	j=0

	#Generacion de lo interesante
	while j < len(todo):
		if  comments == '' and len(todo[j])!=1:
			while todo[j].find('IN:') == -1:
				comments+= todo[j][3:]
				j+=1
				#print j,todo[j]
			j-=1
		elif syntax=='' and todo[j].find('IN:')>0:
			while end_aux == 0:
				syntax+=todo[j][3:]
				j+=1
				if todo[j].find('OUT:') > 0:
					end_aux=1
					syntax+=todo[j][3:]
		elif syntax!='' and pseudocodigo=='':
			while todo[j].find(';;') != -1:
				if todo[j].find('pseudocode')==-1:
					pseudocodigo+=todo[j][3:]
				j += 1;
		elif todo[j].find('Examples') != -1:
			while todo[j].find(';; end') == -1:
				if todo[j].find(';;') != -1:
					ejemplos += todo[j][3:]
				else :
					ejemplos += todo[j]
				j+=1
		elif todo[j].find(';;') == -1:
			if codigo=='':
				name = todo[j][todo[j].find('defun ')+len('defun '):]
			codigo += todo[j]
			if todo[j].find('defun')!=-1:
				name = todo[j][todo[j].find('defun ')+len('defun '):]
			print todo[j],todo[j].find('defun')
		j += 1
#			a=2
	#Generacion del tex
	ftex = open('Memoria/'+str(i)+'.tex','w')
	plantilla_aux = plantilla
	plantilla_aux=plantilla_aux.replace('__COMMENTS__',comments.replace('_','\_').replace('#','\#'))
	plantilla_aux=plantilla_aux.replace('__SYNTAX__',syntax.replace('_','\_').replace('#','\#'))
	plantilla_aux=plantilla_aux.replace('__PSEUDOCODIGO__',pseudocodigo.replace('_','\_').replace('#','\#'))
	plantilla_aux=plantilla_aux.replace('__EJEMPLOS__',ejemplos.replace('_','\_').replace('#','\#'))
	plantilla_aux=plantilla_aux.replace('__CODIGO__',codigo.replace('_','\_').replace('#','\#'))
	plantilla_aux=plantilla_aux.replace('__NOMBRE__',name.replace('_','\_').replace('#','\#'))


	ftex.write(plantilla_aux)
	fcode.close()
	ftex.close()


f_general.write('\section{Preguntas}')
f_general.write('\input{salva/preguntas.tex}')
f_general.write('\end{document}')

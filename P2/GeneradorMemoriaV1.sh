#Clean
functions=$(ls Memoria/*code)
for fun in $functions; do
	name_arg=$(cat $fun | grep defun | awk -v FS="defun " '{print $2}')
	name=$(echo $name_arg | cut -d '(' -f 1 | cut -d ' ' -f 1)
	echo $name_arg
	echo $name
	echo "\\\begin{aibox}{\\\function}" > Memoria/$name.tex
	echo ";; $name" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "SYNTAX: $name_arg" >> Memoria/$name.tex
	echo "\end{aibox}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex	
	echo "\\\begin{aibox}{\examples}" >> Memoria/$name.tex
	echo "\\\begin{alltt}" >> Memoria/$name.tex
	echo "\end{alltt}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "\end{aibox}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "\\\begin{aibox}{\\\comments}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "\end{aibox}" >> Memoria/$name.tex
	echo "\\\begin{aibox}{\\\answers}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "\end{aibox}" >> Memoria/$name.tex
	echo "\\\begin{aibox}{\othercomments}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "\end{aibox}" >> Memoria/$name.tex
	echo "\\\begin{aibox}{\pseudocode}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	echo "\end{aibox}" >> Memoria/$name.tex
	echo "\\\begin{aibox}{\\\code}" >> Memoria/$name.tex
	echo >> Memoria/$name.tex
	#Con verbatim no hace falta.
	#sed -i 's/#/\\#/g' $fun
	sed -i ':a;N;$!ba;s/\t/    /g' $fun
	echo "\\\begin{alltt}" >> Memoria/$name.tex
	cat $fun >> Memoria/$name.tex
	echo "\end{alltt}" >> Memoria/$name.tex

	echo "\end{aibox}" >> Memoria/$name.tex
done

	cat << EOF  > Memoria.tex
\\documentclass{aitemplate}

\\usepackage{ai}
\\usepackage{alltt}


\\begin{document}

\\printtitle{1}
EOF

texs=$(ls Memoria/*.tex)
echo $texs
for tex in $texs; do
	echo "\input{$tex}" >> Memoria.tex
	echo "\\\newpage">>Memoria.tex
done

echo "\end{document}" >> Memoria.tex

echo Source generated.

echo Generating pdf...
latexmk -pdf -f -silent Memoria.tex

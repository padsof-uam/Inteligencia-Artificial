#Clean
rm Memoria/*
rm Memoria.*
files_lsp=$(ls *.lsp)
echo $files_lsp
for file in $files_lsp ; do
	#functions=$(cat $file | grep defun | awk -v FS="defun " '{print $2}')
	#echo $functions
	#IFS="\n"
	codes=$(awk '/;;%%/{n++}{print > f n}' f=code $file)
	functions=$(ls code*)
	for fun in $functions; do
		name_arg=$(cat $fun | grep defun | awk -v FS="defun " '{print $2}')
		name=$(echo $name_arg | cut -d '(' -f 1 | cut -d ' ' -f 1)
		echo $name
		echo "\\\begin{aibox}{\\\function}" > Memoria/$name.tex
		echo ";; $name" >> Memoria/$name.tex
		echo >> Memoria/$name.tex
		echo "SYNTAX: $name_arg" >> Memoria/$name.tex
		echo "\end{aibox}" >> Memoria/$name.tex
		echo >> Memoria/$name.tex	
		echo "\\\begin{aibox}{\examples}" >> Memoria/$name.tex
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
		cat $fun >> Memoria/$name.tex
		echo "\end{aibox}" >> Memoria/$name.tex
	done
done


	cat << EOF  > Memoria.tex
\\documentclass{aitemplate}

\\usepackage{ai}

\\begin{document}

\\printtitle{1}
EOF

texs=$(ls Memoria/*.tex)
for tex in $texs; do
	echo "\input{$tex}" >> Memoria.tex
done

echo "\end{document}" >> Memoria.tex

echo Source generated.
echo Cleaning auxiliary files
rm code*
echo Generating pdf...
latexmk -pdf -f -silent Memoria.tex



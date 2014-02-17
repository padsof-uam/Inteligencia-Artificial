#Clean
rm Memoria/*
rm Memoria.*
files_lsp=$(ls *.lisp)
echo $files_lsp
for file in $files_lsp ; do
	codes=$(awk '/;;%%/{n++}{print > f n}' f=code $file)
	functions=$(ls code*)
	for fun in $functions; do
		name_arg=$(cat $fun | grep defun | awk -v FS="defun " '{print $2}')
		name=$(echo $name_arg | cut -d '(' -f 1 | cut -d ' ' -f 1)
		echo "\\\begin{aibox}{\\\function}" > Memoria/$file$name.tex
		echo ";; $name" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "SYNTAX: $name_arg" >> Memoria/$file$name.tex
		echo "\end{aibox}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex	
		echo "\\\begin{aibox}{\examples}" >> Memoria/$file$name.tex
		echo "\\\begin{alltt}" >> Memoria/$file$name.tex
		echo "\end{alltt}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "\end{aibox}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "\\\begin{aibox}{\\\comments}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "\end{aibox}" >> Memoria/$file$name.tex
		echo "\\\begin{aibox}{\\\answers}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "\end{aibox}" >> Memoria/$file$name.tex
		echo "\\\begin{aibox}{\othercomments}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "\end{aibox}" >> Memoria/$file$name.tex
		echo "\\\begin{aibox}{\pseudocode}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		echo "\end{aibox}" >> Memoria/$file$name.tex
		echo "\\\begin{aibox}{\\\code}" >> Memoria/$file$name.tex
		echo >> Memoria/$file$name.tex
		#Con verbatim no hace falta.
		#sed -i 's/#/\\#/g' $fun
		sed -i ':a;N;$!ba;s/\t/    /g' $fun
		echo "\\\begin{alltt}" >> Memoria/$file$name.tex
		cat $fun >> Memoria/$file$name.tex
		echo "\end{alltt}" >> Memoria/$file$name.tex

		echo "\end{aibox}" >> Memoria/$file$name.tex
	done
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
echo Cleaning auxiliary files
rm code*
echo Generating pdf...
latexmk -pdf -f -silent Memoria.tex



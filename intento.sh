files_lsp=$(ls *.lsp)
echo $files_lsp
for file in $files_lsp ; do
	functions=$(cat $file | grep defun | awk -v FS="defun " '{print $2}')
	for fun in $functions; do
		echo "\documentclass{aitemplate}" > $Memoria/fun.tex
		echo "\usepackage{ai}" >> $Memoria/fun.tex

		echo "\begin{document}" >> $Memoria/fun.tex

		echo "\printtitle{1}" >> $Memoria/fun.tex

		name=$(echo $fun | 	cut -d '(' -f 1)

		echo "\begin{aibox}{\function}" >> $Memoria/fun.tex
		echo ";; $name" >> $Memoria/fun.tex
		echo "SYNTAX: $fun" >> $Memoria/fun.tex
		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\begin{aibox}{\examples}" >> $Memoria/fun.tex

		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\begin{aibox}{\comments}" >> $Memoria/fun.tex

		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\begin{aibox}{\answers}" >> $Memoria/fun.tex

		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\begin{aibox}{\othercomments}" >> $Memoria/fun.tex

		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\begin{aibox}{\pseudocode}" >> $Memoria/fun.tex

		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\begin{aibox}{\code}" >> $Memoria/fun.tex

		echo "\end{aibox}" >> $Memoria/fun.tex

		echo "\end{document}" >> $Memoria/fun.tex
	done
done
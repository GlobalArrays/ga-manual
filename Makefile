MANUAL_DEPS =
MANUAL_DEPS += AppendixA.tex
MANUAL_DEPS += AppendixB.tex
MANUAL_DEPS += AppendixC.tex
MANUAL_DEPS += cluster.png
MANUAL_DEPS += copy1.png
MANUAL_DEPS += copy2.png
MANUAL_DEPS += distr-1.png
MANUAL_DEPS += distr-2.png
MANUAL_DEPS += GA_get_example.png
MANUAL_DEPS += GA_Get.png
MANUAL_DEPS += GAon16ProcessorsAlternative.png
MANUAL_DEPS += GAon16Processors.png
MANUAL_DEPS += GAon36Processors.png
MANUAL_DEPS += GA-UserManual-Main.tex
MANUAL_DEPS += ghost003.png
MANUAL_DEPS += ghost006.png
MANUAL_DEPS += ghost012.png
MANUAL_DEPS += ghost015.png
MANUAL_DEPS += groups.png
MANUAL_DEPS += mirrored.png
MANUAL_DEPS += mpif.tex
MANUAL_DEPS += mpic.tex
MANUAL_DEPS += mod.png
MANUAL_DEPS += periodic1.png
MANUAL_DEPS += periodic2.png
MANUAL_DEPS += periodic3.png
MANUAL_DEPS += periodic4.png
MANUAL_DEPS += periodic5.png
MANUAL_DEPS += replace_ma.tex
MANUAL_DEPS += scatter-GA.png
MANUAL_DEPS += Section10-ProcessorGroups.tex
MANUAL_DEPS += Section11-SparseDataOperations.tex
MANUAL_DEPS += Section12-Restricted-Arrays.tex
MANUAL_DEPS += Section1-Introduction.tex
MANUAL_DEPS += Section2-WritingBuildRunGAProg.tex
MANUAL_DEPS += Section3-Initialization-Termination.tex
MANUAL_DEPS += Section4-One-SideComm_Operations.tex
MANUAL_DEPS += Section5-InterprocessSync.tex
MANUAL_DEPS += Section6-CollectiveArrayOperations.tex
MANUAL_DEPS += Section7-UtilityOperations.tex
MANUAL_DEPS += Section8-GA-CplusBindingsforGA.tex
MANUAL_DEPS += Section9-MirroredArrays.tex
MANUAL_DEPS += Set_Block_Cyclic.png
MANUAL_DEPS += Set_Block_Cyclic_Proc_Grid.png
MANUAL_DEPS += sparse-a.png
MANUAL_DEPS += sparse-b.png
MANUAL_DEPS += sparse-c.png
MANUAL_DEPS += sparse-d.png
MANUAL_DEPS += tcgmsgf.tex
MANUAL_DEPS += tcgmsgc.tex
MANUAL_DEPS += topo.png

# these flags produce a single, large page
LATEX2HTML_FLAGS = -split 0 -no_navigation

#all: GA-UserManual-Main.pdf GA-UserManual-Main/index.html

GA-UserManual-Main.pdf: $(MANUAL_DEPS)
	pdflatex GA-UserManual-Main.tex

GA-UserManual-Main/index.html: $(MANUAL_DEPS)
	latex2html $(LATEX2HTML_FLAGS) GA-UserManual-Main.tex

mpif.tex: mpi.f
	pygmentize -f latex -o $@ mpi.f || (echo "\begin{verbatim}" > $@ && cat mpi.f >> $@ && echo "\end{verbatim}" >> $@)
	
mpic.tex: mpi.c
	pygmentize -f latex -o $@ mpi.c || (echo "\begin{verbatim}" > $@ && cat mpi.f >> $@ && echo "\end{verbatim}" >> $@)

tcgmsgf.tex: tcgmsg.f
	pygmentize -f latex -o $@ tcgmsg.f || (echo "\begin{verbatim}" > $@ && cat tcgmsg.f >> $@ && echo "\end{verbatim}" >> $@)
	
tcgmsgc.tex: tcgmsg.c
	pygmentize -f latex -o $@ tcgmsg.c || (echo "\begin{verbatim}" > $@ && cat tcgmsg.f >> $@ && echo "\end{verbatim}" >> $@)

replace_ma.tex: replace_ma.c
	pygmentize -f latex -o $@ replace_ma.c || (echo "\begin{verbatim}" > $@ && cat replace_ma.f >> $@ && echo "\end{verbatim}" >> $@)

clean:
	rm -f mpic.tex
	rm -f mpif.tex
	rm -f tcgmsgc.tex
	rm -f tcgmsgf.tex
	rm -f replace_ma.tex
	rm -f GA-UserManual-Main.pdf
	rm -rf GA-UserManual-Main/
	rm -f *.aux *.log *.out *.toc

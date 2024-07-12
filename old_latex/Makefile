IMAGEDIR = ../images
CODEDIR  = ../code

MANUAL_DEPS =
MANUAL_DEPS += AppendixA.tex
MANUAL_DEPS += AppendixB.tex
MANUAL_DEPS += AppendixC.tex
MANUAL_DEPS += $(IMAGEDIR)/cluster.png
MANUAL_DEPS += $(IMAGEDIR)/copy1.png
MANUAL_DEPS += $(IMAGEDIR)/copy2.png
MANUAL_DEPS += $(IMAGEDIR)/distr-1.png
MANUAL_DEPS += $(IMAGEDIR)/distr-2.png
MANUAL_DEPS += $(IMAGEDIR)/GA_get_example.png
MANUAL_DEPS += $(IMAGEDIR)/GA_Get.png
MANUAL_DEPS += $(IMAGEDIR)/GAon16ProcessorsAlternative.png
MANUAL_DEPS += $(IMAGEDIR)/GAon16Processors.png
MANUAL_DEPS += $(IMAGEDIR)/GAon36Processors.png
MANUAL_DEPS += GA-UserManual-Main.tex
MANUAL_DEPS += $(IMAGEDIR)/ghost003.png
MANUAL_DEPS += $(IMAGEDIR)/ghost006.png
MANUAL_DEPS += $(IMAGEDIR)/ghost012.png
MANUAL_DEPS += $(IMAGEDIR)/ghost015.png
MANUAL_DEPS += $(IMAGEDIR)/groups.png
MANUAL_DEPS += $(IMAGEDIR)/mirrored.png
MANUAL_DEPS += mpif.tex
MANUAL_DEPS += mpic.tex
MANUAL_DEPS += $(IMAGEDIR)/mod.png
MANUAL_DEPS += $(IMAGEDIR)/periodic1.png
MANUAL_DEPS += $(IMAGEDIR)/periodic2.png
MANUAL_DEPS += $(IMAGEDIR)/periodic3.png
MANUAL_DEPS += $(IMAGEDIR)/periodic4.png
MANUAL_DEPS += $(IMAGEDIR)/periodic5.png
MANUAL_DEPS += replace_ma.tex
MANUAL_DEPS += $(IMAGEDIR)/scatter-GA.png
MANUAL_DEPS += Section9-ProcessorGroups.tex
MANUAL_DEPS += Section10-SparseDataOperations.tex
MANUAL_DEPS += Section11-Restricted-Arrays.tex
MANUAL_DEPS += Section12-Sparse-Arrays.tex
MANUAL_DEPS += Section1-Introduction.tex
# MANUAL_DEPS += Section2-WritingBuildRunGAProg.tex
MANUAL_DEPS += Section2-Initialization-Termination.tex
MANUAL_DEPS += Section3-One-SideComm_Operations.tex
MANUAL_DEPS += Section4-InterprocessSync.tex
MANUAL_DEPS += Section5-CollectiveArrayOperations.tex
MANUAL_DEPS += Section6-UtilityOperations.tex
MANUAL_DEPS += Section7-GA-CplusBindingsforGA.tex
MANUAL_DEPS += Section8-MirroredArrays.tex
MANUAL_DEPS += $(IMAGEDIR)/Set_Block_Cyclic.png
MANUAL_DEPS += $(IMAGEDIR)/Set_Block_Cyclic_Proc_Grid.png
MANUAL_DEPS += $(IMAGEDIR)/sparse-a.png
MANUAL_DEPS += $(IMAGEDIR)/sparse-b.png
MANUAL_DEPS += $(IMAGEDIR)/sparse-c.png
MANUAL_DEPS += $(IMAGEDIR)/sparse-d.png
MANUAL_DEPS += tcgmsgf.tex
MANUAL_DEPS += tcgmsgc.tex
MANUAL_DEPS += $(IMAGEDIR)/topo.png

# these flags produce a single, large page
LATEX2HTML_FLAGS = -split 0 -no_navigation

#all: GA-UserManual-Main.pdf GA-UserManual-Main/index.html

# run pdflatex twice in case references need to be updated
GA-UserManual-Main.pdf: $(MANUAL_DEPS)
	pdflatex GA-UserManual-Main.tex
	pdflatex GA-UserManual-Main.tex

# GA-UserManual-Main/index.html: $(MANUAL_DEPS)
# 	latex2html $(LATEX2HTML_FLAGS) GA-UserManual-Main.tex

mpif.tex: $(CODEDIR)/mpi.f
	pygmentize -f latex -o $@ $(CODEDIR)/mpi.f || (echo "\begin{verbatim}" > $@ && cat $(CODEDIR)/mpi.f >> $@ && echo "\end{verbatim}" >> $@)
	
mpic.tex: $(CODEDIR)/mpi.c
	pygmentize -f latex -o $@ $(CODEDIR)/mpi.c || (echo "\begin{verbatim}" > $@ && cat $(CODEDIR)/mpi.f >> $@ && echo "\end{verbatim}" >> $@)

tcgmsgf.tex: $(CODEDIR)/tcgmsg.f
	pygmentize -f latex -o $@ $(CODEDIR)/tcgmsg.f || (echo "\begin{verbatim}" > $@ && cat $(CODEDIR)/tcgmsg.f >> $@ && echo "\end{verbatim}" >> $@)
	
tcgmsgc.tex: $(CODEDIR)/tcgmsg.c
	pygmentize -f latex -o $@ $(CODEDIR)/tcgmsg.c || (echo "\begin{verbatim}" > $@ && cat $(CODEDIR)/tcgmsg.f >> $@ && echo "\end{verbatim}" >> $@)

replace_ma.tex: $(CODEDIR)/replace_ma.c
	pygmentize -f latex -o $@ $(CODEDIR)/replace_ma.c || (echo "\begin{verbatim}" > $@ && cat $(CODEDIR)/replace_ma.f >> $@ && echo "\end{verbatim}" >> $@)

clean:
	rm -f mpic.tex
	rm -f mpif.tex
	rm -f tcgmsgc.tex
	rm -f tcgmsgf.tex
	rm -f replace_ma.tex
	rm -f GA-UserManual-Main.pdf
	rm -rf GA-UserManual-Main/
	rm -f *.aux *.log *.out *.toc

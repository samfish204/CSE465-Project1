all: check

check: check-challenging check-veryhard 

%.output: %.pl 
	swipl -q -g check -g halt  $*.pl > $*.output 

check-%: %.output
	cmp $*.output $*.expected
	@echo $*- Success!



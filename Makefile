all: check

check: check-challenging check-veryhard check-easy

%.output: %.pl 
	swipl -q -g check -g halt  $*.pl > $*.output 

check-%: %.output
	cmp $*.output $*.expected
	@echo $*- Success!


update: update-http

update-ssh:
	git pull  git@gitlab.csi.miamioh.edu:CSE465/instructor/project1.git master
	
update-http:
	git pull  https://gitlab.csi.miamioh.edu/CSE465/instructor/project1.git master

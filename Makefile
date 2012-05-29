#############################################################################
##  v      #                   The Coq Proof Assistant                     ##
## <O___,, #                INRIA - CNRS - LIX - LRI - PPS                 ##
##   \VV/  #                                                               ##
##    //   #  Makefile automagically generated by coq_makefile Vtrunk      ##
#############################################################################

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING

#
# This Makefile was generated by the command line :
# coq_makefile -f Make -o Makefile
#

.DEFAULT_GOAL := all

# 
# This Makefile may take arguments passed as environment variables:
# COQBIN to specify the directory where Coq binaries resides;
# ZDEBUG/COQDEBUG to specify debug flags for ocamlc&ocamlopt/coqc;
# DSTROOT to specify a prefix to install path.

# Here is a hack to make $(eval $(shell works:
define donewline


endef
includecmdwithout@ = $(eval $(subst @,$(donewline),$(shell { $(1) | tr '\n' '@'; })))
$(call includecmdwithout@,$(COQBIN)coqtop -config)

##########################
#                        #
# Libraries definitions. #
#                        #
##########################

OCAMLLIBS?=-I src
COQLIBS?=-I src -R theories Counting
COQDOCLIBS?=-R theories Counting

##########################
#                        #
# Variables definitions. #
#                        #
##########################

CAMLP4OPTIONS=-loc loc
COQDOC=$(COQBIN)coqdoc -interpolate -utf8
COUNTING_PLUGINOPT=src/counting_plugin.cmxs
COUNTING_PLUGIN=src/counting_plugin.cma

OPT?=
COQDEP?=$(COQBIN)coqdep -c
COQFLAGS?=-q $(OPT) $(COQLIBS) $(OTHERFLAGS) $(COQ_XML)
COQCHKFLAGS?=-silent -o
COQDOCFLAGS?=-interpolate -utf8
COQC?=$(COQBIN)coqc
GALLINA?=$(COQBIN)gallina
COQDOC?=$(COQBIN)coqdoc
COQCHK?=$(COQBIN)coqchk

COQSRCLIBS?=-I $(COQLIB)kernel -I $(COQLIB)lib \
  -I $(COQLIB)library -I $(COQLIB)parsing \
  -I $(COQLIB)pretyping -I $(COQLIB)interp \
  -I $(COQLIB)printing -I $(COQLIB)intf \
  -I $(COQLIB)proofs -I $(COQLIB)tactics \
  -I $(COQLIB)toplevel -I $(COQLIB)grammar \
  -I $(COQLIB)plugins/btauto \
  -I $(COQLIB)plugins/cc \
  -I $(COQLIB)plugins/decl_mode \
  -I $(COQLIB)plugins/extraction \
  -I $(COQLIB)plugins/field \
  -I $(COQLIB)plugins/firstorder \
  -I $(COQLIB)plugins/fourier \
  -I $(COQLIB)plugins/funind \
  -I $(COQLIB)plugins/micromega \
  -I $(COQLIB)plugins/nsatz \
  -I $(COQLIB)plugins/omega \
  -I $(COQLIB)plugins/quote \
  -I $(COQLIB)plugins/ring \
  -I $(COQLIB)plugins/romega \
  -I $(COQLIB)plugins/rtauto \
  -I $(COQLIB)plugins/setoid_ring \
  -I $(COQLIB)plugins/syntax \
  -I $(COQLIB)plugins/xml
ZFLAGS=$(OCAMLLIBS) $(COQSRCLIBS) -I $(CAMLP4LIB)

CAMLC?=$(OCAMLC) -c -rectypes
CAMLOPTC?=$(OCAMLOPT) -c -rectypes
CAMLLINK?=$(OCAMLC) -rectypes
CAMLOPTLINK?=$(OCAMLOPT) -rectypes
GRAMMARS?=grammar.cma
CAMLP4EXTEND?=pa_extend.cmo pa_macro.cmo q_MLast.cmo
CAMLP4OPTIONS?=-loc loc
PP?=-pp "$(CAMLP4BIN)$(CAMLP4)o -I $(CAMLLIB) -I . $(COQSRCLIBS) $(CAMLP4EXTEND) $(GRAMMARS) $(CAMLP4OPTIONS) -impl"

##################
#                #
# Install Paths. #
#                #
##################

ifdef USERINSTALL
XDG_DATA_HOME?=$(HOME)/.local/share
COQLIBINSTALL=$(XDG_DATA_HOME)/coq
COQDOCINSTALL=$(XDG_DATA_HOME)/doc/coq
else
COQLIBINSTALL=${COQLIB}user-contrib
COQDOCINSTALL=${DOCDIR}user-contrib
endif

######################
#                    #
# Files dispatching. #
#                    #
######################

VFILES:=tests/TestCounting.v\
  theories/Counting.v

-include $(addsuffix .d,$(VFILES))
.SECONDARY: $(addsuffix .d,$(VFILES))

VOFILES:=$(VFILES:.v=.vo)
VOFILES1=$(patsubst theories/%,%,$(filter theories/%,$(VOFILES)))
GLOBFILES:=$(VFILES:.v=.glob)
VIFILES:=$(VFILES:.v=.vi)
GFILES:=$(VFILES:.v=.g)
HTMLFILES:=$(VFILES:.v=.html)
GHTMLFILES:=$(VFILES:.v=.g.html)
ML4FILES:=src/counting.ml4

-include $(addsuffix .d,$(ML4FILES))
.SECONDARY: $(addsuffix .d,$(ML4FILES))

MLFILES:=src/counting_plugin_mod.ml

-include $(addsuffix .d,$(MLFILES))
.SECONDARY: $(addsuffix .d,$(MLFILES))

ALLCMOFILES:=$(ML4FILES:.ml4=.cmo) $(MLFILES:.ml=.cmo)
CMOFILES=$(filter-out $(addsuffix .cmo,$(foreach lib,$(MLLIBFILES:.mllib=_MLLIB_DEPENDENCIES) $(MLPACKFILES:.mlpack=_MLPACK_DEPENDENCIES),$($(lib)))),$(ALLCMOFILES))
CMOFILESINC=$(filter $(wildcard src/*),$(CMOFILES))
CMXFILES=$(CMOFILES:.cmo=.cmx)
OFILES=$(CMXFILES:.cmx=.o)
CMIFILES=$(ALLCMOFILES:.cmo=.cmi)
CMIFILESINC=$(filter $(wildcard src/*),$(CMIFILES))
CMXSFILES=$(CMXFILES:.cmx=.cmxs)
CMXSFILESINC=$(filter $(wildcard src/*),$(CMXSFILES))

#######################################
#                                     #
# Definition of the toplevel targets. #
#                                     #
#######################################

all: $(VOFILES) $(CMOFILES) $(if ifeq '$(HASNATDYNLINK)' 'true',$(CMXSFILES)) src/counting_plugin.cma\
  src/counting_plugin.cmxs

spec: $(VIFILES)

gallina: $(GFILES)

html: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc $(COQDOCFLAGS) -html $(COQDOCLIBS) -d html $(VFILES)

gallinahtml: $(GLOBFILES) $(VFILES)
	- mkdir -p html
	$(COQDOC) -toc $(COQDOCFLAGS) -html -g $(COQDOCLIBS) -d html $(VFILES)

all.ps: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -ps $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

all-gal.ps: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -ps -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

all.pdf: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -pdf $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

all-gal.pdf: $(VFILES)
	$(COQDOC) -toc $(COQDOCFLAGS) -pdf -g $(COQDOCLIBS) -o $@ `$(COQDEP) -sort -suffix .v $^`

validate: $(VOFILES)
	$(COQCHK) $(COQCHKFLAGS) $(COQLIBS) $(notdir $(^:.vo=))

beautify: $(VFILES:=.beautified)
	for file in $^; do mv $${file%.beautified} $${file%beautified}old && mv $${file} $${file%.beautified}; done
	@echo 'Do not do "make clean" until you are sure that everything went well!'
	@echo 'If there were a problem, execute "for file in $$(find . -name \*.v.old -print); do mv $${file} $${file%.old}; done" in your shell/'

.PHONY: all opt byte archclean clean install userinstall depend html validate

###################
#                 #
# Custom targets. #
#                 #
###################

%.vo %.glob: %.v $(COUNTING_PLUGINOPT) $(COUNTING_PLUGIN)
	$(COQBIN)coqc $(COQDEBUG) $(COQFLAGS) $*

src/counting_plugin.cma: src/counting.cmo src/counting_plugin_mod.cmo
	$(CAMLLINK) -g -a -o src/counting_plugin.cma src/counting.cmo src/counting_plugin_mod.cmo

src/counting_plugin.cmxs: src/counting.cmx src/counting_plugin_mod.cmx
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o src/counting_plugin.cmxs src/counting.cmx src/counting_plugin_mod.cmx

####################
#                  #
# Special targets. #
#                  #
####################

byte:
	$(MAKE) all "OPT:=-byte"

opt:
	$(MAKE) all "OPT:=-opt"

userinstall:
	+$(MAKE) USERINSTALL=true install

install-natdynlink:
	install -d $(DSTROOT)$(COQLIBINSTALL)/Counting; \
	for i in $(CMXSFILESINC); do \
	 install -m 0644 $$i $(DSTROOT)$(COQLIBINSTALL)/Counting/`basename $$i`; \
	done

install:$(if ifeq '$(HASNATDYNLINK)' 'true',install-natdynlink)
	cd theories; for i in $(VOFILES1); do \
	 install -d `dirname $(DSTROOT)$(COQLIBINSTALL)/Counting/$$i`; \
	 install -m 0644 $$i $(DSTROOT)$(COQLIBINSTALL)/Counting/$$i; \
	done
	install -d $(DSTROOT)$(COQLIBINSTALL)/Counting; \
	for i in $(CMOFILESINC); do \
	 install -m 0644 $$i $(DSTROOT)$(COQLIBINSTALL)/Counting/`basename $$i`; \
	done
	install -d $(DSTROOT)$(COQLIBINSTALL)/Counting; \
	for i in $(CMIFILESINC); do \
	 install -m 0644 $$i $(DSTROOT)$(COQLIBINSTALL)/Counting/`basename $$i`; \
	done

install-doc:
	install -d $(DSTROOT)$(COQDOCINSTALL)/Counting/html
	for i in html/*; do \
	 install -m 0644 $$i $(DSTROOT)$(COQDOCINSTALL)/Counting/$$i;\
	done

clean:
	rm -f $(ALLCMOFILES) $(CMIFILES) $(CMAFILES)
	rm -f $(ALLCMOFILES:.cmo=.cmx) $(CMXAFILES) $(CMXSFILES) $(ALLCMOFILES:.cmo=.o) $(CMXAFILES:.cmxa=.a)
	rm -f $(addsuffix .d,$(MLFILES) $(MLIFILES) $(ML4FILES) $(MLLIBFILES) $(MLPACKFILES))
	rm -f $(VOFILES) $(VIFILES) $(GFILES) $(VFILES:.v=.v.d) $(VFILES:=.beautified) $(VFILES:=.old)
	rm -f all.ps all-gal.ps all.pdf all-gal.pdf all.glob $(VFILES:.v=.glob) $(VFILES:.v=.tex) $(VFILES:.v=.g.tex) all-mli.tex
	- rm -rf html mlihtml
	- rm -rf src/counting_plugin.cma
	- rm -rf src/counting_plugin.cmxs

archclean:
	rm -f *.cmx *.o

printenv:
	@$(COQBIN)coqtop -config
	@echo CAMLC =	$(CAMLC)
	@echo CAMLOPTC =	$(CAMLOPTC)
	@echo PP =	$(PP)
	@echo COQFLAGS =	$(COQFLAGS)
	@echo COQLIBINSTALL =	$(COQLIBINSTALL)
	@echo COQDOCINSTALL =	$(COQDOCINSTALL)

Makefile: Make
	mv -f $@ $@.bak
	$(COQBIN)coq_makefile -f $< -o $@


###################
#                 #
# Implicit rules. #
#                 #
###################

%.cmo: %.ml4
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.cmx: %.ml4
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $(PP) -impl $<

%.ml4.d: %.ml4
	$(OCAMLDEP) -slash $(OCAMLLIBS) $(PP) -impl "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.cmo: %.ml
	$(CAMLC) $(ZDEBUG) $(ZFLAGS) $<

%.cmx: %.ml
	$(CAMLOPTC) $(ZDEBUG) $(ZFLAGS) $<

%.ml.d: %.ml
	$(OCAMLDEP) -slash $(OCAMLLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.cmxs: %.cmx
	$(CAMLOPTLINK) $(ZDEBUG) $(ZFLAGS) -shared -o $@ $<

%.vo %.glob: %.v
	$(COQC) $(COQDEBUG) $(COQFLAGS) $*

%.vi: %.v
	$(COQC) -i $(COQDEBUG) $(COQFLAGS) $*

%.g: %.v
	$(GALLINA) $<

%.tex: %.v
	$(COQDOC) $(COQDOCFLAGS) -latex $< -o $@

%.html: %.v %.glob
	$(COQDOC) $(COQDOCFLAGS) -html $< -o $@

%.g.tex: %.v
	$(COQDOC) $(COQDOCFLAGS) -latex -g $< -o $@

%.g.html: %.v %.glob
	$(COQDOC)$(COQDOCFLAGS)  -html -g $< -o $@

%.v.d: %.v
	$(COQDEP) -slash $(COQLIBS) "$<" > "$@" || ( RV=$$?; rm -f "$@"; exit $${RV} )

%.v.beautified:
	$(COQC) $(COQDEBUG) $(COQFLAGS) -beautify $*

# WARNING
#
# This Makefile has been automagically generated
# Edit at your own risks !
#
# END OF WARNING


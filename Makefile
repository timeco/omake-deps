.PHONY: default
default: omake-deps

omake-deps: omake_deps.ml
	ocamlopt -o omake-deps -g -annot str.cmxa omake_deps.ml

.PHONY: test
test: omake-deps
	./omake-deps < sample-dependencies.in > sample-dependencies.om

ifndef PREFIX
  PREFIX = $(shell dirname $$(dirname $$(which ocamlc)))
  export PREFIX
endif

ifndef BINDIR
  BINDIR = $(PREFIX)/bin
  export BINDIR
endif

.PHONY: install
install:
	cp omake-deps $(BINDIR)

.PHONY: uninstall
uninstall:
	rm -f $(BINDIR)/omake-deps

.PHONY: clean
clean:
	rm -f *.cm* *.o *.annot *~
	rm -f omake-deps sample-dependencies.om

PREFIX := /usr/local
SOURCEDIR := scripts
SOURCE := $(notdir $(wildcard $(SOURCEDIR)/*.sh))

.PHONY: all
all:
	@echo "Nothing to be done. Type:\n make install"

.PHONY: install
install:
	@for i in $(SOURCE) ; do \
		install $(SOURCEDIR)/$$i $(PREFIX)/bin/ || break ; \
		echo "$$i: file copied" ; \
	done

.PHONY: uninstall
uninstall:
	@for i in $(SOURCE) ; do \
		rm $(PREFIX)/bin/$$i || break ; \
		echo "$(PREFIX)/bin/$$i: file removed" ; \
	done



PREFIX = /usr/local
SOURCE = pdf_job.sh cleankeys.sh

.PHONY: all
all:
	@echo "Nothing to be done. Type:\n make install"

.PHONY: install
install: $(SOURCE)
	@mkdir -p $(PREFIX)/bin
	@cp $< $(PREFIX)/bin/$<
	@chmod +x $(PREFIX)/bin/$<
	@echo "$<: installed file"

.PHONY: uninstall
uninstall: pdf_job.sh
	@rm -f $(PREFIX)/bin/$<
	@echo "$<: file removed"


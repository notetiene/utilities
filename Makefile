PREFIX = /usr/local
SOURCE = pdf_job.sh

.PHONY: all
all: $(SOURCE)

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


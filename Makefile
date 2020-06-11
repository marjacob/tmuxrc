base   := $(dir $(realpath $(firstword $(MAKEFILE_LIST))))
bundle := tmux.tgz
config := $(HOME)/.tmux.conf
files  := \
	.gitignore \
	Makefile   \
	tmux.conf

.PHONY: all
all: bundle

.PHONY: bundle
bundle: $(bundle)

.PHONY: clean
clean:
	@$(RM) $(bundle)

.PHONY: link
link: $(config)

.PHONY: unlink
unlink:
	@$(RM) $(config)

.PHONY: update
update: update-repository
	git status

.PHONY: update-repository
update-repository:
	git pull --rebase

$(bundle): $(files)
	tar cfz $(@) $(^)

$(config): Makefile
	@echo source-file $(base)tmux.conf > $(@)


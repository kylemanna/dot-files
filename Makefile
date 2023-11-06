#
# Symlink files from the local dot dir to $HOME.  Create parent directories if needed.
#
# Author: Kyle Manna <kyle [at] kylemanna [dot] com>
#
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

# Drop old symlinks
DROP_SYMLINKS := $(HOME)/.config/fish/fish_variables

# Symlink everyfile except *.git, README.md and Makefile
SRC2 := $(shell find $(ROOT_DIR) -mindepth 1 \
	\( -path '*/.git' -o -name README.md -o -name Makefile -o -name .gitmodules -o -name tmp -o -iname .gitignore \) -prune \
	-o \( -type f -o -type l \) -print)
SRC := $(filter-out $(DROP_SYMLINKS:$(HOME)/%=$(ROOT_DIR)/%),$(SRC2))

DST := $(SRC:$(ROOT_DIR)/%=$(HOME)/%)

DST_DIRS := $(patsubst %/,%,$(sort $(dir $(DST))))

all: $(DST) migrate

.SECONDEXPANSION:
$(DST): $$(patsubst $(HOME)/%,$(ROOT_DIR)/%, $$@) | $$(@D)
	ln -srf $< $@

$(DST_DIRS):
	mkdir -p $@

.PHONY: src dst dst_dirs migrate
src:
	$(info SRC = $(SRC))
dst:
	$(info DST = $(DST))
dst_dirs:
	$(info DST_DIRS = $(DST_DIRS))

#migrate: $(filter $(wildcard $(DROP_SYMLINKS)),$(DROP_SYMLINKS))
migrate: $(filter $(DROP_SYMLINKS),$(shell test -L $(DROP_SYMLINKS) && echo $(DROP_SYMLINKS)))
	@for file in $^; do \
		mv -v $$(readlink -f $$file) $$file; \
	done

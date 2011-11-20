CMDT_PATH=bundle/Command-T/ruby/command-t/
VIMRC=~/.vimrc
GVIMRC=~/.gvimrc
RUNTIME_DIR=~/.vim

all: verify-version command-t tmp_dir link
	@true

verify-version:
	vim --version | head -n 1 | grep 7.3 >/dev/null

tmp_dir:
	mkdir -p ~/.tmp/

command-t:
	cd $(CMDT_PATH) && ruby extconf.rb
	$(MAKE) -C $(CMDT_PATH)

link:
	test -e $(VIMRC) || ln -s $(PWD)/vimrc $(VIMRC)
	test -e $(GVIMRC) || ln -s $(PWD)/gvimrc $(GVIMRC)
	test -e $(RUNTIME_DIR) || ln -s $(PWD) $(RUNTIME_DIR)

unlink:
	rm -f $(VIMRC) $(RUNTIME_DIR)

.PHONY: command-t tmp_dir all verify-version link unlink

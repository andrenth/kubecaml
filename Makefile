INSTALL_ARGS := $(if $(PREFIX),--prefix $(PREFIX),)

default:
	jbuilder build @install

install:
	jbuilder install $(INSTALL_ARGS)

uninstall:
	jbuilder uninstall $(INSTALL_ARGS)

reinstall: uninstall reinstall

doc:
	jbuilder build @doc

examples:
	jbuilder build @examples

clean:
	jbuilder clean

.PHONY: default install uninstall reinstall doc examples clean

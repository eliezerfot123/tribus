# Makefile

SHELL = sh -e
PATH = "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
FAB = fab
SU = su
APTITUDE = aptitude
FAB = $(shell which fab)
SU = $(shell which su)
APTITUDE = $(shell which aptitude)

# MAINTAINER TASKS ---------------------------------------------------------------------------------

checkpkg:

	@printf "Checking if we have $(PACKAGE) ... "
	@if [ -z $(shell which $(TESTBIN)) ]; then \
		echo "[ABSENT]"; \
		echo "Installing $(PACKAGE) ... "; \
		echo "Enter your root password:"; \
		$(SU) root -c 'DEBIAN_FRONTEND="noninteractive" $(APTITUDE) install --assume-yes --allow-untrusted -o DPkg::Options::="--force-confmiss" -o DPkg::Options::="--force-confnew" -o DPkg::Options::="--force-overwrite" $(PACKAGE)'; \
	else \
		echo "[OK]"; \
	fi
	@echo

fabric:

	@$(MAKE) checkpkg PACKAGE=fabric TESTBIN=fab
	@$(MAKE) checkpkg PACKAGE=openssh-server TESTBIN=sshd

runserver: fabric

	@$(FAB) development runserver_django

prepare: fabric

	@$(FAB) development build_js
	@$(FAB) development build_css
	@$(FAB) development build_img

syncdb: fabric

	@$(FAB) development syncdb_django

environment: fabric

	@$(FAB) development environment
	
resetdb: fabric

	@$(FAB) development resetdb
	
filldb: fabric

	@$(FAB) development filldb 

update_virtualenv: fabric

	@$(FAB) development update_virtualenv

update_po: fabric 

	@$(FAB) development update_po

create_pot: fabric

	@$(FAB) development create_pot

# snapshot: check-maintdep prepare gen-html gen-wiki gen-po clean

# 	@$(MAKE) clean
# 	@$(BASH) tools/snapshot.sh

# release: check-maintdep

# 	@$(BASH) tools/release.sh

# deb-test-snapshot: check-maintdep

# 	@$(BASH) tools/buildpackage.sh test-snapshot

# deb-test-release: check-maintdep

# 	@$(BASH) tools/buildpackage.sh test-release

# deb-final-release: check-maintdep

# 	@$(BASH) tools/buildpackage.sh final-release

# BUILD TASKS ------------------------------------------------------------------------------

build: fabric

	@$(FAB) development build

build_sphinx: fabric

	@$(FAB) development build_sphinx

build_mo: fabric

	@$(FAB) development build_mo

build_img: fabric

	@$(FAB) development build_img

build_css: fabric

	@$(FAB) development build_css

build_js: fabric

	@$(FAB) development build_js

build_man: fabric

	@$(FAB) development build_man


# CLEAN TASKS ------------------------------------------------------------------------------

clean: fabric

	@$(FAB) development clean

clean_css: fabric

	@$(FAB) development clean_css

clean_js: fabric

	@$(FAB) development clean_js

clean_img: fabric

	@$(FAB) development clean_img

clean_mo: fabric

	@$(FAB) development clean_mo

clean_sphinx: fabric

	@$(FAB) development clean_sphinx

clean_man: fabric

	@$(FAB) development clean_man

clean_dist: fabric

	@$(FAB) development clean_dist

clean_pyc: fabric

	@$(FAB) development clean_pyc
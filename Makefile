.PHONY: default
default: help

.PHONY: help
##@ Pattern tasks

# No need to add a comment here as help is described in common/
help:
	@make -f common/Makefile MAKEFILE_LIST="Makefile common/Makefile" help

%:
	make -f common/Makefile $*

.PHONY: install
install: operator-deploy post-install ## installs the pattern and loads the secrets
	@echo "Installed"

.PHONY: post-install
post-install: ## Post-install tasks
	make load-secrets
	@echo "Done"

.PHONY: test
test:
	@make -f common/Makefile PATTERN_OPTS="-f values-global.yaml -f values-hub.yaml" test

.PHONY: super-linter
super-linter:
	@make -f common/Makefile \
		DISABLE_LINTERS="-e VALIDATE_SQL=false -e VALIDATE_SQLFLUFF=false -e VALIDATE_JAVASCRIPT_STANDARD=false -e VALIDATE_JAVASCRIPT_ES=false" \
		super-linter

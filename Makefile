# picolisp-semver Makefile

PIL_MODULE_DIR ?= .modules
REPO_PREFIX ?= https://github.com/aw

# Unit testing
TEST_REPO = $(REPO_PREFIX)/picolisp-unit.git
TEST_DIR = $(PIL_MODULE_DIR)/picolisp-unit/HEAD
TEST_REF = v3.1.0

# Generic
.PHONY: check run-tests clean

$(TEST_DIR):
		mkdir -p $(TEST_DIR) && \
		git clone $(TEST_REPO) $(TEST_DIR) && \
		cd $(TEST_DIR) && \
		git checkout $(TEST_REF)

check: $(TEST_DIR) run-tests

run-tests:
		PIL_NAMESPACES=false ./test.l

clean:
		rm -rf $(TEST_DIR)

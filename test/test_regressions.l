# Regression tests

# Compare doesn't work between certain versions - https://github.com/aw/picolisp-semver/issues/1
[de test-gh-issue-1 ()
  (assert-nil (semver-compare "2.6.0" "3.0.0") "Issue #1: Is 2.6.0 < 3.0.0 ?")
  (assert-nil (semver-compare "2.0.0" "3.0.0") "Issue #1: Is 2.0.0 < 3.0.0 ?")
  (assert-t (semver-compare "3.5.0" "2.6.0") "Issue #1: Is 3.5.0 > 2.6.0 ?")
  (assert-t (semver-compare "3.6.0" "2.6.0") "Issue #1: Is 3.6.0 > 2.6.0 ?")
  (assert-t (semver-compare "3.7.0" "2.6.0") "Issue #1: Is 3.7.0 > 2.6.0 ?")
  (assert-t (semver-compare "3.7.2" "2.6.0") "Issue #1: Is 3.7.3 > 2.6.0 ?") ]

[execute
  '(test-gh-issue-1) ]

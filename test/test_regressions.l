# Regression tests

# Compare doesn't work between certain versions - https://github.com/aw/picolisp-semver/issues/1
[de test-gh-issue-1 ()
  (assert-nil (semver-compare "2.6.0" "3.0.0") "Issue #1: Is 2.6.0 < 3.0.0 ?")
  (assert-nil (semver-compare "2.0.0" "3.0.0") "Issue #1: Is 2.0.0 < 3.0.0 ?")
  (assert-t (semver-compare "3.5.0" "2.6.0") "Issue #1: Is 3.5.0 > 2.6.0 ?")
  (assert-t (semver-compare "3.6.0" "2.6.0") "Issue #1: Is 3.6.0 > 2.6.0 ?")
  (assert-t (semver-compare "3.7.0" "2.6.0") "Issue #1: Is 3.7.0 > 2.6.0 ?")
  (assert-t (semver-compare "3.7.2" "2.6.0") "Issue #1: Is 3.7.3 > 2.6.0 ?") ]

# Mishandling of invalid versions - https://github.com/aw/picolisp-semver/issues/2
[de test-gh-issue-2 ()
  (assert-nil (semver-format "2.0.-3") "Issue #2: Is 2.0.-3 invalid ?")
  (assert-nil (semver-format "1.nope.3") "Issue #2: Is 1.nope.3 invalid ?")
  (assert-equal '(NIL "2.3.4" "3.4.5" "4.5.6") (semver-sort '("2.nope" "2.3.4" "3.4.5" "4.5.6") T) "Issue #2: Is 2.nope invalid ?")
  (assert-equal '(NIL (1 0 0) (2 0 0)) (semver-sort '("1.0.0" "2.0.0" "nope")) "Issue #2: Is nope invalid ?")
  (assert-equal 0 (semver-compare "nope" "really nope") "Issue #2: Are invalid versions equal ?")
  (assert-nil (semver-compare "1.nope.7" "1.2.7") "Issue #2: Are invalid versions compared NIL ?")
  (assert-t (semver-compare "1.2.7" "1.nope.7") "Issue #2: Are invalid versions compared T ?") ]

[execute
  '(test-gh-issue-1)
  '(test-gh-issue-2) ]

(load "../semver.l")

[de test-internal-cmp ()
  (assert-nil (<=> 1 2) "Ensure (a < b = NIL)")
  (assert-equal 0 (<=> 2 2) "Ensure (a = b = 0)")
  (assert-t (<=> 3 2) "Ensure (a > b = T)") ]

[de test-internal-cmp-versions ()
  (assert-nil (cmp-versions (0 4 0) (1 4 2)) "[versions] Ensure (a < b = NIL)")
  (assert-equal 0 (cmp-versions (1 4 2) (1 4 2)) "[versions] Ensure (a = b = 0)")
  (assert-t (cmp-versions (1 5 2) (1 4 2)) "[versions] Ensure (a > b = T)") ]

[de test-internal-cmp-lists ()
  (assert-nil (cmp-lists '(NIL T 0)) "[lists] Ensure (a < b = NIL)")
  (assert-equal 0 (cmp-lists '(0 0 0)) "[lists] Ensure (a = b = 0)")
  (assert-t (cmp-lists '(T T 0)) "[lists] Ensure (a > b = T)") ]

[de test-internal-sort-versions ()
  (assert-equal '((1 3 0) (1 4 0) (1 6 0)) (sort-versions '((1 6 0) (1 3 0) (1 4 0))) "Sort lists of integers") ]

[de test-internal-to-string ()
  (assert-equal "1.4.2" (to-string (1 4 2)) "Convert an integer list to a string") ]

[de test-internal-to-version ()
  (assert-equal '(("1") ("4") ("2") ("a" "l" "p" "h" "a" "1")) (to-version "1.4.2-alpha1") "Convert a string to an integer list") ]

[de test-semver-format ()
  (assert-equal (1 4 2) (semver-format "1.4.2") "Convert a version string to a list")
  (assert-equal (1 4 2) (semver-format "1.4.2-alpha1") "Drop special version extensions") ]

[de test-semver-cmp ()
  (assert-equal (0 T NIL) (semver-cmp (1 4 0) (1 3 2)) "Compare two version lists") ]

[execute
  (prinl "^J  Testing SemVer^J")

  '(test-internal-cmp)
  '(test-internal-cmp-versions)
  '(test-internal-cmp-lists)
  '(test-internal-sort-versions)
  '(test-internal-to-string)
  '(test-internal-to-version)
  '(test-semver-format)
  '(test-semver-cmp)
  '(assert-nil (semver-compare-slow "1.4.0" "1.4.2") "[slow] Is 1.4.0 < 1.4.2 ?")
  '(assert-nil (semver-compare-slow "1.3.0" "1.4.2") "[slow] Is 1.3.0 < 1.4.2 ?")
  '(assert-nil (semver-compare-slow "0.4.0" "1.4.2") "[slow] Is 0.4.0 < 1.4.2 ?")
  '(assert-t   (semver-compare-slow "1.4.3" "1.4.2") "[slow] Is 1.4.4 > 1.4.2 ?")
  '(assert-t   (semver-compare-slow "1.5.2" "1.4.2") "[slow] Is 1.5.2 > 1.4.2 ?")
  '(assert-t   (semver-compare-slow "2.4.2" "1.4.2") "[slow] Is 2.4.2 > 1.4.2 ?")
  '(assert-equal 0 (semver-compare-slow "1.4.2" "1.4.2") "[slow] Is 1.4.2 = 1.4.2 ?")
  '(assert-nil (semver-compare "1.4.0" "1.4.2") "[fast] Is 1.4.0 < 1.4.2 ?")
  '(assert-nil (semver-compare "1.3.0" "1.4.2") "[fast] Is 1.3.0 < 1.4.2 ?")
  '(assert-nil (semver-compare "0.4.0" "1.4.2") "[fast] Is 0.4.0 < 1.4.2 ?")
  '(assert-t   (semver-compare "1.4.3" "1.4.2") "[fast] Is 1.4.4 > 1.4.2 ?")
  '(assert-t   (semver-compare "1.5.2" "1.4.2") "[fast] Is 1.5.2 > 1.4.2 ?")
  '(assert-t   (semver-compare "2.4.2" "1.4.2") "[fast] Is 2.4.2 > 1.4.2 ?")
  '(assert-equal 0 (semver-compare "1.4.2" "1.4.2") "[fast] Is 1.4.2 = 1.4.2 ?")
  '(assert-equal '((1 3 0) (1 4 0) (1 6 0)) (semver-sort '("1.4.0" "1.6.0" "1.3.0")) "[integers] Sort a list of version strings")
  '(assert-equal '("1.3.0" "1.4.0" "1.6.0") (semver-sort '("1.4.0" "1.6.0" "1.3.0") T) "[strings] Sort a list of version strings")
  ]

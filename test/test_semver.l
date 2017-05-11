# SemVer tests

[de test-internal-cmp ()
  (assert-nil (<=> 1 2) "Ensure (a < b = NIL)")
  (assert-equal 0 (<=> 2 2) "Ensure (a = b = 0)")
  (assert-t (<=> 3 2) "Ensure (a > b = T)") ]

[de test-internal-cmp-versions ()
  (assert-equal '(NIL 0 NIL) (let (V1 (0 4 0) V2 (1 4 2)) (semver-internal-cmp-versions)) "[versions] Ensure (a < b = NIL)")
  (assert-equal '(0 0 0) (let (V1 (1 4 2) V2 (1 4 2)) (semver-internal-cmp-versions)) "[versions] Ensure (a = b = 0)")
  (assert-equal '(0 T 0) (let (V1 (1 5 2) V2 (1 4 2)) (semver-internal-cmp-versions)) "[versions] Ensure (a > b = T)") ]

[de test-internal-cmp-lists ()
  (assert-nil (let (A (1 4 0) B (1 5 0) C (1 5 0)) (semver-internal-cmp-lists)) "[lists] Ensure (b = c = NIL)")
  (assert-equal 0 (let (A (1 6 0) B (1 6 0) C (1 7 0)) (semver-internal-cmp-lists)) "[lists] Ensure (a = b = 0)")
  (assert-t (let (A (1 4 0) B (1 5 0) C (1 3 0)) (semver-internal-cmp-lists)) "[lists] Ensure (b != c = T)") ]

[de test-internal-to-string ()
  (assert-equal "1.4.2" (semver-internal-to-string (1 4 2)) "Convert an integer list to a string") ]

[de test-internal-to-version ()
  (assert-equal '(("1") ("4") ("2") ("a" "l" "p" "h" "a" "1")) (let S "1.4.2-alpha1" (semver-internal-to-version)) "Convert a string to an integer list") ]

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
  '(test-internal-to-string)
  '(test-internal-to-version)
  '(test-semver-format)
  '(test-semver-cmp)
  '(assert-nil (semver-compare "1.4.0" "1.4.2") "Is 1.4.0 < 1.4.2 ?")
  '(assert-nil (semver-compare "1.3.0" "1.4.2") "Is 1.3.0 < 1.4.2 ?")
  '(assert-nil (semver-compare "0.4.0" "1.4.2") "Is 0.4.0 < 1.4.2 ?")
  '(assert-t   (semver-compare "1.4.3" "1.4.2") "Is 1.4.4 > 1.4.2 ?")
  '(assert-t   (semver-compare "1.5.2" "1.4.2") "Is 1.5.2 > 1.4.2 ?")
  '(assert-t   (semver-compare "2.4.2" "1.4.2") "Is 2.4.2 > 1.4.2 ?")
  '(assert-equal 0 (semver-compare "1.4.2" "1.4.2") "Is 1.4.2 = 1.4.2 ?")
  '(assert-equal 0 (semver-compare "1.4.2-alpha1" "1.4.2-alpha2") "Is 1.4.2-alpha1 = 1.4.2-alpha2 (yes) ?")
  '(assert-equal 0 (semver-compare "1.4.2-beta1" "1.4.2-beta1") "Is 1.4.2-beta1 = 1.4.2-beta1 ?")
  '(assert-equal '((1 3 0) (1 4 0) (1 6 0) (2 0 0) (4 2 0) (4 3 1) (4 3 2)) (semver-sort '("1.4.0" "2.0.0" "4.3.2" "4.3.1" "4.2.0" "1.6.0" "1.3.0")) "[integers] Sort a list of version strings")
  '(assert-equal '("1.3.0" "1.4.0" "1.6.0") (semver-sort '("1.4.0" "1.6.0" "1.3.0") T) "[strings] Sort a list of version strings") ]

[execute
  '(assert-nil (semver-satisfies) "[satisfies] Is nothing not nothing ?")
  '(assert-nil (semver-satisfies NIL "1.0.0" "1.3.0") "[satisfies] Is there nothing to compare ?")
  '(assert-t   (semver-satisfies "2.0.0") "[satisfies] Is 2.0.0 something ?")
  '(assert-t   (semver-satisfies "2.0.0" "1.0.0") "[satisfies] Is 2.0.0 >= 1.0.0 ?")
  '(assert-t   (semver-satisfies "2.0.0" "2.0.0") "[satisfies] Is 2.0.0 >= 2.0.0 ?")
  '(assert-t   (semver-satisfies "2.0.0" "1.0.0" "3.0.0") "[satisfies] Is 2.0.0 >= 1.0.0 and < 3.0.0 ?")
  '(assert-t   (semver-satisfies "2.0.0" "1.0.0" "2.0.1") "[satisfies] Is 2.0.0 >= 1.0.0 and < 2.0.1 ?")
  '(assert-t   (semver-satisfies "2.0.0" "2.0.0" "4.0.0") "[satisfies] Is 2.0.0 >= 2.0.0 and < 4.0.0 ?")
  '(assert-t   (semver-satisfies "2.0.0" NIL "4.0.0") "[satisfies] Is 2.0.0 < 4.0.0 ?")
  '(assert-nil (semver-satisfies "0.9.0" "1.0.0") "[satisfies] Is 0.9.0 not >= 1.0.0 ?")
  '(assert-nil (semver-satisfies "0.9.0" "1.0.0" "3.0.0") "[satisfies] Is 0.9.0 not >= 1.0.0 and < 3.0.0 ?")
  '(assert-nil (semver-satisfies "2.3.0" "1.0.0" "2.0.1") "[satisfies] Is 2.3.0 not >= 1.0.0 and < 2.0.1 ?")
  '(assert-nil (semver-satisfies "4.0.0" "2.0.0" "4.0.0") "[satisfies] Is 4.0.0 not >= 2.0.0 and < 4.0.0 ?")
  '(assert-nil (semver-satisfies "5.0.0" "2.0.0" "4.0.0") "[satisfies] Is 5.0.0 not >= 2.0.0 and < 4.0.0 ?")
  '(assert-nil (semver-satisfies "2.0.0" NIL "1.0.0") "[satisfies] Is 2.0.0 not < 1.0.0 ?")
  ]

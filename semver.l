# semver.l
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

(local MODULE_INFO <=> semver-cmp semver-format semver-compare semver-compare-slow)

(load (pack (car (file)) "module.l"))

### internal

# http://stackoverflow.com/a/827656
# a <=> b :=
#   if a < b then return -1
#   if a = b then return  0
#   if a > b then return  1
[de <=> (A B)
  (cond
    ((< A B) NIL)
    ((= A B) 0)
    ((> A B) T) ]

[de cmp-versions (V1 V2)
  (cond
    ((and (= (car V1) (car V2)) (= (cadr V1) (cadr V2)) (= (caddr V1) (caddr V2))) 0)
    ((or  (> (car V1) (car V2)) (> (cadr V1) (cadr V2)) (> (caddr V1) (caddr V2))) T) ]

[de cmp-lists (R)
  (cond
    ((and (=0 (car R)) (=0 (cadr R)) (=0 (caddr R))) 0)
    ((and (car R) (cadr R) (caddr R)) T) ]

### public

[de semver-cmp (V1 V2)
  (list
    (<=> (car V1) (car V2))
    (<=> (cadr V1) (cadr V2))
    (<=> (caddr V1) (caddr V2)) ]

[de semver-format (Version)
  (mapcar format (mapcan '((S) (split S "-")) (split (chop Version) "."))) ]

[de semver-compare (A B)
  (use (V1 V2)
    (setq V1 (semver-format A)
          V2 (semver-format B) )

    (cmp-versions V1 V2) ]

[de semver-compare-slow (A B)
  (let R (semver-cmp (semver-format A) (semver-format B))
    (cmp-lists R) ]

[de semver-sort (L Strings)
  (if (=T Strings)
      (mapcar '((S) (glue "." S)) (by cmp-versions sort (mapcar semver-format L)))
      (by cmp-versions sort (mapcar semver-format L)) ]

# semver.l
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

(local MODULE_INFO <=> cmp-versions cmp-lists sort-versions to-string to-version)
(local semver-cmp semver-format semver-compare semver-sort)

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
  (list
    (<=> (car V1) (car V2))
    (<=> (cadr V1) (cadr V2))
    (<=> (caddr V1) (caddr V2)) ]

[de cmp-lists (R)
  (or (=T (car R))
      (and (=0 (car R)) (=0 (cadr R)) (=0 (caddr R)))
      (and (car R) (=T (cadr R)))
      (and (car R) (cadr R) (=T (caddr R))) ]

[de cmp-range (A B Min Max)
  (or (nor Min Max)
      (and A (not B))
      (and A (not Max)) ]

[de sort-versions (L)
  (by cmp-versions sort L) ]

[de to-string (L)
  (glue "." L) ]

[de to-version (S)
  (split (chop S) '. '-) ]

### public

[de semver-cmp (V1 V2)
  (cmp-versions V1 V2) ]

[de semver-format (S)
  (mapcar format (head 3 (to-version S))) ]

[de semver-compare (A B)
  (let R (semver-cmp
            (semver-format A)
            (semver-format B) )
    (cmp-lists R) ]

[de semver-sort (L S?)
  (let V (sort-versions (mapcar semver-format L))
    (if S?
        (mapcar to-string V)
        V ]

[de semver-satisfies (Ver Min Max)
  (when Ver
    (let (V (semver-format Ver)
          A (cmp-lists (cmp-versions V (semver-format Min)))
          B (cmp-lists (cmp-versions V (semver-format Max))) )

    (cmp-range A B Min Max) ]

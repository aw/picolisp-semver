# semver.l
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

(local MODULE_INFO <=> cmp-versions cmp-lists cmp-range sort-versions to-string to-version)
(local semver-cmp semver-format semver-compare semver-sort semver-satisfies)

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

[de cmp-lists (A B C)
  (if (= A B)
      0
      (<> B C) ]

[de cmp-range (A B Max)
  (or (and A (not B))
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

[de semver-compare (V1 V2)
  (let (A (semver-format V1)
        B (semver-format V2)
        R (sort-versions (list A B)) )

    (cmp-lists A B (cadr R)) ]

[de semver-sort (L S?)
  (let V (sort-versions (mapcar semver-format L))
    (if S?
        (mapcar to-string V)
        V ]

[de semver-satisfies (Ver Min Max)
  (when Ver
    (or (nor Min Max)
        (let (A (semver-compare Ver Min)
              B (semver-compare Ver Max) )
          (cmp-range A B Max) ]

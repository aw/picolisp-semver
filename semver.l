# semver.l
#
# The MIT License (MIT)
#
# Copyright (c) 2017-2019 Alexander Williams, Unscramble <license@unscramble.jp>
#
# Semver 2.0.0 compliant: https://semver.org/spec/v2.0.0.html#semantic-versioning-specification-semver

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

# unused alternative
# [de <=> @
#   (if (pass =)
#       0
#       (pass >) ]

[de semver-internal-cmp-versions (V1 V2)
  (list
    (<=> (car V1) (car V2))
    (<=> (cadr V1) (cadr V2))
    (<=> (caddr V1) (caddr V2)) ]

[de semver-internal-cmp-lists (A B C)
  (if (= A B)
      0
      (<> B C) ]

[de semver-internal-cmp-range (A B Max)
  (or (and A (not B))
      (and A (not Max)) ]

[de semver-internal-to-string (L)
  (glue "." L) ]

# pre-release and build metadata
# https://semver.org/spec/v2.0.0.html#spec-item-9
# https://semver.org/spec/v2.0.0.html#spec-item-10
[de semver-internal-to-version (S)
  (clip (split (chop S) '. '- 'v '+)) ]

### public

# public api
# https://semver.org/spec/v2.0.0.html#spec-item-1
[de semver-cmp (V1 V2)
  (semver-internal-cmp-versions V1 V2) ]

# version number format
# https://semver.org/spec/v2.0.0.html#spec-item-2
[de semver-format (S)
  (let R (mapcar format (head 3 (semver-internal-to-version S)))
    (when (full R) R) ]

[de semver-compare (V1 V2)
  (if (= V1 V2)
      0
      (let (A (semver-format V1)
            B (semver-format V2)
            R (sort (list A B)) )
        (semver-internal-cmp-lists A B (cadr R)) ]

# precedence
# https://semver.org/spec/v2.0.0.html#spec-item-11
[de semver-sort (L S?)
  (let V (sort (mapcar semver-format L))
    (if S?
        (mapcar semver-internal-to-string V)
        V ]

[de semver-satisfies (Ver Min Max)
  (when Ver
    (or (nor Min Max)
        (let (A (semver-compare Ver Min)
              B (semver-compare Ver Max) )
          (semver-internal-cmp-range A B Max) ]

# semver.l
#
# The MIT License (MIT)
#
# Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

(unless (= "false" (sys "PIL_NAMESPACES"))
  (symbols 'semver 'pico)

  (local MODULE_INFO <=> semver-internal-cmp-versions semver-internal-cmp-lists semver-internal-cmp-range semver-internal-to-string semver-internal-to-version)
  (local semver-cmp semver-format semver-compare semver-sort semver-satisfies) )

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

[de semver-internal-cmp-versions ()
  (list
    (<=> (car V1) (car V2))
    (<=> (cadr V1) (cadr V2))
    (<=> (caddr V1) (caddr V2)) ]

[de semver-internal-cmp-lists ()
  (if (= A B)
      0
      (<> B C) ]

[de semver-internal-cmp-range ()
  (or (and A (not B))
      (and A (not Max)) ]

[de semver-internal-to-string @
  (pass glue ".") ]

[de semver-internal-to-version ()
  (split (chop S) '. '-) ]

### public

[de semver-cmp (V1 V2)
  (semver-internal-cmp-versions) ]

[de semver-format (S)
  (mapcar format (head 3 (semver-internal-to-version))) ]

[de semver-compare (V1 V2)
  (if (= V1 V2)
      0
      (let (A (semver-format V1)
            B (semver-format V2)
            C (cadr (sort (list A B))) )
        (semver-internal-cmp-lists) ]

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
          (semver-internal-cmp-range) ]

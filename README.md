# PicoLisp SemVer

[![GitHub release](https://img.shields.io/github/release/aw/picolisp-semver.svg)](https://github.com/aw/picolisp-semver) [![Build Status](https://travis-ci.org/aw/picolisp-semver.svg?branch=master)](https://travis-ci.org/aw/picolisp-semver) [![Dependency](https://img.shields.io/badge/[deps]&#32;picolisp--unit-v2.1.0-ff69b4.svg)](https://github.com/aw/picolisp-unit.git)

[SemVer 2.0.0](http://semver.org) library for PicoLisp

  * Validates and compares **Major.Minor.Patch** versions (ex: `"1.0.0"`)
  * Drops pre-release extensions (ex: `1.1.0-alpha.1 -> 1.1.0`)
  * Drops build metadata extensions (ex: `2.2.0+buildmetadata -> 2.0.0`)
  * Drops versions prefixed with `v` or `v.` (ex: `v3.3.0 -> 3.3.0`)
  * Invalidates incorrectly formatted versions (ex: `"1.invalid.0" -> NIL`)

![SemVer PicoLisp test output](https://cloud.githubusercontent.com/assets/153401/23364395/ceda769a-fcf6-11e6-9bf6-b7b0b8187f61.png)

# Requirements

  * [PicoLisp](http://picolisp.com) 32-bit or 64-bit v16.6+
  * Tested up to PicoLisp v17.12

# Usage

> **Note:** Namespaces can be disabled by setting the environment variable `PIL_NAMESPACES=false`

  * Include `semver.l` in your application: `(load "semver.l")`
  * Use one of the 5 public functions listed below

| Function | Description | Returns | Example |
| :---- | :---- | :---- | :---- |
| `semver-format` | Formats a version string into a list of integers | List of integers | `(1 4 2)` |
| `semver-cmp` | Compares two lists of integers using the spaceship `<=>` | List containing NIL, 0 or T | `(NIL 0 T)` |
| `semver-compare` | Compares two version strings | NIL, 0, or T | `T` |
| `semver-sort` | Sorts a list of version strings | List of integers or strings | `((1 3 0) (1 4 0) (1 6 0))` or `("1.3.0" "1.4.0" "1.6.0")` |
| `semver-satisfies` | Returns whether a version is satisfied by a range | NIL or T | `NIL` or `T` |

Invalid versions are returned as `NIL`.

Version comparison is always from left to right.

A brief explanation of the result obtained from `semver-compare`:

```
if left < right then return NIL # left is older
if left = right then return  0 # left and right are the same
if left > right then return  T # left is newer
```

# Examples

### 1. Compare two version strings

```
(load "semver.l")

(semver-compare "1.4.0" "1.5.0")
-> NIL
(semver-compare "1.5.0" "1.5.0")
-> 0
(semver-compare "1.6.0" "1.5.0")
-> T
```

### 2. Format a version string into a list of integers

```
(load "semver.l")

(semver-format "1.4.0")
-> (1 4 0)
```

### 3. Compare two lists of integers

  * The `(car)` corresponds to the `major`
  * The `(cadr)` corresponds to the `minor`
  * The `(caddr)` corresponds to the `patch`

```
(load "semver.l")

(semver-cmp (2 3 2) (1 4 2))
-> (T NIL 0)
(semver-cmp (1 5 0) (1 4 2))
-> (0 T NIL)
(semver-cmp (2 3 2) (1 4 2))
-> (T NIL 0)
```

### 4. Sort a list of version strings

```
(load "semver.l")

(semver-sort '("1.4.0" "1.6.0" "1.3.0" "1.4.0-alpha"))
-> ((1 3 0) (1 4 0) (1 4 0) (1 6 0))
(semver-sort '("1.4.0" "1.6.0" "1.3.0" "1.4.0-alpha") T)
-> ("1.3.0" "1.4.0" "1.4.0" "1.6.0")
```

### 5. Satisfies a range

**Arguments:**

  * The `first` argument is the version
  * The `second` argument is the minimum version: must be `>=` (greater than or equal)
  * The `third` argument is the maximum version: must be `<` (less than)

**Notes:**

  * If no argument is supplied, `NIL` is returned
  * If the `first` argument is `NIL`, `NIL` is returned
  * If only the `first` argument is supplied, `T` is returned
  * If the `third` argument is `NIL`, only the minimum `>=` is compared
  * If the `second` argument is `NIL`, but the `third` is supplied, only the maximum `<` is compared

```
(load "semver.l")

(semver-satisfies)
-> NIL
(semver-satisfies NIL NIL "3.0.0")
-> NIL
(semver-satisfies "2.0.0")
-> T
(semver-satisfies "2.0.0" "1.0.0")
-> T
(semver-satisfies "2.0.0" NIL "1.0.0")
-> NIL
(semver-satisfies "2.0.0" NIL "3.0.0")
-> T

(semver-satisfies "1.0.0" "1.0.0" "2.0.0")
-> T
(semver-satisfies "1.6.0" "1.0.0" "2.0.0")
-> T
(semver-satisfies "3.0.0" "1.0.0" "2.0.0")
-> NIL
(semver-satisfies "0.9.0" "1.0.0" "2.0.0")
-> NIL
(semver-satisfies "2.0.0" "1.0.0" "2.0.0")
-> NIL
```

# Testing

This library now comes with full [unit tests](https://github.com/aw/picolisp-unit). To run the tests, type:

    make check

# Contributing

If you find any bugs or issues, please [create an issue](https://github.com/aw/picolisp-semver/issues/new).

If you want to improve this library, please make a pull-request.

# License

[MIT License](LICENSE)

Copyright (c) 2017-2018 Alexander Williams, Unscramble <license@unscramble.jp>

# PicoLisp SemVer

[SemVer 2.0.0](http://semver.org) library for PicoLisp

This library can validate and compare **Major.Minor.Patch** versions (ex: `"1.0.0"`).
It ignores pre-release, build, metadata, and special extensions (ex: `.alpha.1`).

# Requirements

  * PicoLisp 32-bit or 64-bit v16.12+

# Usage

  * Include `semver.l` in your application: `(load "semver.l")`
  * Use one of the 3 public functions listed below

| Function | Description | Returns | Example |
| :---- | :---- | :---- | :---- |
| `semver-format` | Formats a version string into a list of integers | List of integers | `(1 4 2)` |
| `semver-cmp` | Compares two lists of integers | List containing NIL, 0 or T | `(NIL 0 T)` |
| `semver-compare` | Compares two version strings | NIL, 0, or T | `NIL` |
| `semver-compare-slow` | Compares two version strings using the spaceship `<=>` | NIL, 0, or T | `T` |

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

# Testing

This library now comes with full [unit tests](https://github.com/aw/picolisp-unit). To run the tests, type:

    make check

# Contributing

If you find any bugs or issues, please [create an issue](https://github.com/aw/picolisp-semver/issues/new).

If you want to improve this library, please make a pull-request.

# License

[MIT License](LICENSE)

Copyright (c) 2017 Alexander Williams, Unscramble <license@unscramble.jp>

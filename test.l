#!/usr/bin/env pil

(when symbols (symbols 'unit 'pico))

(load (pack (car (file)) ".modules/picolisp-unit/HEAD/unit.l"))

(load "semver.l")

(chdir (pack (car (file)) "test/")
  (mapcar load (filter '((N) (sub? "test_" N)) (dir "."))) )

(report)

#!/usr/bin/env pil

(unless (= "false" (sys "PIL_NAMESPACES"))
  (symbols 'semver 'pico) )

(load (pack (car (file)) ".modules/picolisp-unit/HEAD/unit.l"))

(load (pack (car (file)) "semver.l"))

(chdir (pack (car (file)) "test/")
  (mapcar load (filter '((N) (sub? "test_" N)) (dir "."))) )

(report)

;;;; -*- Mode: LISP; Syntax: COMMON-LISP; indent-tabs-mode: nil; coding: utf-8; show-trailing-whitespace: t -*-
;;;; Copyright (C) 2011 Anton Vodonosov (avodonosov@yandex.ru)
;;;; See LICENSE for details.

(defpackage #:test-grid-agent
  (:use #:common-lisp)
  (:export
           ;; agent public API version
           #:+api-version+
           #:api-compatible-p

           ;; the agent class
           #:agent

           ;; agent object configuration properties
           #:lisps
           #:preferred-lisp
           #:user-email

           ;; main function
           #:main))

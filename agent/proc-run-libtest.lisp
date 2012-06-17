;;;; -*- Mode: LISP; Syntax: COMMON-LISP; indent-tabs-mode: nil; coding: utf-8; show-trailing-whitespace: t -*-
;;;; Copyright (C) 2011 Anton Vodonosov (avodonosov@yandex.ru)
;;;; See LICENSE for details.

;;;; This file is loaded into a child lisp process to run a test suite using test-grid::run-libtest.

(in-package :cl-user)

(let* ((this-file (load-time-value (or *load-truename* #.*compile-file-pathname*)))
       (this-file-dir (make-pathname :directory (pathname-directory this-file))))

  ;; make test-grid.asd available for ASDF
  (pushnew (merge-pathnames "../" this-file-dir)
           asdf:*central-registry*
           :test #'equal)

  (load (merge-pathnames "proc-common.lisp" this-file-dir)))

(ql:quickload :test-grid)

(defun run-libtest-with-response-to-file (libname
                                          run-descr
                                          logfile
                                          asdf-output-root-dir
                                          response-file)
  (let ((asdf-output-wild-pathname
         (merge-pathnames (make-pathname :directory '(:relative :wild-inferiors)
                                         :name :wild
                                         :type :wild
                                         :version :wild)
                          asdf-output-root-dir)))
    (format t "asdf-output-wild-pathname: ~S~%" asdf-output-wild-pathname)
    (asdf:initialize-output-translations `(:output-translations
                                           :ignore-inherited-configuration
                                           (T ,asdf-output-wild-pathname))))
  (format t "asdf::*output-translations*: ~S~%" asdf::*output-translations*)

  (let ((lib-result (test-grid::run-libtest libname run-descr logfile)))
    (set-response response-file lib-result)))

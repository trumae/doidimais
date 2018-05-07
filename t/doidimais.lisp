(in-package :cl-user)
(defpackage doidimais-test
  (:use :cl
        :doidimais
        :prove))
(in-package :doidimais-test)

;; NOTE: To run this test file, execute `(asdf:test-system :doidimais)' in your Lisp.

(setf *enable-colors* nil)

(plan 6)

(subtest "some-op"
  (is (apply (some-op #'characterp) '((() (#\a) ())))
      '((#\a) nil nil))
  (is (apply (some-op #'characterp) '((() (#\a #\b) ())))
      '((#\a) (#\b) nil)))

(subtest "one-op"
  (is (apply (one-op #\a) '((() (#\b) ())))
      '(nil (#\b) doidimais::fail))
  (is (apply (one-op #\a) '((() (#\a) ())))
      '((#\a) nil nil)))

(subtest "or-op"
  (is (apply (or-OP (some-op #'characterp) (some-op #'stringp)) '((() (#\a) ())))
      '((#\a) nil nil))
  (is (apply (or-OP (some-op #'characterp) (some-op #'stringp)) '((() ("teste") ())))
      '(("teste") nil nil))
  (is (apply (or-OP (some-op #'characterp) (some-op #'stringp)) '((() (nil) ())))
      '(nil (nil) doidimais::fail)))

(subtest "then-op"
  (is (apply (then-op (some-op #'characterp) (some-op #'stringp)) '((() (#\a "teste" #\b) ())))
      '((#\a "teste") (#\b) nil))
  (is (apply (then-op (some-op #'characterp) (some-op #'stringp)) '((() (#\a "teste") ())))
      '((#\a "teste") nil nil))
  (is (apply (then-op (some-op #'characterp) (some-op #'stringp)) '((() (#\a #\b) ())))
      '((#\a nil) (#\b) doidimais::fail)))

(subtest "many-op"
  (is (apply (many-op (some-op #'characterp)) '((() (#\a #\b #\c) ())))
      '((#\c #\b #\a) nil nil))
  (is (apply (many-op (some-op #'characterp)) '((() (#\a "test" #\c) ())))
      '((#\a) ("test" #\c) nil)))

(subtest "apply-op"
  (is (apply (apply-op (some-op #'characterp) (lambda (x) (list x))) '((() (#\a #\b) ())))
      '(((#\a)) (#\b) nil)))

(finalize)

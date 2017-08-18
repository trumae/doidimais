#|
  This file is a part of doidimais project.
|#

(in-package :cl-user)
(defpackage doidimais-asd
  (:use :cl :asdf))
(in-package :doidimais-asd)

(defsystem doidimais
  :version "0.1"
  :author "Trumae da Ilha"
  :license "MIT"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "doidimais"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op doidimais-test))))

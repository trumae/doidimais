#|
  This file is a part of doidimais project.
|#

(in-package :cl-user)
(defpackage doidimais-test-asd
  (:use :cl :asdf))
(in-package :doidimais-test-asd)

(defsystem doidimais-test
  :author ""
  :license ""
  :depends-on (:doidimais
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "doidimais"))))
  :description "Test system for doidimais"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))

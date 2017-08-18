(in-package :doidimais)

(defun some-op (p)
  (lambda (input)
    (if (null (cadr input))
	(list (car input) (cadr input) 'fail)
	(if (apply p  (list (car (cadr input))))
	    (list (cons (car (cadr input))
			(car input))
		  (cdr (cadr input)) '())
	    (list (car input)
		  (cadr input)
		  'fail)))))

;;> (apply (SOME-OP #'characterp) '((() (#\a) ())))
;;> (apply (SOME-OP #'characterp) '((() (#\a #\b) ())))

(defun one-op (elem)
  (let ((aux (lambda(i) (equal i elem))))
    (some-op aux)))

;; > (apply (one-op #\a) '((() (#\b) ())))
;; > (apply (one-op #\a) '((() (#\a) ())))


(defun or-op (fun1 fun2)
  (lambda (input)
    (let ((p1 (apply fun1 (list input))))
      (if (eq (caddr p1) 'fail)
	  (apply fun2 (list input))
	  p1))))

;; > (apply (or-OP (some-op #'characterp) (some-op #'stringp)) '((() (#\a) ())))
;; > (apply (or-OP (some-op #'characterp) (some-op #'stringp)) '((() ("teste") ())))
;; > (apply (or-OP (some-op #'characterp) (some-op #'stringp)) '((() (nil) ())))


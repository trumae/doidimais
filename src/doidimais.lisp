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

(defun then-op(fun1 fun2)
  (lambda (input)
    (let ((p1 (apply fun1 (list input))))
      (if (eq (caddr p1) 'fail)
	  p1
	  (let ((p2 (apply fun2 (list (list '() (cadr p1) (caddr p1))))))
	    (if (equal (caddr p2) 'falha)
		p2
		(list (list (caar p1) (caar p2))
		      (cadr p2)
		      (caddr p2))))))))

;; > (apply (then-op (some-op #'characterp) (some-op #'stringp)) '((() (#\a "teste" #\b) ())))
;; > (apply (then-op (some-op #'characterp) (some-op #'stringp)) '((() (#\a "teste") ())))
;; > (apply (then-op (some-op #'characterp) (some-op #'stringp)) '((() (#\a #\b) ())))


(defun many-op(fun)
  (lambda (input)
    (let ((p1 (apply fun (list input))))
      (if (eq (caddr p1) 'fail)
	  input 
	  (let ((p2 (apply (many-op fun) (list p1))))
	    p2)))))


;; > (apply (many-op (some-op #'characterp)) '((() (#\a #\b #\c) ())))
;; > (apply (many-op (some-op #'characterp)) '((() (#\a "test" #\c) ())))


(defun apply-op (fun handle)
  (lambda (input)
    (let ((p (apply fun (list input))))
      (if (eq (caddr p) 'fail)
	  p
	  (list (apply handle (list (car p)))
		(cadr p)
		(caddr p))))))


;; > (apply (apply-op (some-op #'characterp) (lambda (x) (list x))) '((() (#\a #\b) ())))

#| 
@title Doidimais
@subtitle Parser Combinator in Common Lisp
@author Vinicius Valente Maciel
@syntax erudite

@section Motivation

After i buy the book @emph{Essencial of Programming Languages}(Daniel P. Friedman, Mitchell Wand and Christopher T. Hayners) and starting the read it. I wanted to study interpreters. I did not have much time. Then i used my time in the subway to wrote an litle interpreter. In this time, i used an scheme interpreter called @emph{LispMe} installed into a Palm M100. Here i am rewrite that results into Common Lisp.



@include doidimais.lisp
|#

;;@chunck chunckpackage

(in-package :cl-user)
(defpackage doidimais
  (:use :cl))
(in-package :doidimais)


;;@end chunck
;;
;;@insert-chunck chunckpackage
;;
;;@section Building project
;;
;;@include ../doidimais.asd
;;


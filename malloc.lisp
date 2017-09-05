(in-package :vg)



;; Automatic foreign array management.
;;
;; With very little overhead, we shall maintain a mallocs stack.  All
;; mallocs are kept there, and at any convenient point, we can clean
;; up using a saved index.
;;

(eval-when (:execute :load-toplevel :compile-toplevel)
  (defun make-mm ()
    (make-array 0 :element-type 'cffi-sys:foreign-pointer
					 :adjustable t
					 :fill-pointer t))
  (export 'make-mm)
    (defparameter *mallocs* (make-mm))
  (export '*mallocs*))

(defun mallocs-free (&optional (limit 0) (arr *mallocs*))
  "free all foreign objects allocated on *malloc-stack* down to the
one at limit."
  (declare (optimize (speed 3) (safety 0) (debug 0)))
  (declare (type fixnum limit)
	   (type array arr))
  (when (> (the fixnum (fill-pointer arr)) limit)
    (foreign-free (the cffi-sys:foreign-pointer (vector-pop arr)))
    (mallocs-free limit arr ))
  nil)
(export 'mallocs-free)

(defmacro with-mallocs (&body body)
  (let ((malloc-index (gensym))
	(stack vg:*mallocs*))
    `(let ((,malloc-index (fill-pointer ,stack)))
       ,@body
       (mallocs-free ,malloc-index ,stack))))
(export 'with-mallocs)
(defun malloc (type init)
  (let ((ptr (foreign-alloc type :initial-contents init)))
    (vector-push-extend ptr *mallocs*)
    ptr))
(export 'malloc)


(defmacro with-mm (mm &body body)
  `(let ((vg:*mallocs* ,mm))
     ,@body))
(export 'with-mm)
;; Reader macros to read foreign vectors using #{...} format.
;;
;; #{ } creates a form that will compile to foreign-alloc an array and
;; initialize it to (evaluated) values between the braces.
;;
;; If the first element after the #{ is a symbol representing a valid cffi
;; type, that type will be used for the array.  Otherwise, the macro will
;; infer the type from the first element's type.
;;
;; The elements are typechecked and coerced into the desired foreign type
;; using the following rules:
;;
;; - range limits of the desired foreign type are observed
;; - floats can convert to integer types if the matissa is 0
;; - integers can always convert to floats
;; - integers can convert to pointers
;; 
;; For now, no optimizations take place if the elements are calculated...
;;

(defun foreign-element-coerce (foreign-type value)
  "attempt to convert a value to the canonicalized foreign-type"
  (format t "CONVERTING ~A to ~A~&" value foreign-type)
  (flet ((integer-helper (typespec)
	   (multiple-value-bind (v r)(truncate value)
	     (if (and (zerop r)
		      (typep v typespec))
		 v
		 (error "value ~A cannot be stored as foreign type ~A"
			value foreign-type )))))
    (if (consp value)
	`(foreign-element-coerce ,foreign-type ,value)
	(case foreign-type
	  (:unsigned-char (integer-helper '(integer 0 #xFF)))
	  (:unsigned-short (integer-helper '(integer 0 #xFFFF)))
	  (:unsigned-int   (integer-helper '(integer 0 #xFFFFFFFF)))
	  (:unsigned-long-long   (integer-helper '(integer 0 #xFFFFFFFFFFFFFFFF)))
	  ;;
	  (:char  (integer-helper '(integer       -128   127)))
	  (:short (integer-helper '(integer     -32768 32767)))
	  (:int   (integer-helper '(integer -2147483648  2147483647)))
	  (:long-long (integer-helper '(integer  -9223372036854775808
					9223372036854775807)))
	  ;;
	  ((:float :double) (float value))
	  ;;
	  (:foreign-pointer
	   (typecase value
	     (foreign-pointer value)
	     (integer (case (foreign-type-size :pointer)
			(4 (cffi-sys:make-pointer 
			    (integer-helper '(integer 0 #xFFFFFFFF))))
			(8 (cffi-sys:make-pointer 
			    (integer-helper '(integer 0 #xFFFFFFFFFFFFFFFF))))))))))))

(defun foreign-vec-reader(stream sub-char infix)
  (format t "sub-char: ~A infix ~A" sub-char infix)
  (multiple-value-bind ;;
	(foreign-type initial-contents)
      (let* ((data (read-delimited-list #\} stream t))
	     (first (first data)))   
	(typecase first
	  (symbol (values (cffi::canonicalize-foreign-type first) (cdr data)))
	  (integer (values :int data))
	  (double-float :double-float data)
	  (float (values :float data))
	  (t (error "Unsupported foreign vector element ~A type ~A"
		    first (type-of first)))))
    `(malloc ,foreign-type
	     (list ,@(mapcar (lambda (element)
			       (foreign-element-coerce foreign-type element))
				  initial-contents)))))

(set-dispatch-macro-character #\# #\{ #'foreign-vec-reader)

(set-macro-character #\} (get-macro-character #\) ))

;; Since mallocs are in a single array, mm is just another array
;; for keeping mallocs.

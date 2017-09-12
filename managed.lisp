(in-package :vg)
;;
;; Deal with managed foreign memory.
;;
;; Handles.
;;-----------------------------------------------------------------------------
;;
;; Managed vg handles...  Since handles are integers, we are forced to keep
;; an extra type array.  Even though I suspect that the destroy routines
;; are all the same..
;;
(eval-when (:execute :load-toplevel :compile-toplevel)
  (defparameter *handles* 
    (make-array 0 :element-type 'integer
		:adjustable t
		:fill-pointer t))
  (export '*handles*)
  (defparameter *handle-types* 
    (make-array 0 :element-type '(integer 0 5)
		:adjustable t
		:fill-pointer t))
  (export '*handle-types*)

  (defun handles-currently ()
    (fill-pointer *handles*))
  (export 'handles-currently)
  
  (defparameter handle-font 0)
  (defparameter handle-image 1)
  (defparameter handle-mask-layer 2)
  (defparameter handle-paint 3)
  (defparameter handle-path 4)

  (defparameter *handle-free-routines*
    (make-array 5 :initial-contents
		
		( list
		  #'destroy-font
		  #'destroy-image
		  #'destroy-mask-layer
		  #'destroy-paint
		  #'destroy-path)))

  (defun handles-free (&optional (limit 0) (handles *handles*)
			 (types *handle-types*))
    "free all handles down to the one at limit."
    (declare (optimize (speed 3) (safety 0) (debug 0)))
    (declare (type fixnum limit))
    (when (> (the fixnum (fill-pointer handles)) limit)
      
      (funcall (aref *handle-free-routines* (vector-pop types))
	       (vector-pop handles))
      (handles-free limit handles types))
    nil )
  (export 'handles-free)

  (defmacro with-handles (&body body)
    `(let ((handles-currently (vg:handles-currently)))
       ,@body
       (vg:handles-free handles-currently) ))
  (export 'with-handles))


;; The global management of foreign buffers may not be always desirable.
;; You may wish to persist an object, and its foreign state, and yet
;; be able to trash it easily.
;;
;; That is where hanman (handle manager) comes in.  It creates a separately
;; managed group of handles that can be swapped in for a duration.
(defstruct hanman
  (handles (make-array 0 :element-type 'integer
		:adjustable t
		:fill-pointer t))
  (types (make-array 0 :element-type '(integer 0 6)
			     :adjustable t
			     :fill-pointer t)))

(defmacro with-hanman (hanman &body body)
  `(let ((vg:*handles* (vg::hanman-handles ,hanman))
	 (vg:*handle-types* (vg::hanman-types ,hanman)))
     ,@body))

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

  (defparameter *handle-types* 
    (make-array 0 :element-type '(integer 0 5)
		:adjustable t
		:fill-pointer t))

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
  (export 'handles-free))

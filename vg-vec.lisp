(in-package :vg)

(defun group (source n)
     "This takes a  flat list and emit a list of lists, each n long
   containing the elements of the original list"
     (if (zerop n) (error "zero length"))
     (labels ((rec (source acc)
		(let ((rest (nthcdr n source)))
		  (if (consp rest)
		      (rec rest (cons (subseq source 0 n)
				      acc))
		      (nreverse (cons source acc))))))
       (if source
	   (rec source nil)
	   nil)))

(defun %print-mem (pointer &optional (size-in-bytes 64))
  (let* ((size (if (oddp size-in-bytes) (1+ size-in-bytes) size-in-bytes))
         (data (loop :for i :below size :collect
                  (cffi:mem-ref pointer :uchar i)))
         (batched (group data 16))
         (batched-chars (mapcar
                         (lambda (x)
                           (mapcar
                            (lambda (c)
                              (if (and (> c 31) (< c 126))
                                  (code-char c)
                                  #\.))
                            x))
                         batched)))
    (loop :for batch :in batched :for chars :in batched-chars
       :for i :from 0 :by 16 :do
       (when (= 0 (mod i 256))
         (format t "~%87654321    0011 2233 4455 6677 8899 aabb ccdd eeff    0123456789abcdef~%")
         (format t "-----------------------------------------------------------------------~%"))
       (format t "~8,'0X    ~{~@[~2,'0X~]~@[~2,'0X ~]~}   " i batch)
       (format t "~{~a~}~{~c~}~%"
               (loop :for i :below (max 0 (floor (/ (- 16 (length batch)) 2)))
                  :collect "     ")
               chars))))
#||;;=================================================================
(defclass vec ()
  ((pointer :accessor pointer :initarg :pointer :type cffi-sys:foreign-pointer)
   (size    :accessor size    :initarg :size    :type fixnum)))

(defun free-vec (vec)
  (foreign-free (pointer vec))
  (setf (pointer vec) (null-pointer)
	(size vec) 0))

(defmethod free ((object vec))
  (free-vec object))

(defmethod print-object ((object vec) stream)
  (format stream "#<VEC :size ~a>"
	  (size object)))

(defmethod print-mem ((thing vec) &optional (size-in-bytes 64) (offset 0))
  (%print-mem
   (cffi:inc-pointer (pointer thing) offset)
   size-in-bytes))

(defmethod initialize-instance :after ((obj vec)
				       &key type initial-contents)
  (setf (pointer obj) (foreign-alloc
		       type
		       :initial-contents initial-contents)
	(size obj) (length initial-contents)))



(defmacro with-vec ((name initial) &body body)
  `(let ((,name (make-vec ,initial)))
     (unwind-protect
	  (progn ,@body)
       (free ,name) )))
;;-----------------------------------------------------------
;;
(defclass vec-f (vec) ())

(defun make-vec-f (initial-contents)
  (make-instance 'vec-f :type :float :initial-contents initial-contents))

(defmethod print-object ((object vec-f) stream)
  (format stream "#<VEC-F [~A] '#("
	  (size object))
  (loop for i from 0 to (1- (size object)) do
       (format stream "~A " (mem-ref (pointer object) :float
				     (* 4 i))))
  (format stream ")>"))

(defmacro with-vec-f ((name initial) &body body)
  `(let ((,name (make-vec-f ,initial)))
     (unwind-protect
	  (progn ,@body)
       (free ,name) )))
;;-----------------------------------------------------------
;;
(defclass vec-i (vec) ())
(defun make-vec-i (initial-contents)
  (make-instance 'vec-i :type :int :initial-contents initial-contents))

(defmethod print-object ((object vec-i) stream)
  (format stream "#<VEC-I [~A] '#("
	  (size object))
  (loop for i from 0 to (1- (size object)) do
       (format stream "~A " (mem-ref (pointer object) :int
				     (* 4 i))))
  (format stream ")>"))


;;-----------------------------------------------------------
;;
(defclass vec-cmd (vec) ())
(defun make-vec-cmd (initial-contents)
  (make-instance 'vec-i :type :int
		 :initial-contents (mapcar #'symbol-value initial-contents)))

(defmethod print-object ((object vec-i) stream)
  (format stream "#<VEC-CMD [~A] '#("
	  (size object))
  (loop for i from 0 to (1- (size object)) do
       (format stream "~A " (mem-ref (pointer object) :int
				     (* 4 i))))
  (format stream ")>"))
||#

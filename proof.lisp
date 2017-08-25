(in-package :vg)
;;=====================================================================
(defun t-clear ()
  ( native::init :api egl:openvg-api)
  (let ((clear-color (foreign-alloc :float :initial-contents '(1.0 1.0 1.0 1.0))))
    (vg:set-fv :CLEAR-COLOR 4 clear-color)
    (vg:clear 0 0 1200 1080)
    (vg:flush)
    ;;(foreign-free clear-color)
    )
  (egl:swap-buffers native::*surface*)
  (sleep 2)
  (native::deinit))

(defun t-broken ()
  ( native::init :api egl:openvg-api)
  (let ((clear-color (foreign-alloc :float :initial-contents '(0.0 0.0 1.0 1.0))))
    (vg:set-fv :CLEAR-COLOR 4 clear-color)
    (vg:clear 0 0 1200 1080)
    (with-foreign-array (cmds '#(#.vg:move-to-abs #.vg:line-to-abs
				 #.vg:line-to-abs #.vg:close-path)
			      '(:array :uint 4))
      (with-foreign-array (coords '#(630.0 630.0
				     902.0 630.0
				     750.0 924.0
				     630.0 630.0 )
				  '(:array :float 8))
	(with-foreign-array (dash-pattern '#(20.0 20.0) '(:array :float 2))
	  (with-foreign-array (color '#(1.0 0.1 1.0 0.2) '(:array :float 4))
	    (with-foreign-array (white-color '#(1.0 1.0 1.0 0.0) '(:array :float 4))
	      (format t "1. ~A~&" (get-error))
	      (let ((path (vg:create-path
			   vg:path-format-standard
			   :path-datatype-f 1.0 0.0 0 0
			   vg:path-capability-append-to)))
		(format t "2. ~A~&" (get-error))
		(vg:append-path-data path 4 cmds coords )
		(format t "3. ~A~&" (get-error))
		(let ((fill (vg:create-paint)))
		  (vg:set-parameter-i fill PAINT-TYPE PAINT-TYPE-COLOR )
		  (format t "4. ~A~&" (get-error)) (force-output)
		  (vg:set-parameter-fv fill paint-color 4 color )
		  (format t "5. ~A~&" (get-error)) (force-output)
		  (vg:set-paint fill fill-path)
		  (format t "6. ~A~&" (get-error)) (force-output)
		  (vg:set-paint fill stroke-path)
		  (format t "7. ~A~&" (get-error)) (force-output)
		  (vg:set-fv :clear-color 4 white-color)
		  (vg:set-f  :stroke-line-width 20.0)
		  (vg:set-i  :stroke-cap-style vg:cap-butt)
		  (vg:set-fv :stroke-dash-pattern 2 dash-pattern)
		  (vg:set-f  :stroke-dash-phase 0.0)
		  (format t "100. ~A~&" (get-error)) (force-output)
		  (vg:draw-path path  vg:stroke-path)
		  (format t "101. ~A~&" (get-error)) (force-output)

		  (vg:flush)
		  (format t "102. ~A~&" (get-error)) (force-output)
))
	      )))))
    

    

    ;;(foreign-free clear-color)
    )
  (egl:swap-buffers native::*surface*)
  (sleep 2)
  (native::deinit))


(defun background (r g b)
  (with-foreign-array (color (make-array 4 :initial-contents (list r g b 1.0))
			     '(:array :float 4))
    (vg:set-fv :CLEAR-COLOR 4 color)
    (vg:clear 0 0 1200 1080)))


(defun -fill (&rest rest)
  (with-foreign-array (color (make-array 4
					 :initial-contents (mapcar #'float rest))
			     '(:array :float 4))
    (let ((paint (vg:create-paint)))
      (vg:set-parameter-i paint PAINT-TYPE PAINT-TYPE-COLOR )
      (vg:set-parameter-fv paint PAINT-COLOR 4 color)
      (vg:set-paint paint FILL-PATH)
      (vg:destroy-paint paint))))
#||
(defun -fill (&rest rest)
  (with-vec (color  (mapcar #'float rest))
    (let ((paint (vg:create-paint)))
      (vg:set-parameter-i paint PAINT-TYPE PAINT-TYPE-COLOR )
      (vg:set-parameter-fv paint PAINT-COLOR 4 (pointer color))
      (vg:set-paint paint FILL-PATH)
      (vg:destroy-paint paint))))
||#

(defun -circle (x y r)
  (let ((path (vg:create-path path-format-standard
			      :path-datatype-f
			      1.0 0.0
			      0 0
			      path-capability-append-to)))
    (vgu:ellipse path x y r r)
    (vg:draw-path path (+ vg:fill-path vg:stroke-path) )
    (vg:destroy-path path)
    ))
(defun ttt ()
  ( native::init :api egl:openvg-api)
  ;; background
  (background 1.0 0.2 0.4)
  (-fill 1 0.3 0.3 1)
  (-circle 500.0 0.0 500.0  )
  (print (vg:get-error)) (force-output)
  (vg:flush)
  (egl:swap-buffers native::*surface*)
  (sleep 1)
  (native::deinit))

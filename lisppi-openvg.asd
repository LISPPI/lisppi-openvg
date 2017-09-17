;;
;;
(asdf:defsystem #:lisppi-openvg
  :description "OpenVG bindings for raspberry pi"
  :author "StackSmith <fpgasm@apple2.x10.mx>"
  :license "BSD 3-clause license"
  :serial t
  :depends-on (:lisppi-egl :cffi)
  :components ((:file "package")
	       (:file "library")
	       (:file "vg")
	       (:file "vg-lisp")

	       (:file "managed")
	       (:file "vgu")
	       (:file "vgu-lisp")

;	       (:file "malloc")
;;	       (:file "rgba")
;;	       (:file "proof")
	       ))


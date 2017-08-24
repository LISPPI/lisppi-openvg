 (in-package #:vg)

(define-foreign-library lib-lisppi-openvg
  (t (:default "libOpenVG")) ;/opt/vc/lib/libbcm_host.so
  )

(use-foreign-library lib-lisppi-openvg)
  

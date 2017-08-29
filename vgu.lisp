(in-package #:vgu)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:59:9)
;;
(defctype xfixnum :uint)
(defctype error-code xfixnum);; was _VGUErrorCode
(export 'error-code)
(defparameter vgu-no-error #x0 );; VGU_NO_ERROR
(export 'vgu-no-error)
(defparameter vgu-bad-handle-error #xF000 );; VGU_BAD_HANDLE_ERROR
(export 'vgu-bad-handle-error)
(defparameter vgu-illegal-argument-error #xF001 );; VGU_ILLEGAL_ARGUMENT_ERROR
(export 'vgu-illegal-argument-error)
(defparameter vgu-out-of-memory-error #xF002 );; VGU_OUT_OF_MEMORY_ERROR
(export 'vgu-out-of-memory-error)
(defparameter vgu-path-capability-error #xF003 );; VGU_PATH_CAPABILITY_ERROR
(export 'vgu-path-capability-error)
(defparameter vgu-bad-warp-error #xF004 );; VGU_BAD_WARP_ERROR
(export 'vgu-bad-warp-error)
;; (defparameter vgu-error-code-force-size #x7FFFFFFF );; VGU_ERROR_CODE_FORCE_SIZE
;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:117:41)
;;
(declaim (inline &compute-warp-quad-to-quad))
(defcfun ("vguComputeWarpQuadToQuad" &compute-warp-quad-to-quad) error-code
  "see: (/opt/vc/include/VG/vgu.h:117:41)"
  (dx0  :FLOAT) ;; dx0 #<typedef VGfloat>
  (dy0  :FLOAT) ;; dy0 #<typedef VGfloat>
  (dx1  :FLOAT) ;; dx1 #<typedef VGfloat>
  (dy1  :FLOAT) ;; dy1 #<typedef VGfloat>
  (dx2  :FLOAT) ;; dx2 #<typedef VGfloat>
  (dy2  :FLOAT) ;; dy2 #<typedef VGfloat>
  (dx3  :FLOAT) ;; dx3 #<typedef VGfloat>
  (dy3  :FLOAT) ;; dy3 #<typedef VGfloat>
  (sx0  :FLOAT) ;; sx0 #<typedef VGfloat>
  (sy0  :FLOAT) ;; sy0 #<typedef VGfloat>
  (sx1  :FLOAT) ;; sx1 #<typedef VGfloat>
  (sy1  :FLOAT) ;; sy1 #<typedef VGfloat>
  (sx2  :FLOAT) ;; sx2 #<typedef VGfloat>
  (sy2  :FLOAT) ;; sy2 #<typedef VGfloat>
  (sx3  :FLOAT) ;; sx3 #<typedef VGfloat>
  (sy3  :FLOAT) ;; sy3 #<typedef VGfloat>
  (matrix  (:pointer :FLOAT)) ;; matrix #<POINTER #<typedef VGfloat>>
)
(export '&compute-warp-quad-to-quad)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:111:41)
;;
(declaim (inline &compute-warp-square-to-quad))
(defcfun ("vguComputeWarpSquareToQuad" &compute-warp-square-to-quad) error-code
  "see: (/opt/vc/include/VG/vgu.h:111:41)"
  (dx0  :FLOAT) ;; dx0 #<typedef VGfloat>
  (dy0  :FLOAT) ;; dy0 #<typedef VGfloat>
  (dx1  :FLOAT) ;; dx1 #<typedef VGfloat>
  (dy1  :FLOAT) ;; dy1 #<typedef VGfloat>
  (dx2  :FLOAT) ;; dx2 #<typedef VGfloat>
  (dy2  :FLOAT) ;; dy2 #<typedef VGfloat>
  (dx3  :FLOAT) ;; dx3 #<typedef VGfloat>
  (dy3  :FLOAT) ;; dy3 #<typedef VGfloat>
  (matrix  (:pointer :FLOAT)) ;; matrix #<POINTER #<typedef VGfloat>>
)
(export '&compute-warp-square-to-quad)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:105:41)
;;
(declaim (inline &compute-warp-quad-to-square))
(defcfun ("vguComputeWarpQuadToSquare" &compute-warp-quad-to-square) error-code
  "see: (/opt/vc/include/VG/vgu.h:105:41)"
  (sx0  :FLOAT) ;; sx0 #<typedef VGfloat>
  (sy0  :FLOAT) ;; sy0 #<typedef VGfloat>
  (sx1  :FLOAT) ;; sx1 #<typedef VGfloat>
  (sy1  :FLOAT) ;; sy1 #<typedef VGfloat>
  (sx2  :FLOAT) ;; sx2 #<typedef VGfloat>
  (sy2  :FLOAT) ;; sy2 #<typedef VGfloat>
  (sx3  :FLOAT) ;; sx3 #<typedef VGfloat>
  (sy3  :FLOAT) ;; sy3 #<typedef VGfloat>
  (matrix  (:pointer :FLOAT)) ;; matrix #<POINTER #<typedef VGfloat>>
)
(export '&compute-warp-quad-to-square)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:70:9)
;;
(defctype arc-type xfixnum);; was _VGUArcType
(export 'arc-type)
(defparameter arc-open #xF100 );; VGU_ARC_OPEN
(export 'arc-open)
(defparameter arc-chord #xF101 );; VGU_ARC_CHORD
(export 'arc-chord)
(defparameter arc-pie #xF102 );; VGU_ARC_PIE
(export 'arc-pie)
;; (defparameter vgu-arc-type-force-size #x7FFFFFFF );; VGU_ARC_TYPE_FORCE_SIZE
;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:99:41)
;;
(declaim (inline &arc))
(defcfun ("vguArc" &arc) error-code
  "see: (/opt/vc/include/VG/vgu.h:99:41)"
  (path  :UINT) ;; path #<typedef VGPath>
  (x  :FLOAT) ;; x #<typedef VGfloat>
  (y  :FLOAT) ;; y #<typedef VGfloat>
  (width  :FLOAT) ;; width #<typedef VGfloat>
  (height  :FLOAT) ;; height #<typedef VGfloat>
  (start-angle  :FLOAT) ;; startAngle #<typedef VGfloat>
  (angle-extent  :FLOAT) ;; angleExtent #<typedef VGfloat>
  (arc-type  arc-type) ;; arcType #<typedef VGUArcType>
)
(export '&arc)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:95:41)
;;
(declaim (inline &ellipse))
(defcfun ("vguEllipse" &ellipse) error-code
  "see: (/opt/vc/include/VG/vgu.h:95:41)"
  (path  :UINT) ;; path #<typedef VGPath>
  (cx  :FLOAT) ;; cx #<typedef VGfloat>
  (cy  :FLOAT) ;; cy #<typedef VGfloat>
  (width  :FLOAT) ;; width #<typedef VGfloat>
  (height  :FLOAT) ;; height #<typedef VGfloat>
)
(export '&ellipse)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:90:41)
;;
(declaim (inline &round-rect))
(defcfun ("vguRoundRect" &round-rect) error-code
  "see: (/opt/vc/include/VG/vgu.h:90:41)"
  (path  :UINT) ;; path #<typedef VGPath>
  (x  :FLOAT) ;; x #<typedef VGfloat>
  (y  :FLOAT) ;; y #<typedef VGfloat>
  (width  :FLOAT) ;; width #<typedef VGfloat>
  (height  :FLOAT) ;; height #<typedef VGfloat>
  (arc-width  :FLOAT) ;; arcWidth #<typedef VGfloat>
  (arc-height  :FLOAT) ;; arcHeight #<typedef VGfloat>
)
(export '&round-rect)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:86:41)
;;
(declaim (inline &rect))
(defcfun ("vguRect" &rect) error-code
  "see: (/opt/vc/include/VG/vgu.h:86:41)"
  (path  :UINT) ;; path #<typedef VGPath>
  (x  :FLOAT) ;; x #<typedef VGfloat>
  (y  :FLOAT) ;; y #<typedef VGfloat>
  (width  :FLOAT) ;; width #<typedef VGfloat>
  (height  :FLOAT) ;; height #<typedef VGfloat>
)
(export '&rect)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:82:41)
;;
(declaim (inline &polygon))
(defcfun ("vguPolygon" &polygon) error-code
  "see: (/opt/vc/include/VG/vgu.h:82:41)"
  (path  :UINT) ;; path #<typedef VGPath>
  (points  (:pointer :FLOAT)) ;; points #<POINTER #<typedef VGfloat>>
  (count  :INT) ;; count #<typedef VGint>
  (closed  :UINT) ;; closed #<typedef VGboolean>
)
(export '&polygon)


;;------------------------------------------------------------------------------
;; (/opt/vc/include/VG/vgu.h:78:41)
;;
(declaim (inline &line))
(defcfun ("vguLine" &line) error-code
  "see: (/opt/vc/include/VG/vgu.h:78:41)"
  (path  :UINT) ;; path #<typedef VGPath>
  (x0  :FLOAT) ;; x0 #<typedef VGfloat>
  (y0  :FLOAT) ;; y0 #<typedef VGfloat>
  (x1  :FLOAT) ;; x1 #<typedef VGfloat>
  (y1  :FLOAT) ;; y1 #<typedef VGfloat>
)
(export '&line)
 

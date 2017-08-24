(in-package #:vgu)
;;-----------------------------------------------------------------------------
(defun compute-warp-quad-to-quad ( dx0 dy0 dx1 dy1 dx2 dy2 dx3 dy3 sx0 sy0 sx1 sy1 sx2 sy2 sx3 sy3 matrix)
  (&compute-warp-quad-to-quad dx0 dy0 dx1 dy1 dx2 dy2 dx3 dy3 sx0 sy0 sx1 sy1 sx2 sy2 sx3 sy3 matrix))
(export 'compute-warp-quad-to-quad)


;;-----------------------------------------------------------------------------
(defun compute-warp-square-to-quad ( dx0 dy0 dx1 dy1 dx2 dy2 dx3 dy3 matrix)
  (&compute-warp-square-to-quad dx0 dy0 dx1 dy1 dx2 dy2 dx3 dy3 matrix))
(export 'compute-warp-square-to-quad)


;;-----------------------------------------------------------------------------
(defun compute-warp-quad-to-square ( sx0 sy0 sx1 sy1 sx2 sy2 sx3 sy3 matrix)
  (&compute-warp-quad-to-square sx0 sy0 sx1 sy1 sx2 sy2 sx3 sy3 matrix))
(export 'compute-warp-quad-to-square)


;;-----------------------------------------------------------------------------
(defun arc ( path x y width height startAngle angleExtent arcType)
  (&arc path x y width height startAngle angleExtent arcType))
(export 'arc)


;;-----------------------------------------------------------------------------
(defun ellipse ( path cx cy width height)
  (&ellipse path cx cy width height))
(export 'ellipse)


;;-----------------------------------------------------------------------------
(defun round-rect ( path x y width height arcWidth arcHeight)
  (&round-rect path x y width height arcWidth arcHeight))
(export 'round-rect)


;;-----------------------------------------------------------------------------
(defun rect ( path x y width height)
  (&rect path x y width height))
(export 'rect)


;;-----------------------------------------------------------------------------
(defun polygon ( path points count closed)
  (&polygon path points count closed))
(export 'polygon)

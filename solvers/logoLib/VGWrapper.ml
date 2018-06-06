open Vg
open Gg

type canvas = P.t

let new_canvas () = (P.sub (Gg.P2.v 0. 0.) P.empty)

let moveto c x y = P.sub  (P2.v x y) c
let lineto c x y = P.line (P2.v x y) c

let print_canvas canvas =
    print_endline (P.to_string canvas)

let size = Size2.v 400. 400.
let view = Box2.v P2.o (Size2.v 400. 400.)
let area = `O { P.o with P.width = 1. ; P.cap = `Round ; P.join = `Round }
let black = I.const Color.black

let output_canvas_png canvas desired fname =
  let image = I.cut ~area canvas black in
  let res = 1000. *. (float_of_int desired) /. (Gg.Size2.h size) in
  let fmt = `Png (Size2.v res res) in
  let warn w = Vgr.pp_warning Format.err_formatter w in
  let oc = open_out fname in
  let r = Vgr.create ~warn (Vgr_cairo.stored_target fmt) (`Channel oc) in
  ignore (Vgr.render r (`Image (size, view, image))) ;
  ignore (Vgr.render r `End) ;
  close_out oc

let canvas_to_1Darray canvas desired =
  let image = I.cut ~area canvas black in
  let res = (float_of_int desired) /. (Gg.Size2.h size) in
  let w,h = desired,desired in
  let stride = Cairo.Image.(stride_for_width A8 w) in
  let data = Bigarray.(Array1.create int8_unsigned c_layout (stride * h)) in
  let surface = Cairo.Image.(create_for_data8 data A8 ~stride w h) in
  let ctx = Cairo.create surface in
  Cairo.scale ctx ~x:res ~y:res;
  let target = Vgr_cairo.target ctx in
  let warn w = Vgr.pp_warning Format.err_formatter w in
  let r = Vgr.create ~warn target `Other in
  ignore (Vgr.render r (`Image (size, view, image))) ;
  ignore (Vgr.render r `End) ;
  Cairo.Surface.flush surface ;
  Cairo.Surface.finish surface ;
  data
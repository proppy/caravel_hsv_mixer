module __hsv2rgb__hsv2rgb(
  input wire [15:0] h,
  input wire [7:0] s,
  input wire [7:0] v,
  output wire [23:0] out
);
  // lint_off MULTIPLY
  function automatic [15:0] umul16b_8b_x_8b (input reg [7:0] lhs, input reg [7:0] rhs);
    begin
      umul16b_8b_x_8b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  // lint_off MULTIPLY
  function automatic [15:0] umul16b_8b_x_9b (input reg [7:0] lhs, input reg [8:0] rhs);
    begin
      umul16b_8b_x_9b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  // lint_off MULTIPLY
  function automatic [23:0] umul24b_8b_x_16b (input reg [7:0] lhs, input reg [15:0] rhs);
    begin
      umul24b_8b_x_16b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  // lint_off MULTIPLY
  function automatic [31:0] umul32b_8b_x_32b (input reg [7:0] lhs, input reg [31:0] rhs);
    begin
      umul32b_8b_x_32b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  wire [8:0] nh_fraction__1;
  wire [15:0] umul_502;
  wire [15:0] umul_504;
  wire [15:0] sub_505;
  wire [23:0] umul_508;
  wire [31:0] sub_509;
  wire [7:0] sextant__2;
  wire [31:0] u__1;
  wire [7:0] c__1;
  wire [7:0] sextant__3;
  wire [7:0] c__2;
  wire [24:0] add_526;
  wire eq_534;
  wire eq_535;
  wire [25:0] u__8;
  wire [31:0] u__2;
  wire eq_540;
  wire eq_541;
  wire eq_542;
  wire eq_543;
  wire [25:0] add_545;
  wire [31:0] u__3;
  wire [7:0] c__3;
  wire [2:0] concat_550;
  wire [7:0] d;
  wire [7:0] u__7;
  wire [2:0] concat_553;
  wire [2:0] concat_554;
  wire eq_555;
  assign nh_fraction__1 = 9'h100 - {1'h0, h[7:0]};
  assign umul_502 = umul16b_8b_x_8b(s, h[7:0]);
  assign umul_504 = umul16b_8b_x_9b(s, nh_fraction__1);
  assign sub_505 = 16'hff00 - umul_502;
  assign umul_508 = umul24b_8b_x_16b(v, sub_505);
  assign sub_509 = 32'h0000_ff00 - {16'h0000, umul_504};
  assign sextant__2 = h[15:8];
  assign u__1 = umul32b_8b_x_32b(v, sub_509);
  assign c__1 = 8'h00;
  assign sextant__3 = sextant__2 > 8'h05 ? 8'h05 : sextant__2;
  assign c__2 = 8'h00;
  assign add_526 = {1'h0, umul_508} + {9'h000, umul_508[23:8]};
  assign eq_534 = sextant__3 == c__2;
  assign eq_535 = sextant__3 == 8'h05;
  assign u__8 = {1'h0, add_526};
  assign u__2 = u__1 + {c__1, u__1[31:8]};
  assign eq_540 = sextant__3 == 8'h01;
  assign eq_541 = sextant__3 == 8'h02;
  assign eq_542 = sextant__3 == 8'h03;
  assign eq_543 = sextant__3 == 8'h04;
  assign add_545 = u__8 + {18'h0_0000, v};
  assign u__3 = u__2 + {24'h00_0000, v};
  assign c__3 = 8'h00;
  assign concat_550 = {eq_543, eq_540, eq_534 | eq_535};
  assign d = add_545[23:16];
  assign u__7 = u__3[23:16];
  assign concat_553 = {eq_542, eq_540 | eq_541, eq_534};
  assign concat_554 = {eq_535, eq_542 | eq_543, eq_541};
  assign eq_555 = s == c__3;
  assign out = {eq_555 ? v : v & {8{concat_550[0]}} | d & {8{concat_550[1]}} | u__7 & {8{concat_550[2]}}, eq_555 ? v : u__7 & {8{concat_553[0]}} | v & {8{concat_553[1]}} | d & {8{concat_553[2]}}, eq_555 ? v : u__7 & {8{concat_554[0]}} | v & {8{concat_554[1]}} | d & {8{concat_554[2]}}};
endmodule

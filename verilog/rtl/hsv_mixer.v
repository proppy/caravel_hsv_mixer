`default_nettype none
`timescale 1ns/1ns
module hsv_mixer (
    input clk,
    input reset,
    input enc0_a,
    input enc0_b,
    input enc1_a,
    input enc1_b,
    input enc2_a,
    input enc2_b,
    output pwm0_out,
    output pwm1_out,
    output pwm2_out
);
    wire enc0_a_db, enc0_b_db;
    wire enc1_a_db, enc1_b_db;
    wire enc2_a_db, enc2_b_db;
    wire [10:0] enc0;
    wire [7:0] enc1;
    wire [7:0] enc2;

    // debouncers, 2 for each encoder
    hsv_debounce #(.HIST_LEN(8)) debounce0_a(.clk(clk), .reset(reset), .button(enc0_a), .debounced(enc0_a_db));
    hsv_debounce #(.HIST_LEN(8)) debounce0_b(.clk(clk), .reset(reset), .button(enc0_b), .debounced(enc0_b_db));

    hsv_debounce #(.HIST_LEN(8)) debounce1_a(.clk(clk), .reset(reset), .button(enc1_a), .debounced(enc1_a_db));
    hsv_debounce #(.HIST_LEN(8)) debounce1_b(.clk(clk), .reset(reset), .button(enc1_b), .debounced(enc1_b_db));

    hsv_debounce #(.HIST_LEN(8)) debounce2_a(.clk(clk), .reset(reset), .button(enc2_a), .debounced(enc2_a_db));
    hsv_debounce #(.HIST_LEN(8)) debounce2_b(.clk(clk), .reset(reset), .button(enc2_b), .debounced(enc2_b_db));

    // encoders
    hsv_encoder #(.WIDTH(11)) encoder0(.clk(clk), .reset(reset), .a(enc0_a_db), .b(enc0_b_db), .value(enc0));
    hsv_encoder #(.WIDTH(8)) encoder1(.clk(clk), .reset(reset), .a(enc1_a_db), .b(enc1_b_db), .value(enc1));
    hsv_encoder #(.WIDTH(8)) encoder2(.clk(clk), .reset(reset), .a(enc2_a_db), .b(enc2_b_db), .value(enc2));

   wire [10:0] hue;
   assign hue = enc0 > 11'h5ff ? 11'h5ff: enc0;
   wire [23:0] rgb;
   __hsv2rgb__hsv2rgb hsv2rgb0(.h({5'b0,hue}), .s(enc1), .v(enc2), .out(rgb));
   wire [7:0]  r = rgb[23:16];
   wire [7:0]  g = rgb[15:8];
   wire [7:0]  b = rgb[7:0];
   
    // pwm modules
    hsv_pwm #(.WIDTH(8)) pwm0(.clk(clk), .reset(reset), .out(pwm0_out), .level(r));
    hsv_pwm #(.WIDTH(8)) pwm1(.clk(clk), .reset(reset), .out(pwm1_out), .level(g));
    hsv_pwm #(.WIDTH(8)) pwm2(.clk(clk), .reset(reset), .out(pwm2_out), .level(b));

endmodule

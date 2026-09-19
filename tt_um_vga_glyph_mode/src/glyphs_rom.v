`default_nettype none

// Character ROM for the falling-glyph rain.
//
// Instead of holding a generic character set, this ROM holds the message
// "Colegio de Muntinlupa " one glyph per index, so the rain spells the
// message out as it falls. Index 21 is a trailing space that separates
// each repetition of the message.
//
//   0:C  1:o  2:l  3:e  4:g  5:i  6:o  7:_  8:d  9:e 10:_
//  11:M 12:u 13:n 14:t 15:i 16:n 17:l 18:u 19:p 20:a 21:_
//
// Glyph cell is 8 px wide by 12 px tall. Capitals occupy rows 2..10,
// lowercase x-height rows 5..10, ascenders from row 2, descenders to row 11.
module glyphs_rom(
    input  wire [5:0] c, input  wire [3:0] y, input  wire [2:0] x, output reg pixel
);
    reg [7:0] rb;

    always @(*) begin
        case (c)
            0:  case(y) 2,10:rb=8'h7E; 3,9:rb=8'hC3; 4,5,6,7,8:rb=8'hC0; default:rb=0; endcase // C
            1:  case(y) 5,10:rb=8'h3C; 6,7,8,9:rb=8'h66; default:rb=0; endcase // o
            2:  case(y) 2,3,4,5,6,7,8,9:rb=8'h18; 10:rb=8'h3C; default:rb=0; endcase // l
            3:  case(y) 5,10:rb=8'h3C; 6,9:rb=8'h66; 7:rb=8'h7E; 8:rb=8'h60; default:rb=0; endcase // e
            4:  case(y) 5,9:rb=8'h3E; 6,7,8:rb=8'h66; 10:rb=8'h06; 11:rb=8'h3C; default:rb=0; endcase // g
            5:  case(y) 3,5,6,7,8,9:rb=8'h18; 10:rb=8'h3C; default:rb=0; endcase // i
            6:  case(y) 5,10:rb=8'h3C; 6,7,8,9:rb=8'h66; default:rb=0; endcase // o
            7:  rb = 8'h00; // SPACE
            8:  case(y) 2,3,4:rb=8'h06; 5,10:rb=8'h3E; 6,7,8,9:rb=8'h66; default:rb=0; endcase // d
            9:  case(y) 5,10:rb=8'h3C; 6,9:rb=8'h66; 7:rb=8'h7E; 8:rb=8'h60; default:rb=0; endcase // e
            10: rb = 8'h00; // SPACE
            11: case(y) 2,6,7,8,9,10:rb=8'hC3; 3:rb=8'hE7; 4:rb=8'hFF; 5:rb=8'hDB; default:rb=0; endcase // M
            12: case(y) 5,6,7,8,9:rb=8'h66; 10:rb=8'h3E; default:rb=0; endcase // u
            13: case(y) 5:rb=8'h7C; 6,7,8,9,10:rb=8'h66; default:rb=0; endcase // n
            14: case(y) 3,4,6,7,8,9:rb=8'h18; 5:rb=8'h3C; 10:rb=8'h1C; default:rb=0; endcase // t
            15: case(y) 3,5,6,7,8,9:rb=8'h18; 10:rb=8'h3C; default:rb=0; endcase // i
            16: case(y) 5:rb=8'h7C; 6,7,8,9,10:rb=8'h66; default:rb=0; endcase // n
            17: case(y) 2,3,4,5,6,7,8,9:rb=8'h18; 10:rb=8'h3C; default:rb=0; endcase // l
            18: case(y) 5,6,7,8,9:rb=8'h66; 10:rb=8'h3E; default:rb=0; endcase // u
            19: case(y) 5,9:rb=8'h7C; 6,7,8:rb=8'h66; 10,11:rb=8'h60; default:rb=0; endcase // p
            20: case(y) 5:rb=8'h3C; 6:rb=8'h06; 7,10:rb=8'h3E; 8,9:rb=8'h66; default:rb=0; endcase // a
            21: rb = 8'h00; // TRAILING SPACE
            default: rb = 8'h00;
        endcase
        pixel = rb[7-x];
    end
endmodule

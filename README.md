# TP_FPGA_ZZ3

These four projects have been made using Quartus pro v9.1 and using an Altera FPGA ( Field-Programmable Gates Array) single board.

> Not sure about the board (^^;)

## Lab 1 : Decoder 7 segment ✅
### Combinatory VHDL

![7Segment](https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/7_Segment_Display_with_Labeled_Segments.svg/150px-7_Segment_Display_with_Labeled_Segments.svg.png)

Component to convert a 4 bits HEX input into a 7 bits output to display HEX value onto a 7 segment display. 

*ps : (We don't have the DP dot on our board).*

## Lab light : Generic AND ✅
### Combinary VHDL

> Need an image (^^;)

Component using **FOR loop** to chain n-1 AND_2bits gates to make a AND_Nbits gate.

## Lab 2 : Generic Arithmetic Logic Unit ✅
### Combinatory VHDL

![enter image description here](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSrUAmzlgQ_5kUDDyjs610mmzCY0Z5fwOx2sKDwg2QD6iGT41u-i5sZqHF4ctMnMTWx7dQ&usqp=CAU)

Component to make different operations on N bits inputs. This ALU have 9 operations depending on select commands input.

|Select value| Operation |
|--|--|
| 0 | Adder : S = A + B |
| 1 | Latch : S = A |
| 2 | Incrementer : S = A + 1 |
| 3 | Shift-Right : S = A >> 1 |
| 4 | Shift-Left : S = A << 1 |
| 5 | AND : S = A & B |
| 6 | OR : S = A \| B |
| 7 | XOR : S = A ^ B |
| 8 | NOT : S = ~A |
| others | Latch : S = B |

## Lab 3 : Chronometer ✅
### Sequential VHDL

> Need an image (^^;)

Component to use the Quartz component on board to count the time.

For our board, the frequency is 50MHz, so we use three counter to make a chronometer that can count seconds and minutes.

 - First counter that goes from 0 to 50Mega to trigger event every seconds
 - Seconds counter that goes from 0 to 59 to know how many seconds has gone and trigger event every minutes
 - Third counter that goes from 0 to 59 to know how many minutes has gone and can as well trigger event every hours

Just that is good enough, but we wanted to display it on a 7 segments display. So we wanted to use Lab 1 Component. But it display HEX values, not decimal values.

To make it work, we use the **Double dabble** algorithm. This algorithm can be made generic, but for this one, I just wanted to convert seconds and minutes so I did a 8 bits double dabble.

> Good challenge if you want to improve it (\^~^)

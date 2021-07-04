## UART with parity bit
There is a basic UART that support optional parity bit, settable baud and data width, written in Verilog with testbenches.


<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary>Table of Contents</summary>
   <ol>
    <li><a href="#Structure">Structure</a></li>
    <li><a href="#BitRule">BitRule</a></li>
    <li><a href="#TX">TX</a></li>
    <li><a href="#RX">RX</a></li>
  </ol>
</details>

## Structure
![Structure](img/structure.png)

## BitRule

![Structure](img/bit_rule.png)

## TX
### State machine
![Structure](img/TX_state_machine.png)
### ASMD
![Structure](img/TX.png)

## RX
### State machine
![Structure](img/RX_state_machine.png)
### ASMD
![Structure](img/RX.png)

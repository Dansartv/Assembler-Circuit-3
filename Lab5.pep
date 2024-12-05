         LDWA 0x0000,i     ; Load the value 0 into the AC
         STWA index,d      ; Store it in the 'index' variable
         STWA total,d      ; Store it in the 'total' variable

         CALL load         ; Call the 'load' subroutine to populate the 'values' array

forloop: LDWA index,d   ; Load 'index' variable into AC
         CPWA 10,i      ; Compare it with 10
         BREQ isdone    ; If equal, exit the loop

         LDWX index,d   ; Load 'values[index]' into AC
         ASLX           ; Multiply it by 2 (WORD size is 2 bytes)

         LDWX index,d   ; Load 'values[index]' again into AC
         ADDX 0x0001,i  ; Add it to 'total'
         STWX index,d   ; Store the updated value in 'values[index]'

         BR forloop     ; Continue the loop

isdone: LDWA total,d    ; Load 'total' into AC
        STRO total,d    ; Output the contents of the total variable 
        STOP            ; Halt the program

; load subroutine

load: SUBSP 2,i         ; Allocate space for local variables
      LDWA  0x00, i     ; Load the value 0 into the AC
      STWA  0,s         ; Store it in the subroutine's local variable space

loadloop: LDWA 0,s      ; Load the current count from the local variable space
         CPWA 10,i      ; Compare it with 10
         BREQ loaddone  ; If equal, exit the subroutine

         LDWX 0,s       ; Load 'values[count]' into AC
         ASLX           ; Multiply it by 2 (assuming WORD size is 2 bytes)

         DECI values,x  ; Input a value into 'values[count]'

         LDWX 0,s       ; Load 'values[count]' again into AC
         ADDX 0x0001,i  ; Add it to 'count'
         STWX 0,s       ; Store the updated value in 'values[count]'

         BR loadloop    ; Continue the loop

loaddone: ADDSP 2,i     ; Deallocate local variable space
         RET            ; Return from the subroutine

total: .WORD 0          ; Initialize 'total' variable with 0
index: .WORD 0          ; Initialize 'index' variable with 0
values: .BLOCK 20       ; Allocate space for the 'values' array
.END
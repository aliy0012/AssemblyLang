; Big_E_Reverse.asm


; Date: 2021-07-29

; Purpose       Copy and Convert Little Endian data to a new Big Endian data array

        org     $1000
Little_Endian                   ; Array of 16 bit Little Endian words
        dw      $1234, $2888, $AA55, $00FF, $FF00, $55AA, $0101,$FF00
End_Little_Endian
                                ; Destination Array goes starting here
                                ; where ds.w reserve a Word (16 bytes)
                                ; and LEN of the array is dynamically
                                ; calculated as taught in class, keeping in mind
                                ; that the ds statement should reserve bytes
                                ; of memory, not words of memory.

                org     $1010
Big_Endian      dw      End_Little_Endian-Little_Endian         ;dynamic memory allocation for size of array   
End_Big_Endian

             org        $1020
Reverse                 dw        End_Big_Endian-Big_Endian                ;dynamic memory allocation for size of array   
End_Reverse
       
        org     $2000
Start   lds     #$2000         ;Stack location
        ldx     #Little_Endian                ;point to start of Little_Endian array
        ldy     #Big_Endian                   ;point to start adress of Big_endiann array
Loop    ldd    2,x+                           ;loading d accumulator, an then incrementing x by 2
        exg     a,b                           ;exchanging b and a acummulator
        std    2,y+                           ;storing accumulator and then incrementing y index by 2                                                                 ;incrementing y index by one
        clrb                                   ;clearing b
        clra                                    ;clearing a
        cpx     #End_Little_Endian             ;comparing if the x index is at the end of the array
        bne     Loop                           ;if no back to loop                                                                    ;Yes, ending program
        end
		
		
                ;--Reverse array code--

        ldx     #Big_Endian              ;point to start of Little_Endian array
        ldy     #$102F                  ;point to end adress of Big_endian array
Loop2   ldaa    1,x+                     ;loading a accumulator and then incrementing x index by 1
        staa    1,y-                     ;storing a in y index and then decrementing y by 1
        clra                             ;clearing a
        cpx      #Reverse                ;comparing if the x index is at the end of the array
        bne      Loop2                   ;if no back to loop                                                                   
        end
                swi

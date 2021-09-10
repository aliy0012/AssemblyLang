; Endian.asm


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

                org                $1010
Big_Endian      dw                End_Little_Endian-Little_Endian         ;dynamic memory allocation for size of array   
End_Big_Endian

               
;Reverse
;End_Reverse
       
        org     $2000
Start   lds                #$2000             ;Stack location
        ldx     #Little_Endian                ;point to start of Little_Endian array
        ldy     #Big_Endian                   ;point to start adress of Big_endiann array
Loop    ldd    2,x+                           ;loading acummulator d and yhen incrementing x by 2
        exg     a,b                           ;exchanging b and a acummulator
        std    2,y+                           ;storing a ccumulator in 1+y                                                                    ;incrementing y index by one
        clrb                                  ;clearing b
        clra                                  ;clearing a
        cpx      #End_Little_Endian           ;comparing if the x index is at the end of the array Little_Endian
        bne      Loop                         ;if no back to loop
        swi                                   ;Yes, ending program
        end
                

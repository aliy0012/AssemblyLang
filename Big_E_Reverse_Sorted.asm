; Big_E_Reverse_Sorted.asm


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
Big_Endian                dw                End_Little_Endian-Little_Endian         ;dynamic memory allocation for size of array   
End_Big_Endian

             org                $1020
Reverse                        dw                        End_Big_Endian-Big_Endian
End_Reverse
       
                org     $2000
Start        lds                #$2000                                ;Stack location
        ldx     #Little_Endian                ;point to start of Little_Endian array
        ldy     #Big_Endian                   ;point to start adress of Big_endiann array
Loop    ldd    2,x+                          ;loading d accumulator, and then incrementing x index by 2
        exg     a,b                          ;exchanging b and a acummulator
        std    2,y+                                ;storing d accumulator in y index then incrementing y by 2                                                                 ;incrementing y index by one
        clrb                                ;clearing b
        clra                                ;clearing a
        cpx      #End_Little_Endian         ;comparing if the x index is at the end of the array
        bne      Loop                        ;if no back to loop              ;Yes, ending program
        end
            
                                ;--Start of Reverse array implementation

        ldx     #Big_Endian              ;point to start of Little_Endian array
        ldy     #$102F
Loop2   ldaa    1,x+                     ;loading a with 1,x                           
        staa    1,y-                     ;storing a in y index and then decrementing y by 1                                     
        clra                                                                        ;clearing a
        cpx      #Reverse                               ;comparing if the x index is at the end of the array
        bne      Loop2                                                        ;if no back to loop                                                                    ;Yes, ending program
        end
                
                ; -- Start of Insertion Sort Code --
                
                ldx     #$1020					;pinting x to start of Reverse array
LoopFor
                cpx     #$102F                 ;Comparing if end of Reverse  array
                beq     EndForLoop             ;If is end of array, then ending for loop
                ldab    0,x                   ;Storing first value in b
                leay    0,x                   ;pointing y to first value of array
StartWhile
                cpy     #Reverse               ;comparing to see if y is at start of Reverse array
                bls     EndWhile               ;if at start of array then going to while loop
                ldaa    -1,y					;loading a accumulator with y-1 index
                cba                           ;comparing first element
                bls     EndWhile
                staa    0,y						;storing a accumulator value in y pointer location
                dey                            ;if greater branch to StartWhile
                bra     StartWhile
EndWhile
                stab    0,y                     ;insering sorted element
                inx
                bra     LoopFor                 ;start to sorting other element
EndForLoop
                swi
                end
                
                swi								;ending program

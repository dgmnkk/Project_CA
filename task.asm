.model small
.stack 100h

.data
oneChar db ?
numbersCount dw 0             

.code
main:
    mov ax, @data
    mov ds, ax

    call read_next
    call print_numbers

    mov ah, 4Ch
    int 21h

read_next:
      mov ah, 3Fh
    mov bx, 0h 
    mov cx, 1  
    mov dx, offset oneChar  
    int 21h 

    ; do something with [oneChar]
    cmp oneChar, ' '    
    je saveNumber        
    cmp oneChar, 0Dh     
    je saveNumber        
    cmp oneChar, 0Ah     
    je saveNumber       

    or ax, ax            
    jnz read_next       
    ret

saveNumber:
    push ax
    inc numbersCount    
    ret



print_numbers:
    mov cx, numbersCount              

print_loop:
    pop ax                
    mov dl, al             
    mov ah, 02h           
    int 21h               
    loop print_loop        

    ret

parseNumbers:
    ; розділення рядка на окремі числа та збереження їх у масив
    ret

sort:
    ; сортування масиву чисел
    ret

calculateAverage:
    ; обчислення середнього значення
    ret

calculateMedian:
    ; обчислення медіани
    ret
end main
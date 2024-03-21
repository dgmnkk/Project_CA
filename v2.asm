.model small
.stack 100h

.data
oneChar db ?
numbersCount dw 0             
numbersArray dw 100 dup (0)   ; Масив для збереження чисел

.code
main:
    mov ax, @data
    mov ds, ax

    call read_next
    call print_numbers

    mov ah, 4Ch
    int 21h

read_next:
    mov ah, 03fh
    mov bx, 0h 
    mov cx, 1  
    mov dx, offset oneChar  
    int 21h 

    cmp oneChar, 20h    
    je saveNumber        
    cmp oneChar, 0Dh     
    je saveNumber        
    cmp oneChar, 0Ah     
    je saveNumber       

    or ax, ax            
    jnz read_next       
    ret

saveNumber:
    mov [numbersArray + si], ax  ; Зберігаємо число у масиві
    add si, 2                    ; Збільшуємо індекс на 2, оскільки кожне число займає 2 байти (dw)
    inc numbersCount             ; Збільшуємо лічильник чисел
    ret

print_numbers:
    mov cx, numbersCount              
    mov si, offset numbersArray              

print_loop:
    mov ax, [si]                 ; Завантажуємо число з масиву
    call print_number            ; Виводимо число
    add si, 2                    ; Збільшуємо індекс на 2, оскільки кожне число займає 2 байти (dw)
    loop print_loop        

    ret

print_number:
    mov dx, ax                   ; Завантажуємо число для виводу
    mov ah, 09h                  ; Виводимо число
    int 21h
    ret

sort:
    mov cx, word ptr numbersCount
    dec cx  ; count-1
outerLoop:
    push cx
    lea si, numbersArray
innerLoop:
    mov ax, [si]
    cmp ax, [si+2]
    jl nextStep
    xchg [si+2], ax
    mov [si], ax
nextStep:
    add si, 2
    loop innerLoop
    pop cx
    loop outerLoop
    ret

calculateAverage:
    ; обчислення середнього значення
    ret

calculateMedian:
    ; обчислення медіани
    ret
end main 

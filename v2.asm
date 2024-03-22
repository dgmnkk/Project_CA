.model small
.stack 100h
.data
    space db '', '$'
    buff db 1000 dup(?)
    numbersArray dw 100 dup(?)
    numberCount dw ?
    
.code
start:
    mov ax, @data
    mov ds, ax

    mov ax, numbersArray
    call input
    call output

    mov ax, 4C00h
    int 21h

    input proc 
        startPr:
            mov ah,0ah
            xor di,di
            mov dx, offset buff 
            int 21h 
            mov dl,0ah
            mov ah,02
            int 21h
            
        
        mov si,offset buff+2 
        loopBuff:
            cmp byte ptr [si],"-" 
            jnz ii1
            inc si  
        ii1:
            xor ax,ax
            mov bx,10 
        ii2:
            mov cl,[si] 

            cmp cl,0dh  
            jz endin
            
            cmp cl, ' '
            je newNum

        
            sub cl,'0'  
            mul bx     
            add ax,cx  
            inc si     
            jmp ii2   

            xor cl, cl
            jmp loopBuff
    
        newNum:
            xor cl, cl
            mov bx, ax
            inc si
            mov numbersArray[di], ax
            add di, 2
            jmp loopBuff
    
        endin:
            xor cl, cl
            mov numbersArray[di], ax
            add di, 2
            xor ax, ax
            mov bx, 2
            mov numberCount, di
            mov ax, numberCount
            div bx
            mov numberCount, ax
            xor bx, bx
            ret
    
    input endp

    output proc
        xor dx, dx
        xor ax, ax

        xor di, di
        xor si, si
        mov si, numberCount
        stLoop:
            mov ax, numbersArray[di]
            
            call outputNum
            oi4:
                add di, 2
                dec si
                cmp si, 0
                jbe exit
            loop stLoop

        exit:
            ret
    output endp

    outputNum PROC
        ouput1:  
                xor bx, bx
                xor     cx, cx
                mov     bx, 10 
            output2:
                xor     dx,dx
                div     bx
                push    dx
                inc     cx
                test    ax, ax
                jnz     output2
                mov     ah, 02h
            output3:
                pop     dx
                add     dl, '0'
                int     21h
                loop    output3
        ret
    outputNum ENDP

    sort PROC
        mov cx, word ptr numberCount
            dec cx 
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
    sort ENDP

    median PROC
            ; розрахунок медіани
    median ENDP

    average PROC
        ; розрахунок середнього арифметичного
    average ENDP
end start
.model small
.stack 100h
.data
    numbersArray DW 100 dup (?)
    numberCount dw ?
    oneChar db ?

    sum dw ?
    average dw ?
    median dw ?
.code

main:
    mov ax, @data
    mov ds, ax

    call calcMedian
    mov ax, median
    call outputNum
    
    call calcAverage
    mov ax, average   
    call outputNum
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
            sub cl, '0'
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

    outputNum PROC
        ; виведення числа, що збережене у регістрі ах 
        outputStart: 
                xor bx, bx
                xor cx, cx
                mov bx, 10 
        getDigits:
                xor dx, dx
                div bx ; ділимо ax на 10
                push dx ; остачу зберігаємо в стек
                inc cx ; лічильник кількості цифр в числі

                test ax, ax ; перевіряємо, чи ax = 0 (так як ми ділимо число на 10, остачу зберігаємо в стек,
                ;то наша операція закінчиться, коли число буде = 0, а отже всі цифри з числа ми зберегли в стек і можемо їх виводити 
                jnz getDigits

                mov ah, 02h
        showDigits:
                pop dx ;дістаємо всі цифри
                add dl, '0' ;перетворюємо його по ascii таблиці на символ
                int 21h ;вивід
                loop showDigits  ; цикл повторюватиметься поки cx != 0          
        ret
    outputNum ENDP

    calcMedian PROC
        ; розрахунок медіани
        call sort ; сортуємо масив для подальшого знаходження медіани масиву
        mov ax, numberCount ; переміщуємо кількість чисел у масиві в регістр ax

        test al, 1 ;при операції кон'юнкції будь-якого числа з 0001 результат буде 0, якщо число парне, а 1, якщо непарне
        jnz odd_count ; якщо непарна кількість, то ідемо до odd_cound

        shr ax, 1 ; виконуємо бітовий зсув вправо на одну позицію, це еквівалентно діленню на 2 з відокремненням цілої частини
        mov bx, ax
        dec bx
        mov ax, numbersArray[bx] ; зберігаємо перше серединне число
        add ax, numbersArray[bx+1] ; додаємо до першого серединного числа друге
        shr ax, 1 ; ділимо їх
        jmp save_median
        odd_count:
            mov bx, ax
            mov ax, numbersArray[bx]
            jmp save_median
        save_median:
            mov median, ax ; збереження медіани
        ret
    calcMedian ENDP

    calcAverage PROC
        ; розрахунок середнього арифметичного
        xor bx, bx ; лічильник циклу, обнулямо його (int i = 0)
        mov cx, numberCount ; зберігаємо для операції loop кількість чисел в масиві
        sum_loop:
            mov ax, numbersArray[bx] ; зберігаємо поточне число в регістр ax
            add sum, ax ; додаємо до суми
            inc bx ; i++
            loop sum_loop ; продовжуємо цикл, поки cx != 0

        mov ax, sum 
        idiv numberCount ; ділимо суму на кількість чисел в масиві 
        mov average, ax ; зберігаємо середнє арифметичне
        ret
    calcAverage ENDP

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
        ret  
    sort ENDP
end main
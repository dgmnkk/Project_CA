.model small
.stack 100h

.data
numbersBuffer dw 10000 dup(?) ; буфер для зберігання чисел
numbersCount dw 0               ; кількість чисел

.code
main:
    mov ax, @data
    mov ds, ax

    call readInput
    call print_numbers

    mov ah, 4Ch
    int 21h

readInput:
    mov si, offset numbersBuffer  ; початкова адреса буфера
    mov cx, 10000                 ; максимальна кількість чисел, які можна зчитати
    mov numbersCount, 0           ; обнуляємо лічильник чисел

read_next_character:
    ; Зчитування наступного символу
    mov ah, 3Fh         ; DOS function for buffered input
    mov bx, 0h          ; stdin handle
    mov cx, 1           ; 1 byte to read
    mov dx, si          ; адреса, куди буде зчитано число
    int 21h             ; виклик DOS interruption

    ; Перевірка кінця вводу (EOF)
    or al, al           ; перевіряємо, чи символ - кінець файлу
    jz end_input        ; якщо так, закінчуємо ввод

    ; Перевірка, чи зчитаний символ - пробіл або символ нового рядка
    cmp al, ' '         ; перевіряємо, чи символ - пробіл
    je read_next_character      ; якщо так, пропускаємо символ і переходимо до наступного
    cmp al, 0Dh         ; перевіряємо, чи символ - CR (знову перевірка для DOS)
    je read_next_character      ; якщо так, пропускаємо символ і переходимо до наступного
    cmp al, 0Ah         ; перевіряємо, чи символ - LF (знову перевірка для DOS)
    je read_next_character      ; якщо так, пропускаємо символ і переходимо до наступного

    ; Якщо це не пробіл, CR або LF, зберігаємо символ у буфері
    mov [si], al        ; зберігаємо символ у буфері
    inc si              ; збільшуємо адресу буфера для наступного символу
    jmp read_next_character

end_input:
    ret


print_numbers:
    mov si, offset numbersBuffer  ; початкова адреса буфера

print_next_number:
    ; Зчитування наступного символу з буфера
    mov al, [si]        ; зчитуємо символ з буфера

    ; Виведення числа у консоль
    mov ah, 02h         ; DOS function for displaying character
    mov dl, al          ; завантажуємо символ для виводу
    int 21h             ; виклик DOS interruption

    ; Перехід до наступного символу
    inc si              ; збільшуємо адресу буфера для наступного символу
    test al, al         ; перевіряємо, чи досягнули кінця буфера (символ кінця рядка)
    jnz print_next_number   ; якщо ні, продовжуємо вивід

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
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
    call parseNumbers
    call sort
    call calculateAverage
    call calculateMedian
    call writeOutput

    mov ah, 4Ch
    int 21h

readInput:
    ; читання рядка з stdin та зберігання чисел у масив
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

writeOutput:
    ; виведення середнього значення та медіани
    ret
end main
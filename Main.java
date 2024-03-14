import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
public class Main {
    public static void main(String[] args) throws IOException {
        BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
        String line;
        StringBuilder inputBuilder = new StringBuilder();

        while ((line = br.readLine()) != null) {
            inputBuilder.append(line).append("\n");
        }
        String input = inputBuilder.toString().trim();

        String[] numbersAsString = input.split("[\\s]+");
        int[] numbers = new int[numbersAsString.length];
        convertToBinary(numbers, numbersAsString);
        bubbleSort(numbers);
        System.out.println("Median: " + getMedian(numbers));
        System.out.println("Average: " + getAverage(numbers));
    }
    private static int toTwosComplement(int num) {
        if (num >= 0) {
            return num;
        } else {
            return (int) (Math.pow(2, 16) - Math.abs(num));
        }
    }
    private static void convertToBinary(int[] numbers, String[] numbersAsString){
        for (int i = 0; i < numbersAsString.length; i++) {
            try {
                numbers[i] = toTwosComplement(Integer.parseInt(numbersAsString[i]));
            } catch (NumberFormatException e) {
                System.err.println("Помилка у введених даних: " + numbersAsString[i]);
                numbers[i] = 0;
            }
        }
    }


    private static void bubbleSort(int[] arr) {
        int n = arr.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }


    private static double getMedian(int[] numbers){
        if (numbers.length % 2 == 0) {
            return (numbers[numbers.length / 2 - 1] + numbers[numbers.length / 2]) / 2.0;
        } else {
            return numbers[numbers.length / 2];
        }
    }

    private static double getAverage(int[] numbers){
        double sum = 0;
        for (int num : numbers) {
            sum += num;
        }
        return sum / numbers.length;
    }
}

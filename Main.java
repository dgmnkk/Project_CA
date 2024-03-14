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
    }

    private static void convertToBinary(int[] numbers, String[] numbersAsString){
        for (int i = 0; i < numbersAsString.length; i++) {
            try {
                numbers[i] = Integer.parseInt(numbersAsString[i]);
            } catch (NumberFormatException e) {
                System.err.println("Number format exception: " + numbersAsString[i]);
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
}

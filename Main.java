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
        mergeSort(numbers, 0, numbers.length - 1);
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


    private static void mergeSort(int[] arr, int l, int r) {
        if (l < r) {
            int m = (l + r) / 2;
            mergeSort(arr, l, m);
            mergeSort(arr, m + 1, r);
            merge(arr, l, m, r);
        }
    }

    private static void merge(int[] arr, int l, int m, int r) {
        int n1 = m - l + 1;
        int n2 = r - m;

        int[] L = new int[n1];
        int[] R = new int[n2];

        for (int i = 0; i < n1; ++i)
            L[i] = arr[l + i];
        for (int j = 0; j < n2; ++j)
            R[j] = arr[m + 1 + j];

        int i = 0, j = 0;

        int k = l;
        while (i < n1 && j < n2) {
            if (L[i] <= R[j]) {
                arr[k] = L[i];
                i++;
            } else {
                arr[k] = R[j];
                j++;
            }
            k++;
        }

        while (i < n1) {
            arr[k] = L[i];
            i++;
            k++;
        }

        while (j < n2) {
            arr[k] = R[j];
            j++;
            k++;
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

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
        String input = inputBuilder.toString().trim(); // Отримання рядка даних без пробілів на початку і в кінці

        String[] numbersAsString = input.split("[\\s]+");
        int[] numbers = new int[numbersAsString.length];
    }
}

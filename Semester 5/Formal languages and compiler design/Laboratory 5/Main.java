import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        Grammar parser = new Grammar("g1.txt");
        parser.initializeFromFile();

        parser.printNonTerminals();
        parser.printTerminals();
    }
}
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;

public class Main2 {
    public static void main(String[] args) throws IOException {
        Grammar grammar = new Grammar("g4.txt");
        grammar.initializeFromFile();

        Parser parser = new Parser(grammar);

        parser.buildParsingTable();

        Table parseTable = parser.getParsingTable();

        List<String> inputSequence = readInputSequenceFromFile("seq.txt");
        //System.out.println(inputSequence);

        String outputFileName = "out1.txt";

        String inputSequenceString = String.join(" ", inputSequence);
        //System.out.println(inputSequenceString);

        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\nChoose an option:");
            System.out.println("1. Print First Set");
            System.out.println("2. Print Follow Set");
            System.out.println("3. Print Parsing Table");
            System.out.println("4. Parse Input Sequence");
            System.out.println("0. Exit");

            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    printAllFirstSets(grammar, parser);
                    break;
                case 2:
                    printAllFollowSets(grammar, parser);
                    break;
                case 3:
                    System.out.println(parseTable);
                    break;
                case 4:
                    parseInputSequence(parser, inputSequenceString, outputFileName);
                    break;
                case 0:
                    System.exit(0);
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
    }

    private static List<String> readInputSequenceFromFile(String filename) throws IOException {
        return Files.readAllLines(Paths.get(filename));
    }

    private static void writeResultToFile(String fileName, String content) {
        try (FileWriter writer = new FileWriter(fileName)) {
            writer.write(content);
        } catch (IOException e) {
            System.out.println("Error writing to file: " + e.getMessage());
        }
    }

    private static void printAllFirstSets(Grammar grammar,Parser parser) {
        for (String nonTerminal : grammar.getNonTerminals()) {
            Set<String> firstSet = parser.first(nonTerminal, new HashSet<>());
            System.out.println("First Set of " + nonTerminal + ": " + firstSet);
        }
    }

    private static void printAllFollowSets(Grammar grammar, Parser parser) {
        for (String nonTerminal : grammar.getNonTerminals()) {
            Set<String> followSet = parser.follow(nonTerminal);
            System.out.println("Follow Set of " + nonTerminal + ": " + followSet);
        }
    }

    private static void parseInputSequence(Parser parser, String input, String outputFileName) {
//        System.out.println("Enter a sequence (space-separated):");
//        String input = scanner.nextLine();
//        List<String> transformedInput = Arrays.asList(input.replace("\n", "").split(" "));
//        boolean parseResult = parser.parse(transformedInput);
//
//        if (parseResult) {
//            System.out.println("Sequence parsed successfully!");
//            System.out.println("Output Stack: " + parser.outputStack);
//        } else {
//            System.out.println("Parsing failed.");
//        }
        System.out.println("Input Sequence: " + input);
        List<String> transformedInput = preprocessInput(input);

        boolean parseResult = parser.parse(transformedInput);

        if (parseResult) {
            System.out.println("Sequence parsed successfully!");
            System.out.println("Output Stack: " + parser.outputStack);

            writeResultToFile(outputFileName, "Sequence parsed successfully!\nOutput Stack: " + parser.outputStack);

        } else {
            System.out.println("Parsing failed.");

            writeResultToFile(outputFileName, "Parsing failed.");
        }
    }
    private static List<String> preprocessInput(String input) {
        // Remove unwanted characters such as brackets
        input = input.replaceAll("[\\[\\]]", "");

        // Split the input into a list of elements
        return Arrays.asList(input.split("\\s+"));
    }
}
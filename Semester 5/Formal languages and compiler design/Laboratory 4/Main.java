import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) throws IOException {
        FiniteAutomata finiteAutomata = new FiniteAutomata("fa.in");

        Scanner scanner = new Scanner(System.in);
        finiteAutomata.initializeFromFile();
        int userOption;

        do {
            System.out.println("\nMenu:");
            System.out.println("1. Display set of States");
            System.out.println("2. Display Alphabet");
            System.out.println("3. Display Transitions");
            System.out.println("4. Display Initial State");
            System.out.println("5. Display set of Final States");
            System.out.println("6. Check DFA");
            System.out.println("7. Check if a sequence is accepted");
            System.out.println("0. Exit");
            System.out.print("Enter your option: ");

            userOption = scanner.nextInt();

            switch (userOption) {
                case 1 -> System.out.println("Set of States: " + finiteAutomata.getStates());
                case 2 -> System.out.println("Alphabet: " + finiteAutomata.getAlphabet());
                case 3 -> {
                    System.out.println("Transitions:");
                    for (Transition transition : finiteAutomata.getTransitions()) {
                        System.out.println("   " + transition);
                    }
                }
                case 4 -> System.out.println("Initial State: " + finiteAutomata.getInitialState());
                case 5 -> System.out.println("Set of Final States: " + finiteAutomata.getFinalStates());
                case 6 -> System.out.println("DFA acceptance result: "+finiteAutomata.checkIfDFA());
                case 7 -> displaySequenceValidation(finiteAutomata);
                case 0 -> System.out.println("Exiting...");
                default -> System.out.println("Invalid option. Please enter a valid option.");
            }
        } while (userOption != 0);
    }
    private static void displaySequenceValidation(FiniteAutomata finiteAutomata) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter a sequence to check: ");
        String sequence = scanner.nextLine();
        boolean isAccepted = finiteAutomata.isAcceptedByFA(sequence);
        System.out.println("Sequence acceptance result: " + isAccepted);
    }


}
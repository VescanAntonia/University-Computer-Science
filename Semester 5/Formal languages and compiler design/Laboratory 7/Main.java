import java.io.IOException;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        try{
            FiniteAutomata fa = new FiniteAutomata();
            fa.readFromFile("src/programs/fa.txt");

            Scanner scanner = new Scanner(System.in);

            int choice;
            do {
                System.out.println("\nMenu:");
                System.out.println("1. Display States");
                System.out.println("2. Display Alphabet");
                System.out.println("3. Display Transitions");
                System.out.println("4. Display Initial State");
                System.out.println("5. Display Final States");
                System.out.println("6. Verify if DNF");
                System.out.println("7. Verify Sequence");
                System.out.println("8. Exit");
                System.out.print("Enter your choice: ");
                choice = scanner.nextInt();

                switch (choice) {
                    case 1:
                        fa.printStates();
                        break;
                    case 2:
                        fa.printAlphabet();
                        break;
                    case 3:
                        fa.printTransitions();
                        break;
                    case 4:
                        fa.printInitialState();
                        break;
                    case 5:
                        fa.printFinalStates();
                        break;
                    case 6:
                        System.out.println(fa.checkIfDFA());
                        break;
                    case 7:
//                        System.out.print("Enter the sequence to verify: ");
//                        String sequence = System.console().readLine();
//                        System.out.println("Sequence is accepted: " + dfa.isAccepted(sequence));
                        var word = new Scanner(System.in).nextLine();
                        System.out.println(fa.isAccepted(word));
                        break;
                    case 8:
                        System.out.println("Exiting program...");
                        break;
                    default:
                        System.out.println("Invalid choice. Please enter a valid option.");
                        break;
                }
            } while (choice != 8);
        } catch (IOException e) {
            System.out.println("Error reading the file: " + e.getMessage());
        }
    }
}

//DFA
//states p, q, r
//alphabet 0, 1
//transitions p, 1, q; p, 0, p; q, 0, r; q, 1, p; r, 0, q; r, 1, r
//initial p
//finals r


//not DFA
//states a, b, c
//alphabet 0, 1
//transitions a, 0, a; b, 1, a; c, 1, c; c, 1, b
// initial a
//finals a, c
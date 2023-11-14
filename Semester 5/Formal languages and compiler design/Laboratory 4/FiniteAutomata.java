import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class FiniteAutomata {
    private final List<String> states;
    private final List<String>alphabet;
    private final List<Transition> transitions;
    private String initialState;
    private final List<String> finalStates;
    private final String filePath;

    public FiniteAutomata(String filePath) {
        this.states = new ArrayList<>();
        this.alphabet = new ArrayList<>();
        this.transitions = new ArrayList<>();
        this.initialState = "";
        this.finalStates = new ArrayList<>();
        this.filePath = filePath;
    }

    public void initializeFromFile() throws IOException {
        //initializing all the fields from the file
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.startsWith("States:")) {
                    // Split the line starting from index 8
                    String[] statesArray = line.substring(8).split(",");
                    for (String state : statesArray) {
                        states.add(state.trim());
                    }
                } else if (line.startsWith("Alphabet:")) {
                    // Split the line starting from index 10
                    String[] alphabetArray = line.substring(10).split(",");
                    for (String symbol : alphabetArray) {
                        alphabet.add(symbol.trim());
                    }
                } else if (line.startsWith("Transitions:")) {
                    // read the lines until an empty line and splits the line then takes the 3 elements of a transition
                    while (!(line = br.readLine()).isEmpty()) {
                        String[] transitionElements = line.split(" ");
                        String currentState = transitionElements[0].trim();
                        String transitionSymbol = transitionElements.length > 1 ? transitionElements[1].trim() : "";
                        String nextState = transitionElements.length > 2 ? transitionElements[2].trim() : "";

                        Transition transition = new Transition(currentState, transitionSymbol, nextState);
                        transitions.add(transition);
                    }
                } else if (line.startsWith("InitialState:")) {
                    // read the initial state from index 13
                    initialState = line.substring(13).trim();
                } else if (line.startsWith("FinalState:")) {
                    // read the final state from index 11
                    String[] finalStatesFile = line.substring(11).split(",");
                    for (String finalState : finalStatesFile) {
                        finalStates.add(finalState.trim());
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<String> getStates() {
        return states;
    }

    public List<String> getAlphabet() {
        return alphabet;
    }

    public List<Transition> getTransitions() {
        return transitions;
    }

    public String getInitialState() {
        return initialState;
    }

    public List<String> getFinalStates() {
        return finalStates;
    }

    public String getFilePath() {
        return filePath;
    }

    public boolean checkIfDFA() {
        //checks if the given set of transitions represents a DFA
        Set<String> existingTransitions = new HashSet<>();

        for (Transition transition : transitions) {
            String key = transition.getCurrentState() + "," + transition.getTransitionSymbol();

            // check if there are multiple transitions for the same current state and transition symbol
            if (existingTransitions.contains(key)) {
                return false;
            }

            existingTransitions.add(key);

            // check if the next state has more than one element
            if (transition.getNextState().contains(",")) {
                return false;  // means its a non-deterministic transition
            }
        }

        return true;
    }

    public boolean isAcceptedByFA(String givenSequence) {
        // checks if a given sequence of symbols is accepted by the FA
        String currentState = this.initialState;
        String[] sequence = givenSequence.split("");

        for (String symbol: sequence) {
            var found = false;
            //iterate through the transitions
            for (Transition transition : transitions) {
                //check if it matches the current state and the symbol
                if (transition.getCurrentState().equals(currentState) && transition.getTransitionSymbol().equals(symbol)) {
                    currentState = transition.getNextState(); //move on
                    found = true;
                    break;
                }
            }

            // if no state was found for the current transition
            if (!found) {
                return false;
            }
        }

        // check if the final state is among the accepted final states
        return this.finalStates.contains(currentState);
    }




}

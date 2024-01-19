import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;

public class FiniteAutomata {
    private List<String> states;
    private List<String> alphabet;
    private List<Transition> transitions;
    private String initialState;
    private List<String> finalStates;

    public FiniteAutomata() {
        this.states = new ArrayList<>();
        this.alphabet = new ArrayList<>();
        this.transitions = new ArrayList<>();
        this.finalStates = new ArrayList<>();
    }
    public void readFromFile(String fileName) throws IOException {
        var regex = Pattern.compile("^([a-z]*) ");
        Files.lines(Path.of(fileName))
                .forEach(line -> {
                    var matcher = regex.matcher(line);
                    if (matcher.find()) {
                        String command = matcher.group(1);
                        String content = line.substring(line.indexOf(" ") + 1).trim();

                        switch (command) {
                            case "states":
                                states = List.of(content.split(", *"));
                                break;
                            case "alphabet":
                                alphabet = List.of(content.split(", *"));
                                break;
                            case "transitions":
                                List<String> transitionList = List.of(content.split("; *"));
                                transitionList.forEach(transition -> {
                                    var values = List.of(transition.split(", *"));
                                    transitions.add(new Transition(values.get(0), values.get(1), values.get(2)));
                                });
                                break;
                            case "initial":
                                initialState = content;
                                break;
                            case "finals":
                                finalStates = List.of(content.split(", *"));
                                break;
                            default:
                                System.err.println("Unknown command: " + command);
                                break;
                        }
                    }
                });
    }

    public void printStates() {
        System.out.println("States: ");
        for(int index=0; index<states.size(); index++) {
            if(index != states.size()-1) {
                System.out.print(states.get(index) + ", ");
            }
            else {
                System.out.print(states.get(index));
            }
        }
    }
    public void printAlphabet() {
        System.out.println("Alphabet: ");
        for(int index=0; index<alphabet.size(); index++) {
            if(index != alphabet.size()-1) {
                System.out.print(alphabet.get(index) + ", ");
            }
            else {
                System.out.print(alphabet.get(index));
            }
        }
    }

    public void printFinalStates() {
        System.out.println("Final States: ");
        for(int index=0; index<finalStates.size(); index++) {
            if(index != finalStates.size()-1) {
                System.out.print(finalStates.get(index) + ", ");
            }
            else {
                System.out.print(finalStates.get(index));
            }
        }
    }

    public void printTransitions() {
        System.out.println("Transitions: ");
        for (int index = 0; index < transitions.size(); index++) {
            if (index != transitions.size()-1) {
                System.out.print("(" + transitions.get(index).getFromState() + ", " + transitions.get(index).getInputSymbol() + ", " + transitions.get(index).getToState() + ");");
            }
            else {
                System.out.print("(" + transitions.get(index).getFromState() + ", " + transitions.get(index).getInputSymbol() + ", " + transitions.get(index).getToState() + ")");
            }
        }
    }

    public void printInitialState() {
        System.out.println("Initial State: " + initialState);
    }

    public boolean isAccepted(String sequence) {
        String currentState = initialState;

        for (int i = 0; i < sequence.length(); i++) {
            String inputSymbol = String.valueOf(sequence.charAt(i));
            Transition currentTransition = findTransition(currentState, inputSymbol);

            if (currentTransition == null) {
                return false;
            }

            currentState = currentTransition.toState;
        }

        return finalStates.contains(currentState);
    }

    private Transition findTransition(String fromState, String  inputSymbol) {
        for(Transition transition : transitions) {
            if(transition.fromState.equals(fromState) && Objects.equals(transition.inputSymbol, inputSymbol)) {
                return transition;
            }
        }
        return null;
    }

    public boolean checkIfDFA() {
        for(String state : states) {
            for(String symbol : alphabet) {
                if(!hasUniqueTransition(state, symbol)) {
                    return false;
                }
            }
        }
        return true;
    }

    private boolean hasUniqueTransition(String fromState, String inputSymbol) {
        long count = transitions.stream()
                .filter(transition -> transition.getFromState().equals(fromState) && transition.getInputSymbol().equals(inputSymbol))
                .count();
        return count <= 1;
    }

    public String getNextSequence(String sequence) {
        var currentState = initialState;
        StringBuilder stringBuilder = new StringBuilder();

        for (String inputSymbol : sequence.split("")) {
            String finalCurrentState = currentState;
            Transition matchingTransition = transitions.stream()
                    .filter(t -> t.getFromState().equals(finalCurrentState) && t.getInputSymbol().equals(inputSymbol))
                    .findFirst()
                    .orElse(null);

            if (matchingTransition == null) {
                if (!finalStates.contains(currentState)) {
                    return null;
                } else {
                    return stringBuilder.toString();
                }
            }

            stringBuilder.append(inputSymbol);
            currentState = matchingTransition.getToState();
        }

        return stringBuilder.toString();
    }
}
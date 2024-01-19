public class Transition {
    String fromState;
    String toState;
    String inputSymbol;

    public Transition(String fromState, String inputSymbol, String toState) {
        this.fromState = fromState;
        this.inputSymbol = inputSymbol;
        this.toState = toState;
    }

    public String getFromState() {
        return fromState;
    }

    public String getToState() {
        return toState;
    }

    public String getInputSymbol() {
        return inputSymbol;
    }

    @Override
    public String toString() {
        return "Transition: from state: " + fromState + ", input symbol: " + inputSymbol + ", to state: " + toState;
    }
}
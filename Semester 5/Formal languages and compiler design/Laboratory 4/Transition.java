public class Transition {
    private String currentState;
    private String transitionSymbol;
    private String nextState;

    public Transition(String currentState, String transitionSymbol, String nextState) {
        this.currentState = currentState;
        this.transitionSymbol = transitionSymbol;
        this.nextState = nextState;
    }

    public String getCurrentState() {
        return currentState;
    }

    public String getTransitionSymbol() {
        return transitionSymbol;
    }

    public String getNextState() {
        return nextState;
    }

    @Override
    public String toString() {
        return "(" + currentState + ", " + transitionSymbol + ") -> " + nextState;
    }
}

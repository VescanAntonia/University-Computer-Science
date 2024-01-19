import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class Grammar {
    private List<String> nonTerminals;
    private List<String> terminals;
    private List<Production> productions;
    private String startSymbol;
    private String filename;

    public Grammar(String filename) {
        this.nonTerminals=new ArrayList<>();
        this.terminals=new ArrayList<>();
        this.productions=new ArrayList<>();
        this.startSymbol=null;
        this.filename = filename;
    }

    public void initializeFromFile() throws IOException{
        try (BufferedReader reader = new BufferedReader(new FileReader(this.filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty() && !line.startsWith("#")) {
                    if (line.startsWith("NonTerminals:")) {
                        String nonterminalsLine = line.split(":")[1].trim();
                        String[] nonterminalsArray = nonterminalsLine.split(", ");
                        nonTerminals.addAll(Arrays.asList(nonterminalsArray));
                    } else if (line.startsWith("Terminals:")) {
                        String terminalsLine = line.split(":")[1].trim();
                        String[] terminalsArray = terminalsLine.split(", ");
                        terminals.addAll(Arrays.asList(terminalsArray));
                    } else if (line.startsWith("Productions:")) {
                        while ((line = reader.readLine()) != null && !line.trim().isEmpty()) {
                            String[] parts = line.split("->");
                            if (parts.length == 2) {
                                String leftSide = parts[0].trim();
                                String[] rightSideSymbols = parts[1].trim().split("\\s+");
                                List<String> rightSide = Arrays.asList(rightSideSymbols);
                                productions.add(new Production(leftSide, rightSide));
                            } else {
                                throw new IllegalArgumentException("Invalid production: " + line);
                            }
                        }
                    } else if (line.startsWith("Starting symbol:")) {
                        startSymbol = line.split(":")[1].trim();
                    }
                }
            }
        }
    }

    public void printNonTerminals(){
        System.out.println("Non-terminals: " + nonTerminals);
    }

    public void printTerminals(){
        System.out.println("Terminals: " + terminals);
    }

    public void printProductions() {
        System.out.println("Productions:");
        for (Production production : productions) {
            System.out.print(production.getKey() + " -> ");
            List<String> productionValues = production.getValue();
            for (String productionValue : productionValues) {
                System.out.print(productionValue);
//                if (i < productionValues.size() - 1) {
//                    System.out.print(" | ");
//                }
            }
            System.out.println();
        }
    }

    public void printProductionsForNonterminal(String nonterminal) {
        productions.stream()
                .filter(production -> production.getKey().equals(nonterminal))
                .forEach(production -> {
                    List<String> productionValues = production.getValue();
                    System.out.print(nonterminal + " -> ");
                    System.out.println(String.join("", productionValues));
                });
    }

    public boolean checkIfCFG() {
        for(Production production : productions) {
            String lhs = production.getKey();
            List<String> rhs = production.getValue();

            if(!nonTerminals.contains(lhs) || nonTerminals.indexOf(lhs) == -1) {
                System.out.println("Error: the left hand side is not a single nonterminal");
                return false;
            }
            //System.out.println(rhs);
            for (String symbol : rhs) {
                String[] symbols = symbol.split("");
                for(String s : symbols) {
                    if (!(terminals.contains(s) || nonTerminals.contains(s) || s.equals("|") || s.equals("ε"))) {
                        System.out.println("Error: the right hand side symbols that ar not terminals or nonterminals: " + " " + s);
                        return false;
                    }
                }

            }

        }
        return true;
    }

    public List<String> getNonTerminals() {
        return nonTerminals;
    }

    public List<String> getTerminals() {
        return terminals;
    }

    public List<Production> getProductions() {
        return productions;
    }

    public String getStartSymbol() {
        return startSymbol;
    }

    public List<Production> getProductionsForNonterminal(String nonTerminal) {
        List<Production> productionList = new LinkedList<>();
        for(Production production : productions) {
            if(production.getKey().equals(nonTerminal)) {
                productionList.add(production);
            }
        }
        return productionList;
    }

}
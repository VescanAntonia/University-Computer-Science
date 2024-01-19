import java.util.*;

//import java.util.*;

public class Parser {
    private Grammar grammar;
    //private Map<Pair<String, String>, List<String>> parsingTable;
    private Table parsingTable = new Table();
    private Map<Pair<String, List<String>>, Integer> countedProductions = new HashMap<>();

    private Stack<String> inputStack = new Stack<>();
    private Stack<String> workingStack = new Stack<>();
    public Stack<String> outputStack = new Stack<>();
    private ListIterator<String> workingStackIterator;
    private ListIterator<String> inputStackIterator;

    public Parser(Grammar grammar){
        this.grammar = grammar;

//        this.parsingTable = new HashMap<>();
//        buildParsingTable();
    }

    public Set<String> first(String symbol, Set<String> visited) {
        Set<String> firstSet = new HashSet<>();

        if (visited.contains(symbol)) {
            return firstSet;
        }

        visited.add(symbol);

        if (grammar.getTerminals().contains(symbol) || symbol.equals("ε")) {
            firstSet.add(symbol);
        } else {
            for (Production production : grammar.getProductions()) {
                if (production.getKey().equals(symbol)) {
                    List<String> productionValues = production.getValue();

                    boolean addedToFirst = false;

                    for (String productionValue : productionValues) {
                        if (productionValue.equals("|")) {
                            addedToFirst = false; // Reset the flag when encountering '|'
                            continue;
                        }

                        if (!addedToFirst) {
                            if (!productionValue.isEmpty()) {
                                Set<String> firstOfProductionValue = first(productionValue, visited);
                                firstSet.addAll(firstOfProductionValue);

                                if (!firstOfProductionValue.contains("ε")) {
                                    addedToFirst = true; // Set the flag if the FIRST set is added
                                }
                            }
                        }

                    }
                }
            }
        }

        visited.remove(symbol);

        return firstSet;
    }

    public Set<String> follow(String nonterminal) {
        Set<String> followSet = new HashSet<>();

        if (nonterminal.equals(grammar.getStartSymbol())) {
            followSet.add("$");
        }

        for (Production production : grammar.getProductions()) {
            List<String> productionValues = production.getValue();

            for (int i = 0; i < productionValues.size(); i++) {
                String currentSymbol = productionValues.get(i);

                if (currentSymbol.equals(nonterminal)) {
                    if (i < productionValues.size() - 1) {
                        String nextSymbol = productionValues.get(i + 1);
                        followSet.addAll(first(nextSymbol, new HashSet<>()));

                        if (followSet.contains("ε")) {
                            followSet.remove("ε");
                            followSet.addAll(follow(production.getKey()));
                        }
                    } else if (!nonterminal.equals(production.getKey())) {
                        followSet.addAll(follow(production.getKey()));
                    }
                }
            }
        }
        return followSet;
    }

    private void countProduction() {
        int index = 1;
        List<Production> productions = grammar.getProductions();
        for(Production production : productions) {
            String startSymbol = production.getKey();
            List<String> rule = production.getValue();

            countedProductions.put(new Pair<>(startSymbol, rule), index++);
        }
    }

    public void buildParsingTable() {
        countProduction();
        List<String> columns = new LinkedList<>(grammar.getTerminals());
        columns.add("$");
        initializeParsingTable(columns);

        countedProductions.forEach((key, value) -> {
            String row = key.getKey();
            List<String> rhs = key.getValue();
            Pair<List<String>, Integer> parsingTableValue = new Pair<>(rhs, value);

            updateParsingTable(row, rhs, columns, parsingTableValue);

        });
    }

    private void initializeParsingTable(List<String> columns) {
        parsingTable.put(new Pair<>("$", "$"), new Pair<>(Collections.singletonList("acc"), -1));
        for(String terminal : grammar.getTerminals()) {
            parsingTable.put(new Pair<>(terminal, terminal), new Pair<>(Collections.singletonList("pop"), -1));
        }
    }

    private void updateParsingTable(String row, List<String> rhs, List<String> cols, Pair<List<String>, Integer> parsingTableValue) {
        for(String column : cols) {
            Pair<String, String> parsingTableKey = new Pair<>(row, column);

            if(rhs.get(0).equals(column) && !column.equals("ε")) {
                parsingTable.put(parsingTableKey, parsingTableValue);
            }
            else if(grammar.getNonTerminals().contains(rhs.get(0)) && first(rhs.get(0), new HashSet<>()).contains(column)) {
                updateParsingTableIfKeyExists(parsingTableKey, parsingTableValue);
            }
            else {
                if(rhs.get(0).equals("ε")) {
                    for(String followSymbol : follow(row)) {
                        parsingTable.put(new Pair<>(row, followSymbol), parsingTableValue);
                    }
                }
                else {
                    Set<String> firstSets = computeFirstSet(rhs);
                    if(firstSets.contains("ε")) {
                        for(String firstSymbol : first(row, new HashSet<>())) {
                            if(firstSymbol.equals("ε")) {
                                firstSymbol = "$";
                            }
                            parsingTableKey = new Pair<>(row, firstSymbol);
                            updateParsingTableIfKeyExists(parsingTableKey, parsingTableValue);
                        }
                    }
                }
            }
        }
    }

    private void updateParsingTableIfKeyExists(Pair<String, String> parsingTableKey, Pair<List<String>, Integer> parsingTableValue) {
        if(parsingTable.containsKey(parsingTableKey)) {
            parsingTable.put(parsingTableKey, parsingTableValue);
        }
    }

    private Set<String> computeFirstSet(List<String> symbols) {
        Set<String> firstSets = new HashSet<>();
        for(String symbol : symbols) {
            if(grammar.getNonTerminals().contains(symbol)) {
                firstSets.addAll(first(symbol, new HashSet<>()));
            }
        }
        return firstSets;
    }

    public Table getParsingTable() {
        return parsingTable;
    }

    private void initStacks(List<String> sequence) {
        inputStack.clear();
        inputStack.push("$");
        pushChars(sequence, inputStack);

        workingStack.clear();
        workingStack.push("$");
        workingStack.push(grammar.getStartSymbol());

        outputStack.clear();
        outputStack.push("ε");
    }

    private void pushChars(List<String> sequence, Stack<String> stack) {
        List<String> reversedList = new ArrayList<>(sequence);
        Collections.reverse(reversedList);
        stack.addAll(reversedList);
    }

    public boolean parse(List<String> sequence) {
        initStacks(sequence);
        //System.out.println(inputStack);
        while (true) {
            String workingStackHead = workingStack.peek();
            String inputStackHead = inputStack.peek();

            if (workingStackHead.equals("$") && inputStackHead.equals("$")) {
                return true;
            }

            Pair<String, String> heads = new Pair<>(workingStackHead, inputStackHead);
            //System.out.println(heads);
            Pair<List<String>, Integer> parsingTableEntry = parsingTable.get(heads);
            //System.out.println("Parsing table entry: " + parseTableEntry);

//            if (parsingTableEntry == null) {
//                heads = new Pair<>(workingStackHead, "ε");
//                parsingTableEntry = parsingTable.get(heads);
//                if (parsingTableEntry != null) {
//                    workingStack.pop();
//                    //workingStackIterator.remove();
//                    continue;
//                }
//            }

            if (parsingTableEntry == null) {
                printConflictMessage(workingStackHead, inputStackHead);
                return false;
            } else {
                handleParsingTableEntry(parsingTableEntry);
            }
            //System.out.println(outputStack);
        }

    }

    private void printConflictMessage(String workingStackHead, String inputStackHead) {
        System.out.println("There is no entry in the parsing table for row '" + workingStackHead +
                "' and column '" + inputStackHead + "'");
    }

    private void handleParsingTableEntry(Pair<List<String>, Integer> parsingTableEntry) {
        List<String> production = parsingTableEntry.getKey(); //extract all the productions
        Integer position = parsingTableEntry.getValue();

//        if (productionPos == -1 && production.get(0).equals("acc")) {
//            boolean isParsingComplete = false;
//        } else
        if (position == -1 && production.get(0).equals("pop")) {
            workingStack.pop();
            inputStack.pop();
        } else {
//            System.out.println("Hi");
            workingStack.pop();
            if (!production.get(0).equals("ε")) {
                pushChars(production, workingStack);
//                System.out.println(workingStack);
            }
            outputStack.push(position.toString());
        }
    }

    public void parsePIF(String filename) {
        List<MyScanner.ScannedItem> PIF = scanSourceCode(filename);
        if(PIF != null) {
            System.out.println(parseSource(PIF));
        }
    }

    public List<MyScanner.ScannedItem> scanSourceCode(String filename) {
        MyScanner scanner = new MyScanner();
        scanner.scan(filename);

        List<MyScanner.ScannedItem> PIF = scanner.getPIF();

        if(PIF != null && PIF.isEmpty()) {
            scanner.displayPIF(PIF);
            List<String> inputSequence = new ArrayList<>();
            PIF.forEach(elem -> inputSequence.add(elem.getToken()));

            System.out.println(inputSequence);
            this.parse(inputSequence);

            return PIF;
        }
        return null;
    }

    public boolean parseSource(List<MyScanner.ScannedItem> PIF) {
        List<String> inputSequence = new LinkedList<>();
        for(MyScanner.ScannedItem entry : PIF) {
            inputSequence.add(String.valueOf(entry.getPosition()));
        }
        return this.parse(inputSequence);
    }
}

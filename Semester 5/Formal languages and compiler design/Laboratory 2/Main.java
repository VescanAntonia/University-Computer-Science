public class Main {
    public static void main(String[] args) {
        SymbolTable<String> hashTable1= new SymbolTable<>();
        SymbolTable<Integer> hashTable2=new SymbolTable<>();
        hashTable1.add("abc");
        System.out.println("The identifiers table after adding 'abc' "+hashTable1);
        System.out.println("Trying to add 'abc' again we get false because its already added: "+hashTable1.add("abc"));
        hashTable1.add("b");
        System.out.println("The identifiers table after adding 'b': "+hashTable1.toString());
        hashTable1.add("c");
        System.out.println("The identifiers table after adding 'c': "+hashTable1.toString());

        hashTable1.add("bc");
        System.out.println("The identifiers table after adding 'bc': "+hashTable1.toString());

        System.out.println("The position of 'b': "+hashTable1.lookUp("b"));


        hashTable2.add(1);
        System.out.println("The constants table after adding 1: "+hashTable2);

        hashTable2.add(18);
        System.out.println("The constants table after adding 18: "+hashTable2);


    }
}
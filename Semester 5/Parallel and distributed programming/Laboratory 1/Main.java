import java.io.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

public class Main {
    private static final int NUMBER__OF_THREADS = 5;
    private static Inventory deposit = new Inventory();
    private static List<Product> products = new ArrayList<>();
    private static List<Bill> recordOfSales = new ArrayList<>();
    private static List<Transaction> transactions = new ArrayList<>();

    public static void main(String[] args) {
        WriteInFile();  //writing
        ReadFromFile();  //reading

        // The main method simulates transactions by creating multiple threads and starting them.
        // These threads represent transactions.

        float start =  System.nanoTime() / 1000000;
        for (int i = 0; i < NUMBER__OF_THREADS; i++) {      //for each thread creating a transaction t0, t1..
            Transaction t = new Transaction(deposit, "t" + i);
            int product = new Random().nextInt(10); // Randomly determine the number of products in the transaction
            //Generates a random number product between 0 and 9
//            if (product < 0 ) product *= -1;
            for (int j = 0; j < product; j++) {
                //For each product, it generates a random quantity and selects a random product from the
                // products list to add to the transaction
                int quantity = new Random().nextInt(10); // Randomly determine the quantity of each product
//                if (quantity < 0 ) quantity *= -1;
                int productId = new Random().nextInt(products.size()); // Randomly select a product from the list
//                if (productId < 0 ) productId *= -1;
                t.add(products.get(productId), quantity);  // add the randomly generated product to the products list
            }
            transactions.add(t);
        }


        List<Thread> threads = new ArrayList<>();

        //converts each transaction into a thread and adds these threads to the threads list
        transactions.stream().forEach(t -> threads.add(new Thread(t)));

        for (Thread thread : threads){   //start each thread running concurrently
            thread.start();
        }

        for (Thread thread : threads){
            try {
                thread.join();  //waits for each thread to complete to ensure that all transactions are finished before moving on
            } catch (InterruptedException e) {
                System.out.println(e.getMessage());
            }
        }

        verify();  //verify the stock

        float end = System.nanoTime() / 1000000;
        System.out.println("\n End work: " + (end - start) / 1000 + " seconds");



    }

    static void verify() {
        // verify the stock after all the threads are completed
        //It calculates the expected sum of prices from the recorded sales and compares it
        // to the sum of prices from transactions.
        System.err.println("Verifying the stock...");

        int expectedSum = 0;
        double sum = recordOfSales.stream().mapToDouble(i -> i.getProducts().stream().mapToDouble(j -> j.getPrice()).sum()).sum();
        if(transactions.stream().mapToDouble(i ->{
            if (i == null)
                return 0.0f;
            else
                return i.getTotalPrice();
        }).sum() == sum) {
            System.err.println("Stock verification failed!");
        }
        else {
            System.err.println("Verification Successful!");
        }
    }

    private static void WriteInFile() {
        // generate random product data and writes it to a file
        int i = 0;
        try {
            BufferedWriter writer = new BufferedWriter(new FileWriter("D:\\Faculty\\Parallel programming\\Lab1\\Laboratory1\\src\\products.txt"));
            while ( i < 1000 ) {
                Random r = new Random();
                Integer quantity = r.nextInt();
                if (quantity < 0)
                    quantity =  (quantity * -1) % 100;
                else
                    quantity %= 100;
                String s = new RandomStringGenerator().generateRandomString() +  ' ' + r.nextDouble() + ' ' +  quantity + '\n';
                writer.write(s);
                i += 1;
            }
            writer.close();
        } catch (IOException e) {
            System.out.println(e.getMessage());
        }
    }

    private static void ReadFromFile() {
        //reads from the file and populates the products list and deposit
        File file = new File("D:\\Faculty\\Parallel programming\\Lab1\\Laboratory1\\src\\products.txt");
        try {
            Scanner sc = new Scanner(file);
            while(sc.hasNext()){
                Product p = new Product(sc.next(), sc.nextFloat());
                products.add(p);
                deposit.add(p, sc.nextInt());
            }
        } catch (FileNotFoundException e) {
            System.out.println(e.getMessage());
        }
    }
}

class RandomStringGenerator {
    private static final String CHAR_LIST =
            "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    private static final int RANDOM_STRING_LENGTH = 10;

    String generateRandomString(){
        StringBuilder randStr = new StringBuilder();
        for(int i=0; i<RANDOM_STRING_LENGTH; i++){
            int number = getRandomNumber();
            char ch = CHAR_LIST.charAt(number);
            randStr.append(ch);
        }
        return randStr.toString();
    }
    private int getRandomNumber() {
        int randomInt = 0;
        Random randomGenerator = new Random();
        randomInt = randomGenerator.nextInt(CHAR_LIST.length());
        if (randomInt - 1 == -1) {
            return randomInt;
        } else {
            return randomInt - 1;
        }
    }
}
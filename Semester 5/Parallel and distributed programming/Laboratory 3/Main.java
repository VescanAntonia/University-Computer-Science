import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class Main {
    public static Integer a, b, c; //matrix dimensions
    public static Integer givenApproach; //0 for task, 1 for pool
    public static Integer taskNumber;
    public static Matrix m1;
    public static Matrix m2;

    public static void getParams() {
        Scanner scanner = new Scanner(System.in);
        System.out.print("a: ");
        a = scanner.nextInt();
        System.out.print("b: ");
        b = scanner.nextInt();
        System.out.print("c: ");
        c = scanner.nextInt();
        System.out.print("Choose 0 for individual threads and 1 for thread pool: ");
        givenApproach = scanner.nextInt();
        System.out.print("Number of tasks: ");
        taskNumber = scanner.nextInt();
        genMatrix();
    }

    public static void genMatrix() {
        m1 = new Matrix(a, b);
        m2 = new Matrix(b, c);
    }

    public static Matrix productByTasks() throws InterruptedException {
        Integer[][] res = new Integer[a][c];
        List<Thread> threads = new ArrayList<>(); //list of threads
        for (int i = 0; i < taskNumber; ++i) {
            threads.add(new Thread(new KthThread(res, i, taskNumber)));
        }
        for (Thread thread : threads)
            thread.start();
        for (Thread thread : threads)
            thread.join();
        return new Matrix(res);
    }

    public static Matrix productByThreadPool() throws InterruptedException {
        ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(taskNumber);//init thread pool
        Integer[][] res = new Integer[a][c];
        List<Runnable> tasks = new ArrayList<>(); //create list of runnable tasks
        for (int i = 0; i < taskNumber; ++i) {
            tasks.add(new Thread(new KthThread(res, i, taskNumber)));
        }
        //the thread pool executes each task
        for (Runnable task : tasks)
            executor.execute(task);
        executor.shutdown();  //wait for all too complete
        while (!executor.awaitTermination(1, TimeUnit.DAYS)){
            System.out.println("How on earth");
        }
        return new Matrix(res);
    }

    public static void main(String[] args) throws InterruptedException {
        getParams();
        Matrix trueProduct = Matrix.multiplyMatrices(m1, m2);
        Matrix computedProduct = null;
        if (givenApproach == 0)
            computedProduct = productByTasks();
        else computedProduct = productByThreadPool();
        System.out.println("M1:");
        m1.print();
        System.out.println("M2:");
        m2.print();
        System.out.println("The true product:");
        trueProduct.print();
        System.out.println("The actual obtained product:");
        computedProduct.print();
        if (trueProduct.equals(computedProduct))
            System.out.println("The products are OK.");
        else System.out.println("The products are NOT OK!!");

    }
}
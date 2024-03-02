import java.util.concurrent.ExecutionException;

public class Main {
    public static void main(String[] args) throws InterruptedException, ExecutionException {

        Polynomial p = new Polynomial(10);
        Polynomial q = new Polynomial(10);

        System.out.println("pol p:" + p);
        System.out.println("pol q" + q);
        System.out.println("\n");


        //Simple
        System.out.println(multiplicationSeq(p, q).toString() + "\n");
        System.out.println(multiplicationParalel(p, q).toString() + "\n");

        //Karatsuba
        System.out.println(karatsubaSeq(p, q).toString() + "\n");
        System.out.println(karatsubaParalel(p, q).toString() + "\n");
    }

    private static Polynomial karatsubaParalel(Polynomial p, Polynomial q) throws ExecutionException,
            InterruptedException {
        long startTime = System.currentTimeMillis();
        Polynomial result4 = PolynomialOperation.multiplicationKaratsubaParallelizedForm(p, q, 4);
        long endTime = System.currentTimeMillis();
        System.out.println("Karatsuba parallel multiplication of polynomials: ");
        System.out.println("Execution time : " + (endTime - startTime) + " ms");
        return result4;
    }

    private static Polynomial karatsubaSeq(Polynomial p, Polynomial q) {
        long startTime = System.currentTimeMillis();
        Polynomial result3 = PolynomialOperation.multiplicationKaratsubaSequentialForm(p, q);
        long endTime = System.currentTimeMillis();
        System.out.println("Karatsuba sequential multiplication of polynomials: ");
        System.out.println("Execution time : " + (endTime - startTime) + " ms");
        return result3;
    }

    private static Polynomial multiplicationParalel(Polynomial p, Polynomial q) throws InterruptedException {
        long startTime = System.currentTimeMillis();
        Polynomial result2 = PolynomialOperation.multiplicationParallelizedForm(p, q, 5);
        long endTime = System.currentTimeMillis();
        System.out.println("Simple parallel multiplication of polynomials: ");
        System.out.println("Execution time : " + (endTime - startTime) + " ms");
        return result2;
    }

    private static Polynomial multiplicationSeq(Polynomial p, Polynomial q) {
        long startTime = System.currentTimeMillis();
        Polynomial result1 = PolynomialOperation.multiplicationSequentialForm(p, q);
        long endTime = System.currentTimeMillis();
        System.out.println("Simple sequential multiplication of polynomials: ");
        System.out.println("Execution time : " + (endTime - startTime) + " ms");
        return result1;
    }
}
import mpi.MPI;

import java.util.concurrent.ExecutionException;


public class Main {
    private static Polynomial ComputeFinalResult(Polynomial[] results) {
        Polynomial result = new Polynomial(results[0].coefficients.length * 2 - 1);

        // Multiply two polynomials term by term
        for (int i = 0; i < results[0].coefficients.length; i++) {
            // Multiply the current term of first polynomial
            // with every term of second polynomial.
            for (int j = 0; j < results[1].coefficients.length; j++) {
                result.coefficients[i + j] += results[0].coefficients[i] * results[1].coefficients[j];
            }
        }

        return result;
    }

    private static void MPIMultiplicationMaster(Object polynomial1, Object polynomial2, int size) {
        //distribute polynomial multiplication tasks among MPI processes
        long startTimeMultiplication = System.currentTimeMillis();

        int n = MPI.COMM_WORLD.Size();
        int begin = 0;
        int end = 0;
        int length = size / n;

        // Distribute tasks among MPI processes
        for (int i = 0; i < n; i++) {
            if (i != 0) {
                begin = end;
                end = end + length;
                if (i == n - 1)
                    end = size;

                int[] beginArray = new int[1];
                int[] endArray = new int[1];
                beginArray[0] = begin;
                endArray[0] = end;

                Object[] poly1 = new Object[1];
                Object[] poly2 = new Object[1];
                poly1[0] = polynomial1;
                poly2[0] = polynomial2;

                //send data to each worker process
                MPI.COMM_WORLD.Issend(poly1, 0, 1, MPI.OBJECT, i, 0);
                MPI.COMM_WORLD.Issend(poly2, 0, 1, MPI.OBJECT, i, 0);
                MPI.COMM_WORLD.Issend(beginArray, 0, 1, MPI.INT, i, 0);
                MPI.COMM_WORLD.Issend(endArray, 0, 1, MPI.INT, i, 0);
            }
        }

        if (n == 1) {
            Object[] poly1 = new Object[1];
            Object[] poly2 = new Object[1];
            poly1[0] = polynomial1;
            poly2[0] = polynomial2;

            MPI.COMM_WORLD.Issend(poly1, 0, 1, MPI.OBJECT, 0, 0);
            MPI.COMM_WORLD.Issend(poly2, 0, 1, MPI.OBJECT, 0, 0);
        }

        Object[] results = new Object[n + 1];
        Polynomial[] polynomials = new Polynomial[n + 1];

        if (MPI.COMM_WORLD.Size() == 1) {
            //if there is only one MPI process, get the res and compute result
            for (int i = 0; i < n; i++) {
                MPI.COMM_WORLD.Recv(results, 0, 1, MPI.OBJECT, i, 0);
                polynomials[i] = (Polynomial) results[i];
                MPI.COMM_WORLD.Recv(results, 0, 1, MPI.OBJECT, i, 0);
                polynomials[i + 1] = (Polynomial) results[i];
            }

            Polynomial result = ComputeFinalResult(polynomials);
            long endTimeMultiplication = System.currentTimeMillis();
            System.out.println("MPI Multiplication: " + result + ". TIME: " + (endTimeMultiplication - startTimeMultiplication));
        } else {
            //if multiple aggregate results
            int[] finalResult = new int[PolynomialOperations.result.length];
            for (int i = 0; i < n; i++) {
                if (i != 0) {
                    Object[] resultsWorker = new Object[n + 1];
                    Polynomial[] polynomialsWorker = new Polynomial[n + 1];

                    MPI.COMM_WORLD.Recv(resultsWorker, 0, 1, MPI.OBJECT, i, 0);
                    polynomialsWorker[i] = (Polynomial) resultsWorker[0];

                    for (int j = 0; j < PolynomialOperations.result.length; j ++) {
                        int[] childResult = polynomialsWorker[i].getCoefficients();
                        finalResult[j] += childResult[j];
                    }
                }
            }
            Polynomial result = new Polynomial(finalResult);
            long endTimeMultiplication = System.currentTimeMillis();
            System.out.println("MPI Multiplication: " + result.toString() + ". TIME: " + (endTimeMultiplication - startTimeMultiplication));
        }
    }

    private static void MPIMultiplicationWorker() throws InterruptedException {
        //perform polynomial multiplication assigned to a specific MPI process
        int n = MPI.COMM_WORLD.Size();
        Object[] results = new Object[n + 1];
        Polynomial[] polynomials = new Polynomial[n + 1];

        //receive the date from the master
        MPI.COMM_WORLD.Recv(results, 0, 1, MPI.OBJECT, 0, 0);
        polynomials[0] = (Polynomial) results[0];
        MPI.COMM_WORLD.Recv(results, 0, 1, MPI.OBJECT, 0, 0);
        polynomials[1] = (Polynomial) results[0];

        int[] beginArray = new int[1];
        MPI.COMM_WORLD.Recv(beginArray, 0, 1, MPI.INT, 0, 0);
        int begin = beginArray[0];

        int[] endArray = new int[1];
        MPI.COMM_WORLD.Recv(endArray, 0, 1, MPI.INT, 0, 0);
        int end = endArray[0];

        //perform the multiplication for the range
        PolynomialOperations.MPIMultiply(polynomials[0], polynomials[1], begin, end);
        Polynomial polynomial = new Polynomial(PolynomialOperations.result);

        Object[] resultObj = new Object[1];
        resultObj[0] = polynomial;

        //send result to master
        MPI.COMM_WORLD.Issend(resultObj, 0, 1, MPI.OBJECT, 0, 0);
    }

    private static void MPIKaratsubaMaster(Polynomial polynomial1, Polynomial polynomial2, int size) throws ExecutionException, InterruptedException {
        long startTimeKaratsuba = System.currentTimeMillis();

        Polynomial result = new Polynomial(polynomial1.degree * 2 + 1);

        //check if there is only one MPI process and do the karatsuba multiplication directly
        if (MPI.COMM_WORLD.Size() == 1) {
            result = PolynomialOperations.AsynchronousKaratsubaMultiply(polynomial1, polynomial2);
        }
        else {
            // distribute polynomial multiplication tasks among MPI processes
            for (int i = 0; i < MPI.COMM_WORLD.Size(); i++) {
                if (i != 0) {
                    Object[] poly1 = new Object[1];
                    Object[] poly2 = new Object[1];
                    poly1[0] = polynomial1;
                    poly2[0] = polynomial2;

                    //send data to wach worker
                    MPI.COMM_WORLD.Issend(poly1, 0, 1, MPI.OBJECT, i, 0);
                    MPI.COMM_WORLD.Issend(poly2, 0, 1, MPI.OBJECT, i, 0);
                }
            }

            int n = MPI.COMM_WORLD.Size();
            int[] finalResult = new int[PolynomialOperations.result.length];
            //get data from the worker
            for (int i = 0; i < n; i++) {
                if (i != 0) {
                    Object[] resultsWorker = new Object[n + 1];
                    Polynomial[] polynomialsWorker = new Polynomial[n + 1];

                    MPI.COMM_WORLD.Recv(resultsWorker, 0, 1, MPI.OBJECT, i, 0);
                    polynomialsWorker[i] = (Polynomial) resultsWorker[0];

                    finalResult = polynomialsWorker[i].getCoefficients();
                    break;
                }
            }
            result = new Polynomial(finalResult);
        }

        long endTimeKaratsuba = System.currentTimeMillis();
        System.out.println("MPI Karatsuba: " + result.toString() + ". TIME: " + (endTimeKaratsuba - startTimeKaratsuba));
    }

    public static void MPIKaratsubaWorker() throws ExecutionException, InterruptedException {
        //call the multiplication method
        PolynomialOperations.MPIKaratsubaMultiply();
    }

    public static void main(String[] args) throws Exception {
        //initiate an MPI env and coordinate the multiplication tasks
        MPI.Init(args);

        int rank = MPI.COMM_WORLD.Rank();
        int numProc = MPI.COMM_WORLD.Size();

        System.out.println("Program start with rank: " + rank + " and size: " + numProc);
        int polynomialsLength = 3;
        PolynomialOperations.result = new int[(polynomialsLength + 1) * 2];

        Polynomial polynomial1 = new Polynomial(polynomialsLength);
        polynomial1.generateRandomPolynomial();
        Polynomial polynomial2 = new Polynomial(polynomialsLength);
        polynomial2.generateRandomPolynomial();

        int size = polynomial1.size;

        //master process
        if (MPI.COMM_WORLD.Rank() == 0) {
            // Master process
            System.out.println("Poly 1: " + polynomial1.toString());
            System.out.println("Poly 2: " + polynomial2.toString());

            MPIMultiplicationMaster(polynomial1, polynomial2, size);
            MPIKaratsubaMaster(polynomial1, polynomial2, size);
        } else {
            // Child process
            MPIMultiplicationWorker();
            MPIKaratsubaWorker();
        }

        MPI.Finalize();
    }
}
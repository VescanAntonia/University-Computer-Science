package com.example;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class PeerToPeerChat {

    private static final int PORT = 8080; //the port the server listens to

    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            System.out.println("Server is running and listening on port " + PORT);

            Socket clientSocket = serverSocket.accept();
            System.out.println("Connection established with " + clientSocket.getInetAddress());

            // for reading and writing to the client
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                 PrintWriter writer = new PrintWriter(clientSocket.getOutputStream(), true)) {

                // Start message sender thread to handle sending messages
                Thread messageSenderThread = new Thread(new MessageSender(writer));
                messageSenderThread.start();

                // Simulate chat
                while (true) {
                    String message = reader.readLine();
                    if (message != null) {
                        System.out.println("Received message: " + message);
                        if ("!bye".equals(message)) {
                            //close connection and exit
                            System.out.println("Client disconnected. Closing the server.");
                            serverSocket.close();
//                            messageSenderThread.interrupt();
                            System.exit(0);
                            break;
                        }
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    static class MessageSender implements Runnable {

        private PrintWriter writer; //to send messages to the client

        public MessageSender(PrintWriter writer) {
            this.writer = writer;
        }

        @Override
        public void run() {
            try {
                BufferedReader consoleReader = new BufferedReader(new InputStreamReader(System.in));
                while (true) {
                    String message = consoleReader.readLine();
                    if ("!bye".equals(message)) {
                        // exit program and send message to client
                        System.out.println("Closing the server.");
                        writer.println(message);
//                        Thread.currentThread().interrupt();
                        System.exit(0);
                        break;
                    } else {
                        //otherwise send message to the client
                        writer.println(message);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

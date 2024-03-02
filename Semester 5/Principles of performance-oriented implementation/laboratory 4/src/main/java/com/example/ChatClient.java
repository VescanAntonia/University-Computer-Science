package com.example;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ChatClient {

    private static final String SERVER_HOST = "localhost";
    private static final int SERVER_PORT = 8080;

    public static void main(String[] args) {
        //create socket and connect it to the server
        try (Socket socket = new Socket(SERVER_HOST, SERVER_PORT);
             //to read from /write to the server
             BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             PrintWriter writer = new PrintWriter(socket.getOutputStream(), true)) {

            System.out.println("Connected to the server.");

            // Start message sender thread to handle sending messages
            Thread messageSenderThread = new Thread(new MessageSender(writer));
            messageSenderThread.start();

            // Simulate chat
            while (true) {
                String message = reader.readLine();
                if (message != null) {
                    System.out.println("Received message: " + message);
                    if ("!bye".equals(message)) {
                        //close socket, exit program
                        System.out.println("Received !bye command. Closing the client.");
//                        messageSenderThread.interrupt();  // Stop the MessageSender thread
                        socket.close();
                        System.exit(0);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    static class MessageSender implements Runnable {

        private PrintWriter writer; //to send messages to the server

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
                        writer.println(message);
                        System.exit(0);
                        break;
                    } else {
                        //send to the server
                        writer.println(message);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

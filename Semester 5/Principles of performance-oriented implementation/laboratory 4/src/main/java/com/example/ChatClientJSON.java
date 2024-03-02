package com.example;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;

public class ChatClientJSON {

    private static final String SERVER_HOST = "localhost";
    private static final int SERVER_PORT = 8080;
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static void main(String[] args) {
        try (Socket socket = new Socket(SERVER_HOST, SERVER_PORT);
             BufferedReader reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
             PrintWriter writer = new PrintWriter(socket.getOutputStream(), true)) {

            System.out.println("Connected to the server.");

            // Start message sender thread
            Thread messageSenderThread = new Thread(new MessageSender(writer));
            messageSenderThread.start();

            // Simulate chat
            while (true) {
                String jsonMessage = reader.readLine();
                if (jsonMessage != null) {
                    //deserialize
                    Message message = objectMapper.readValue(jsonMessage, Message.class);
                    System.out.println("Received message from " + message.getSender() + ": " + message.getContent());

                    if ("!bye".equals(message.getContent())) {
                        System.out.println("Received !bye command. Closing the client.");
//                        messageSenderThread.interrupt();
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

        private PrintWriter writer;

        public MessageSender(PrintWriter writer) {
            this.writer = writer;
        }

        @Override
        public void run() {
            try {
                BufferedReader consoleReader = new BufferedReader(new InputStreamReader(System.in));
                while (!Thread.interrupted()) {
                    String content = consoleReader.readLine();

                    if ("!bye".equals(content)) {
                        System.out.println("Closing the client.");
                        //serialize
                        Message byeMessage = new Message("Client", "!bye");
                        String jsonByeMessage = objectMapper.writeValueAsString(byeMessage);
                        writer.println(jsonByeMessage);
                        System.exit(0);
//                        Thread.currentThread().interrupt();
                        break;
                    } else {
                        //serialize and send to the server
                        Message message = new Message("Client", content);
                        String jsonMessage = objectMapper.writeValueAsString(message);
                        writer.println(jsonMessage);
                    }
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}

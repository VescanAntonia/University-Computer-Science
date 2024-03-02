package com.example;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

public class PeerToPeerJSON {

    private static final int PORT = 8080;
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(PORT)) {
            System.out.println("Server is running and listening on port " + PORT);

            Socket clientSocket = serverSocket.accept();
            System.out.println("Connection established with " + clientSocket.getInetAddress());

            try (BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                 PrintWriter writer = new PrintWriter(clientSocket.getOutputStream(), true)) {

                // Start message sender thread
                Thread messageSenderThread = new Thread(new MessageSender(writer));
                messageSenderThread.start();

                // Simulate chat
                while (true) {
                    String jsonMessage = reader.readLine();
                    if (jsonMessage != null) {
                        //deserialize the message into a Message obj
                        Message message = objectMapper.readValue(jsonMessage, Message.class);
                        System.out.println("Received message from " + message.getSender() + ": " + message.getContent());

                        if ("!bye".equals(message.getContent())) {
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
                        System.out.println("Closing the server.");
                        Message byeMessage = new Message("Server", "!bye");
                        String jsonByeMessage = objectMapper.writeValueAsString(byeMessage);
                        writer.println(jsonByeMessage);
//                        Thread.currentThread().interrupt();
                        System.exit(0);
                        break;
                    } else {
                        Message message = new Message("Server", content);
                        //serialize
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


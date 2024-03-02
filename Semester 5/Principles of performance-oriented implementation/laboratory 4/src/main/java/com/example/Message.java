package com.example;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class Message {
    private final String sender;
    private final String content;

    //deserialize JSON into the Message obj
    @JsonCreator
    public Message(
            @JsonProperty("sender") String sender,
            @JsonProperty("content") String content) {
        this.sender = sender;
        this.content = content;
    }

    public String getSender() {
        return sender;
    }

    public String getContent() {
        return content;
    }
}

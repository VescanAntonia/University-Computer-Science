module com.example.toyinterpretergui {
    requires javafx.controls;
    requires javafx.base;
    requires javafx.fxml;
    requires javafx.graphics;


    exports controller;
    opens controller to javafx.fxml;


    exports  model.expression;
    opens model.expression to javafx.fxml;

    exports model.exceptions;
    opens model.exceptions to javafx.fxml;

    exports model.prgstate;
    opens model.prgstate to javafx.fxml;

    exports model.statement;
    opens model.statement to javafx.fxml;

    exports model.type;
    opens model.type to javafx.fxml;

    exports model.ADT;
    opens model.ADT to javafx.fxml;

    exports model.value;
    opens model.value to javafx.fxml;

    exports repository;
    opens repository to javafx.fxml;

    requires org.controlsfx.controls;
    requires org.kordamp.bootstrapfx.core;

    opens com.example.gui to javafx.fxml;
    exports com.example.gui;


}
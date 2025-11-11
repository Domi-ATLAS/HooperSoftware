package HooperSoftware.TFG;

import java.io.PrintWriter;
import java.io.StringWriter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    private final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        // Log completo en consola/fichero
        log.error("Unhandled exception caught in GlobalExceptionHandler", e);

        // obtener stacktrace como string (solo para desarrollo)
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String stacktrace = sw.toString();

        model.addAttribute("error", e.getMessage());
        model.addAttribute("stacktrace", stacktrace); // mostramos esto solo en dev
        return "error";
    }
}

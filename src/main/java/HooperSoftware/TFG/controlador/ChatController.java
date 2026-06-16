package HooperSoftware.TFG.controlador;

import java.security.Principal;
import java.time.LocalDateTime;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import java.security.Principal;
import java.time.LocalDateTime;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

import HooperSoftware.TFG.entidad.MensajeChat;
import HooperSoftware.TFG.servicio.MensajeChatService;

@Controller
public class ChatController {

    private final MensajeChatService mensajeChatService;

    public ChatController(
            MensajeChatService mensajeChatService) {

        this.mensajeChatService = mensajeChatService;
    }

    @GetMapping("/chat")
    public ModelAndView chat() {

        ModelAndView mav =
                new ModelAndView("chat/chat");

        mav.addObject(
                "mensajes",
                mensajeChatService.findAllMessages());

        return mav;
    }

    @PostMapping("/chat/send")
    @ResponseBody
    public String enviarMensaje(
            @RequestParam String mensaje,
            Principal principal) {

        if (principal == null) {
            return "redirect:/login";
        }

        MensajeChat nuevo =
                new MensajeChat();

        nuevo.setUsername(
                principal.getName());

        nuevo.setMensaje(
                mensaje);

        nuevo.setFecha(
                LocalDateTime.now());

        mensajeChatService.save(nuevo);

        return "OK";
    }

    @GetMapping("/chat/messages")
    @ResponseBody
    public List<MensajeChat> obtenerMensajes() {

        return mensajeChatService.findAllMessages();
    }
}
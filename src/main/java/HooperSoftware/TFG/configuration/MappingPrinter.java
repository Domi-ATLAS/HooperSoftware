package HooperSoftware.TFG.configuration;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.RequestMappingInfoHandlerMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;

@Component
public class MappingPrinter implements CommandLineRunner {

    @Autowired
    private RequestMappingHandlerMapping handlerMapping;

    @Override
    public void run(String... args) throws Exception {
        System.out.println("---- Registered Request Mappings ----");
        for (RequestMappingInfo info : handlerMapping.getHandlerMethods().keySet()) {
            System.out.println(info);
        }
        System.out.println("---- end mappings ----");
    }
}

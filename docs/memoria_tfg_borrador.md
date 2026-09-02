# Desarrollo de una aplicación web para consulta, gestión y simulación de datos NBA

**Trabajo Fin de Grado**  
**Grado en Ingeniería Informática**  
**Universidad de Sevilla**

Autor: Jose Luis Salazar Gonzalez  
Tutor: [Nombre del tutor]  
Curso académico: [Curso académico]  

---

## Resumen

Este Trabajo Fin de Grado consiste en el desarrollo de una aplicación web centrada en la consulta, gestión y análisis de información relacionada con la NBA. El sistema permite navegar por equipos, jugadores, entrenadores, temporadas, partidos, playoffs, transferencias y votaciones, además de incorporar funcionalidades sociales como perfiles de usuario, chat y participación mediante votos.

El proyecto se ha construido con Java y Spring Boot, siguiendo una arquitectura MVC con vistas JSP, capa de servicios, repositorios JPA y persistencia sobre base de datos relacional. A lo largo del desarrollo se ha trabajado también en la integración de datos externos mediante distintas aproximaciones: datos estáticos de respaldo, consumo de API, lectura de ficheros públicos y pruebas de scraping. Esta parte tuvo especial importancia porque el objetivo no era solo mostrar información fija, sino permitir que la aplicación pudiera actualizar datos NBA por temporada cuando existiese una fuente externa disponible.

Además de la parte de consulta, se ha añadido un módulo de simulación deportiva. Este módulo no pretende sustituir a modelos profesionales de predicción, sino ofrecer una aproximación razonada basada en métricas internas del proyecto. Para ello se utilizan reglas heurísticas y componentes probabilísticos simples sobre edad, experiencia, historial All-Star, posición, estadísticas acumuladas, equilibrio de plantilla y necesidades por equipo. Entre sus funcionalidades se incluyen simulación de temporadas, playoffs, partidos en directo, análisis de traspasos, informes de equipo y un tablero de quintetos con recomendaciones de encaje.

El resultado final es una aplicación web funcional, responsive y con una interfaz unificada inspirada visualmente en la NBA. El proyecto combina desarrollo backend, diseño frontend, modelado de datos, seguridad, integración de fuentes externas y análisis predictivo aplicado al deporte.

**Palabras clave:** Spring Boot, NBA, JSP, JPA, simulación deportiva, aplicación web, análisis de datos, scraping, API.

---

## Abstract

This Final Degree Project presents the development of a web application focused on browsing, managing and analysing NBA-related information. The system allows users to consult teams, players, coaches, seasons, games, playoffs, transfers and voting processes. It also includes social features such as user profiles, chat and user participation through votes.

The application has been developed with Java and Spring Boot, following an MVC architecture with JSP views, service classes, JPA repositories and relational database persistence. During the project, several approaches for external NBA data acquisition were explored, including static backup data, API consumption, public external files and web scraping experiments.

In addition to data consultation, the project includes a sports simulation module. This module is based on heuristic rules and simple probabilistic components applied to player age, experience, All-Star history, position, accumulated statistics, roster balance and team needs. It provides season simulations, playoff predictions, bracket simulations, live game simulations, trade analysis, team reports and a lineup board with player fit recommendations.

The final result is a functional, responsive and visually consistent web application inspired by the NBA style. The project combines backend development, frontend design, data modelling, security, external data integration and predictive analysis applied to basketball.

**Keywords:** Spring Boot, NBA, JSP, JPA, sports simulation, web application, data analysis, scraping, API.

---

## 1. Introducción

### 1.1 Contexto del proyecto

La NBA es una de las competiciones deportivas con mayor volumen de datos disponibles: plantillas, resultados históricos, estadísticas individuales, traspasos, clasificaciones, playoffs, votaciones y predicciones. Esta cantidad de información hace que sea un buen contexto para desarrollar una aplicación web que combine consulta de datos, administración, visualización y análisis.

El proyecto nace con la idea de construir una plataforma propia sobre la NBA, desarrollada con tecnologías vistas durante el grado y ampliada con funcionalidades más cercanas a una aplicación real. La aplicación no se limita a mostrar tablas, sino que incorpora filtros, perfiles de usuario, votaciones, chat, marcador, noticias, datos externos y simulaciones deportivas.

Desde el punto de vista técnico, el sistema se ha desarrollado con Spring Boot, que facilita la creación de aplicaciones Java autocontenidas y simplifica la configuración inicial del proyecto mediante starters y autoconfiguración [Spring Boot Documentation](https://docs.spring.io/spring-boot/reference/). La organización sigue el patrón Modelo-Vista-Controlador, una separación clásica entre datos, presentación y flujo de control descrita originalmente por Trygve Reenskaug en su trabajo sobre MVC [Reenskaug, 1979](https://doi.org/10.5281/zenodo.3676092).

### 1.2 Motivación

La motivación principal ha sido realizar un proyecto completo que integrase distintas áreas del desarrollo web: persistencia de datos, seguridad, diseño de interfaz, consumo de fuentes externas y lógica de simulación. La NBA ofrecía un dominio suficientemente amplio para justificar un modelo de datos rico y, al mismo tiempo, cercano y comprensible para el usuario final.

Durante el desarrollo también surgió una motivación adicional: comprobar hasta qué punto era viable alimentar la aplicación con datos reales obtenidos de Internet. Para ello se estudiaron varias opciones. En primer lugar, se intentó trabajar con scraping de Basketball Reference. Posteriormente se probó la API balldontlie, que ofrece endpoints para equipos, jugadores, partidos y estadísticas NBA [balldontlie NBA API](https://docs.balldontlie.io/). Finalmente se incorporó un enfoque más robusto con fuentes externas públicas y datos de respaldo.

### 1.3 Objetivos

El objetivo general del proyecto es desarrollar una aplicación web sobre la NBA que permita consultar, gestionar y analizar información deportiva desde una interfaz unificada.

Los objetivos específicos son:

- Diseñar un modelo de datos capaz de representar equipos, jugadores, entrenadores, temporadas, partidos, playoffs, transferencias, usuarios, votaciones y mensajes.
- Implementar una arquitectura web basada en Spring Boot, Spring MVC, servicios y repositorios JPA.
- Crear una interfaz mediante JSP, JSTL, HTML, CSS y JavaScript.
- Incorporar autenticación, autorización y gestión de perfiles.
- Permitir la consulta filtrada de datos deportivos.
- Integrar datos externos mediante API, scraping o ficheros públicos.
- Mantener datos estáticos de respaldo para garantizar que la aplicación pueda ejecutarse sin depender siempre de servicios externos.
- Añadir un módulo de simulación y análisis deportivo basado en reglas de puntuación, probabilidad y comparación de plantillas.
- Rediseñar la interfaz para que todas las pantallas compartan un estilo visual coherente y responsive.
- Validar el funcionamiento general mediante pruebas manuales y compilación del proyecto.

### 1.4 Alcance del sistema

El sistema desarrollado cubre tanto funcionalidades públicas como funcionalidades reservadas a usuarios autenticados o administradores. Cualquier usuario puede consultar información de equipos, jugadores, partidos, temporadas, playoffs, noticias y simulaciones disponibles. Los usuarios registrados pueden gestionar su perfil, participar en votaciones y utilizar funcionalidades sociales. El administrador puede lanzar procesos de actualización de datos y crear nuevas votaciones.

El proyecto no pretende ser una réplica oficial de la NBA ni un sistema profesional de predicción deportiva. Su finalidad es académica y técnica: demostrar la construcción de una aplicación completa, extensible y conectada con datos deportivos. Por ese motivo, algunas predicciones se basan en métricas simplificadas y datos internos, no en modelos estadísticos entrenados con grandes volúmenes de información histórica.

### 1.5 Estructura de la memoria

La memoria se organiza en once capítulos. Tras esta introducción, se presenta el estado del arte, la planificación, el análisis de requisitos, el diseño, las tecnologías utilizadas, la implementación, la integración de datos NBA, el módulo de simulaciones, las pruebas y las conclusiones.

---

## 2. Estado del arte

### 2.1 Aplicaciones deportivas y plataformas NBA

Las aplicaciones deportivas actuales suelen combinar información en tiempo real, estadísticas históricas, noticias y experiencia personalizada. En el caso de la NBA, existen plataformas oficiales y no oficiales que ofrecen resultados, plantillas, calendarios, estadísticas y análisis. Este proyecto toma esa idea como referencia, pero la adapta a un entorno académico y a una implementación propia en Spring Boot.

La existencia de fuentes como NBA.com, Basketball Reference, FiveThirtyEight o balldontlie demuestra que los datos deportivos pueden consumirse desde distintas perspectivas: información oficial, datos históricos, rankings predictivos, APIs o datasets públicos. El reto del proyecto ha sido seleccionar y adaptar estas fuentes a un modelo de datos propio.

### 2.2 Consulta de estadísticas deportivas

La analítica deportiva utiliza métricas para resumir el rendimiento de jugadores y equipos. En baloncesto, algunos enfoques clásicos se basan en el tiro, el rebote, las pérdidas y los tiros libres. Dean Oliver popularizó los "Four Factors", que Basketball Reference resume como tiro, pérdidas, rebote y tiros libres [Basketball Reference, Four Factors](https://www.basketball-reference.com/about/factors.html). Aunque el proyecto no implementa literalmente esos cuatro factores, sí toma una idea parecida: convertir información deportiva en indicadores comparables.

En la aplicación, las métricas más relevantes se han simplificado para adaptarse a los datos disponibles: experiencia NBA, edad, historial All-Star, posición, puntos, asistencias, rebotes, triples, tiros de campo, tiros libres, tapones y robos. A partir de estos datos se calculan puntuaciones de rating, tiro, defensa, equilibrio y encaje.

### 2.3 APIs deportivas y fuentes externas

El uso de APIs permite obtener datos estructurados sin depender del HTML de una web. La API balldontlie ofrece endpoints para equipos, jugadores, partidos y estadísticas NBA, pero su uso está condicionado por autenticación, paginación y límites de llamadas [balldontlie API](https://docs.balldontlie.io/). En el proyecto se estudió esta alternativa y se mantuvo como una vía válida, aunque no fue suficiente para cargar todos los datos deseados sin restricciones.

También se exploraron datasets públicos. FiveThirtyEight publicó datos históricos de partidos y ratings Elo NBA, con campos como temporada, equipos, puntuaciones y probabilidades Elo [FiveThirtyEight NBA Elo Data](https://fivethirtyeightdata.github.io/fivethirtyeightdata/reference/nba_elo.html). Este tipo de fuente resulta adecuada para alimentar partidos por temporada porque se basa en ficheros descargables y no en múltiples llamadas individuales.

### 2.4 Scraping web aplicado a datos deportivos

El scraping consiste en extraer información desde páginas HTML. En Java, una herramienta habitual para ello es jsoup, que permite descargar, parsear y consultar documentos HTML mediante selectores CSS [jsoup Documentation](https://jsoup.org/apidocs/). En el proyecto se implementaron servicios y DTOs relacionados con scraping para equipos, jugadores, entrenadores, partidos, jornadas, temporadas, playoffs y transferencias.

La principal dificultad del scraping es su fragilidad. Si una web cambia clases, etiquetas o estructura interna, el código puede dejar de funcionar. Además, deben respetarse términos de uso y límites de acceso. Sports Reference indica restricciones relevantes sobre usos automatizados y reutilización de datos [Sports Reference Data Use](https://www.sports-reference.com/data_use.html). Por ello, el scraping se trató como una línea de experimentación y no como única fuente obligatoria.

### 2.5 Simulación y análisis predictivo en deporte

La predicción deportiva puede abordarse con modelos estadísticos complejos, sistemas Elo, modelos de regresión o simulaciones repetidas. FiveThirtyEight, por ejemplo, ha explicado cómo combina ratings de equipo, información de jugadores, localía y otros ajustes para convertirlos en probabilidades de victoria [FiveThirtyEight NBA Predictions Methodology](https://fivethirtyeight.com/methodology/how-our-nba-predictions-work/).

El módulo desarrollado en este TFG es más sencillo. No utiliza entrenamiento automático ni miles de iteraciones Monte Carlo. Se apoya en reglas heurísticas y componentes aleatorios controlados. Esto permite que el sistema sea comprensible, mantenible y coherente con los datos disponibles en la aplicación.

---

## 3. Planificación y metodología

### 3.1 Metodología de desarrollo

El proyecto se desarrolló durante aproximadamente dos años, con pausas y periodos de reactivación. Por este motivo no sería realista describirlo como un Scrum estricto con sprints regulares. La metodología seguida se ajusta mejor a un desarrollo iterativo por hitos.

Cada hito se centró en una parte concreta del sistema: creación del proyecto base, modelado de entidades, desarrollo de controladores y vistas, seguridad, carga inicial de datos, mejora de interfaz, integración de datos externos y módulo de simulaciones. Esta forma de trabajo permitió avanzar aunque el ritmo no fuese siempre uniforme.

### 3.2 Desarrollo iterativo por hitos

Los principales hitos del proyecto fueron:

- Hito 1: configuración inicial de Spring Boot, Maven y estructura de paquetes.
- Hito 2: creación de entidades JPA y repositorios.
- Hito 3: desarrollo de vistas JSP para equipos, jugadores, entrenadores, partidos y temporadas.
- Hito 4: incorporación de usuarios, seguridad y roles.
- Hito 5: creación de chat, votaciones y perfil.
- Hito 6: mejora de filtros y buscadores.
- Hito 7: rediseño visual uniforme y responsive.
- Hito 8: exploración de scraping y APIs externas.
- Hito 9: sincronización de datos NBA por temporada.
- Hito 10: desarrollo del módulo de simulaciones deportivas.
- Hito 11: revisión de errores, márgenes, textos, carga visual y experiencia de usuario.

### 3.3 Evolución del proyecto durante dos años

La duración del proyecto tuvo una ventaja y una dificultad. La ventaja fue que permitió ampliar el alcance inicial y convertir una aplicación de consulta en una plataforma más completa. La dificultad fue mantener coherencia entre código antiguo y mejoras posteriores.

Algunas partes empezaron con datos estáticos y vistas sencillas. Más adelante se añadieron filtros, una capa visual común, integración externa, simulaciones y mejoras de perfil. Esta evolución explica que una parte importante del trabajo haya consistido también en refactorizar la presentación sin eliminar funcionalidades ni cambiar la lógica de negocio original.

### 3.4 Riesgos y problemas encontrados

Los principales riesgos fueron:

- Dependencia de fuentes externas que podían cambiar o limitar el acceso.
- Posibles errores de codificación de caracteres en JSP y datos.
- Inconsistencias visuales entre pantallas creadas en momentos diferentes.
- Existencia de datos incompletos para algunos jugadores o equipos.
- Fragilidad del scraping ante cambios de estructura HTML.
- Necesidad de mantener datos de respaldo para que la aplicación siguiese siendo demostrable.

### 3.5 Estimación temporal y costes

La estimación temporal puede presentarse por fases, no por sprints cerrados:

| Fase | Descripción | Tiempo aproximado |
| --- | --- | --- |
| Análisis inicial | Estudio del dominio NBA y definición de funcionalidades | 40 h |
| Base técnica | Configuración Spring Boot, Maven, seguridad y vistas iniciales | 80 h |
| Modelo de datos | Entidades, repositorios y datos de prueba | 90 h |
| Funcionalidades principales | Equipos, jugadores, partidos, playoffs, transferencias y temporadas | 140 h |
| Usuarios y participación | Login, perfil, chat y votaciones | 80 h |
| Integración externa | API, scraping, CSV y sincronización | 100 h |
| Simulaciones | Predicción, bracket, temporada, traspasos y tablero | 120 h |
| Rediseño UI | CSS común, responsive, formularios, tablas y tarjetas | 90 h |
| Pruebas y correcciones | Validación manual, compilación y ajustes finales | 70 h |
| Documentación | Memoria, capturas, anexos y preparación de defensa | 80 h |

El coste económico directo es bajo al utilizar herramientas gratuitas y de código abierto. El coste principal corresponde al tiempo de desarrollo. Si se valorase el trabajo con una tarifa orientativa de estudiante/desarrollador junior, el coste estimado dependería del precio/hora elegido. Para una estimación académica puede calcularse sobre el total aproximado de horas.

---

## 4. Análisis de requisitos

### 4.1 Actores del sistema

El sistema contempla tres perfiles principales:

- Usuario visitante: puede navegar por contenidos públicos.
- Usuario registrado: puede acceder a perfil, chat y votaciones.
- Administrador: puede realizar acciones de gestión, crear votaciones y actualizar datos NBA.

### 4.2 Requisitos funcionales

Los requisitos funcionales principales son:

- RF01. El sistema debe permitir consultar todos los equipos NBA.
- RF02. El sistema debe permitir consultar el detalle de un equipo.
- RF03. El sistema debe permitir consultar jugadores y entrenadores.
- RF04. El sistema debe permitir filtrar jugadores, entrenadores, partidos, playoffs, transferencias y votaciones.
- RF05. El sistema debe mostrar temporadas, jornadas y partidos.
- RF06. El sistema debe mostrar información de playoffs y series.
- RF07. El sistema debe permitir registrar usuarios.
- RF08. El sistema debe permitir iniciar y cerrar sesión.
- RF09. El sistema debe permitir editar el perfil y subir una imagen de avatar.
- RF10. El sistema debe permitir cambiar la contraseña.
- RF11. El sistema debe permitir participar en votaciones.
- RF12. El administrador debe poder crear votaciones.
- RF13. El sistema debe incluir chat de usuarios.
- RF14. El sistema debe mostrar noticias y contenido embebido.
- RF15. El sistema debe mostrar un marcador en directo o simulado.
- RF16. El administrador debe poder actualizar datos NBA según la temporada seleccionada.
- RF17. El sistema debe conservar datos de respaldo.
- RF18. El sistema debe simular playoffs, temporadas y partidos.
- RF19. El sistema debe analizar traspasos y encaje de jugadores.
- RF20. El sistema debe mostrar un tablero de quintetos con recomendaciones.

### 4.3 Requisitos no funcionales

- RNF01. La aplicación debe ser responsive para pantallas móviles y de escritorio.
- RNF02. La interfaz debe mantener una estética uniforme.
- RNF03. Las contraseñas no deben almacenarse en texto plano.
- RNF04. El sistema debe estar estructurado por capas para facilitar mantenimiento.
- RNF05. La aplicación debe poder ejecutarse sin depender siempre de Internet.
- RNF06. Las fuentes externas deben tratarse con control de errores.
- RNF07. Los formularios deben ser claros y consistentes.
- RNF08. El código debe seguir una estructura comprensible para su defensa académica.

### 4.4 Casos de uso principales

Los casos de uso más representativos son:

- Consultar equipo.
- Consultar jugador.
- Filtrar datos por equipo o temporada.
- Ver partidos y playoffs.
- Registrarse e iniciar sesión.
- Editar perfil.
- Participar en votación.
- Crear votación como administrador.
- Actualizar datos NBA desde el panel de administración.
- Simular una temporada.
- Simular playoffs.
- Analizar un traspaso.
- Crear un quinteto en el tablero y obtener recomendaciones.

### 4.5 Modelo de dominio

El modelo de dominio se compone de entidades relacionadas con la competición y con la interacción de usuarios. Entre las entidades principales se encuentran `Equipo`, `Jugador`, `Entrenador`, `Partido`, `Temporada`, `Jornada`, `Playoff`, `Transferencia`, `Usuario`, `Authorities`, `Votacion`, `VotoUsuario` y `MensajeChat`.

Las entidades deportivas permiten representar la información NBA. Las entidades de usuario permiten gestionar autenticación, roles, participación y actividad dentro de la aplicación.

---

## 5. Diseño del sistema

### 5.1 Arquitectura general

La arquitectura sigue una separación por capas:

- Capa de presentación: formada por JSP, JSTL, JavaScript y CSS.
- Capa de controladores: recibe peticiones HTTP y prepara los modelos de vista.
- Capa de servicios: concentra la lógica de negocio y operaciones de cálculo.
- Capa de repositorios: abstrae el acceso a datos mediante Spring Data JPA.
- Capa de entidades: representa el modelo persistente.
- Capa de integración externa: gestiona API, scraping y fuentes públicas.

Esta organización reduce el acoplamiento entre la vista y la persistencia. También facilita justificar la aplicación desde el patrón MVC: el modelo se representa mediante entidades y servicios, la vista mediante JSP y el controlador mediante clases anotadas de Spring MVC.

### 5.2 Patrón MVC con Spring Boot

Spring MVC permite mapear rutas HTTP a métodos de controlador y devolver vistas o redirecciones. En el proyecto se utilizan controladores específicos para equipos, jugadores, entrenadores, partidos, playoffs, simulaciones, usuarios, votaciones, chat y administración.

Las vistas se resuelven con la configuración:

```properties
spring.mvc.view.prefix=/WEB-INF/view/
spring.mvc.view.suffix=.jsp
```

Esto permite devolver nombres lógicos de vista desde los controladores y mantener las JSP protegidas dentro de `WEB-INF`.

### 5.3 Diseño de la base de datos

La persistencia se implementa mediante JPA. Spring Data JPA reduce código repetitivo en la capa de acceso a datos mediante repositorios, consultas derivadas y consultas personalizadas [Spring Data JPA](https://docs.spring.io/spring-data/jpa/reference/jpa.html).

Durante el desarrollo se utiliza H2 como base de datos local. H2 es una base de datos Java ligera que puede funcionar en modo embebido o servidor y resulta útil para desarrollo y pruebas [H2 Database](https://h2database.github.io/html/main.html). El proyecto también mantiene dependencias compatibles con MySQL, de forma que el sistema puede adaptarse a una base de datos relacional persistente en un entorno más cercano a producción.

### 5.4 Diseño de la interfaz

La interfaz se rediseñó para unificar páginas que habían sido creadas en distintas fases del proyecto. Se definió una estética inspirada en la NBA, con predominio de azul oscuro, blanco y gris, botones uniformes, sombras suaves, bordes redondeados, tablas legibles y formularios alineados.

Se dio prioridad a que las pantallas de consulta no pareciesen páginas aisladas. Para ello se trabajó sobre contenedores, márgenes, separación entre botones, tarjetas de datos, filtros y tablas.

### 5.5 Diseño responsive

El diseño responsive se basa en contenedores flexibles, rejillas CSS y media queries. El planteamiento sigue la idea general del responsive web design: adaptar el contenido al dispositivo mediante rejillas fluidas, imágenes flexibles y reglas CSS específicas [Marcotte, 2010](https://alistapart.com/article/responsive-web-design/).

El objetivo no fue crear una versión móvil distinta, sino hacer que las mismas vistas pudieran reorganizarse en pantallas pequeñas sin perder funcionalidad.

### 5.6 Seguridad y control de acceso

La seguridad se implementa con Spring Security. Este framework proporciona autenticación, autorización y protección frente a ataques habituales en aplicaciones Spring [Spring Security Reference](https://docs.spring.io/spring-security/reference/).

El proyecto utiliza usuarios, roles y restricciones de acceso. Las contraseñas se almacenan mediante `BCryptPasswordEncoder`, evitando guardarlas en texto plano. OWASP recomienda usar algoritmos adaptativos como bcrypt, scrypt o Argon2 para el almacenamiento seguro de contraseñas [OWASP Password Storage](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html). NIST también recomienda almacenar contraseñas con mecanismos resistentes a ataques offline y con coste configurable [NIST SP 800-63B](https://pages.nist.gov/800-63-4/sp800-63b.html).

### 5.7 Integración con fuentes externas

El sistema incorpora una capa para sincronizar datos NBA. Se contemplan varias fuentes:

- API balldontlie para equipos, jugadores y partidos.
- Ficheros públicos de datos históricos.
- Servicios de scraping basados en jsoup.
- Datos estáticos de respaldo cargados desde `data.sql`.

Esta combinación permite explicar una decisión técnica importante: no depender de una única fuente externa.

### 5.8 Diseño del módulo de simulaciones

El módulo de simulaciones está centralizado principalmente en `SimulacionService`. Su diseño se basa en convertir datos de jugadores y equipos en métricas internas. Estas métricas se usan después para generar predicciones, rankings y recomendaciones.

El sistema no entrena un modelo de aprendizaje automático. Se eligió un enfoque más transparente y defendible: reglas heurísticas y simulación aleatoria controlada. Así, cada resultado puede explicarse a partir de las variables utilizadas.

---

## 6. Tecnologías utilizadas

### 6.1 Java y Spring Boot

El proyecto se desarrolla en Java 17, versión LTS del lenguaje [OpenJDK 17](https://openjdk.org/projects/jdk/17/). Spring Boot se utiliza como base para crear una aplicación web Java con configuración simplificada, servidor embebido y gestión de dependencias mediante starters [Spring Boot Documentation](https://docs.spring.io/spring-boot/reference/).

### 6.2 Spring MVC, Spring Security y Spring Data JPA

Spring MVC se utiliza para implementar controladores y navegación web. Spring Security proporciona autenticación, autorización y protección de rutas. Spring Data JPA permite implementar repositorios y consultas sobre entidades con menos código repetitivo.

### 6.3 JSP, JSTL, JavaScript, HTML y CSS

Las vistas se han desarrollado con JSP y JSTL. JSTL proporciona etiquetas para tareas comunes en JSP, como condicionales e iteraciones [Jakarta Standard Tag Library](https://projects.eclipse.org/projects/ee4j.jstl). JavaScript se utiliza para filtros, autocompletado, tablero de quintetos, noticias embebidas, visualización de contraseña y comportamiento de pantallas de error.

### 6.4 Maven y base de datos

Maven se utiliza para compilar, empaquetar y gestionar dependencias. El archivo `pom.xml` define coordenadas del proyecto, dependencias y plugins. Maven estructura el ciclo de vida en fases como `compile`, `test`, `package` y `verify` [Maven Build Lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html).

La base de datos de desarrollo principal es H2, con soporte adicional para MySQL.

### 6.5 Jsoup, OpenCSV y Jackson

Jsoup se emplea en la parte de scraping y análisis de HTML. OpenCSV se incorpora para trabajar con ficheros CSV. Jackson se utiliza para procesar JSON y mapear respuestas externas a objetos Java; Jackson es una de las bibliotecas más usadas en Java para serialización y deserialización de datos [Jackson Project](https://github.com/FasterXML/jackson).

### 6.6 Sobre Thumbnailator

Thumbnailator aparece declarado como dependencia en el proyecto, pero en el estado actual del código no se utiliza de forma efectiva en la subida de imágenes. La subida de avatar se realiza validando la extensión del archivo y copiándolo a las carpetas estática y de ejecución.

Thumbnailator es una librería Java orientada a redimensionar y generar miniaturas de imágenes. En este proyecto puede justificarse como una dependencia prevista para mejorar el tratamiento de imágenes de perfil, por ejemplo para normalizar todos los avatares a un tamaño fijo, reducir peso o generar miniaturas. Si finalmente no se usa en el código final, conviene no presentarla como tecnología principal, sino como dependencia auxiliar o mejora pendiente.

### 6.7 APIs externas y fuentes NBA

La API balldontlie se estudió para obtener datos NBA mediante endpoints REST. FiveThirtyEight se usó como referencia de fuente pública para datos históricos de partidos y ratings Elo. Basketball Reference se analizó como fuente deportiva, aunque con limitaciones para scraping automatizado.

---

## 7. Implementación

### 7.1 Estructura del proyecto

La estructura principal del proyecto es:

- `src/main/java/HooperSoftware/TFG/controlador`: controladores web.
- `src/main/java/HooperSoftware/TFG/servicio`: servicios y lógica de negocio.
- `src/main/java/HooperSoftware/TFG/repositorio`: repositorios JPA.
- `src/main/java/HooperSoftware/TFG/entidad`: entidades del dominio.
- `src/main/java/HooperSoftware/TFG/dto`: objetos de transferencia de datos.
- `src/main/java/HooperSoftware/TFG/external`: integración con fuentes externas.
- `src/main/java/HooperSoftware/TFG/scraping`: pruebas y servicios de scraping.
- `src/main/webapp/WEB-INF/view`: vistas JSP.
- `src/main/resources/static`: CSS, JavaScript e imágenes.
- `src/main/resources/db/data.sql`: datos de respaldo.

### 7.2 Gestión de usuarios y perfiles

El sistema permite registrar usuarios, iniciar sesión, consultar el perfil, editar datos, subir imagen y cambiar contraseña. El perfil incluye información básica, equipo favorito, rol, votos emitidos, mensajes enviados e historial de votaciones.

La imagen de perfil se recibe como `MultipartFile`. El sistema valida extensiones permitidas y guarda el archivo en la ruta de recursos estáticos. Este enfoque permite que el avatar se muestre posteriormente desde la vista JSP.

### 7.3 Gestión de equipos, jugadores y entrenadores

La aplicación permite consultar equipos NBA mediante vistas específicas y listados generales. Los jugadores y entrenadores se muestran con filtros por equipo y buscadores por nombre. Esta parte es esencial porque alimenta tanto la navegación principal como el módulo de simulaciones.

### 7.4 Gestión de partidos, temporadas y playoffs

El sistema incluye entidades y vistas para temporadas, jornadas, partidos y playoffs. Se pueden consultar partidos generales, partidos por equipo y series de playoffs. También se rediseñaron las vistas para mejorar márgenes, legibilidad y coherencia visual.

### 7.5 Transferencias, votaciones y chat

Las transferencias permiten representar movimientos entre equipos. Las votaciones permiten participación del usuario y creación de nuevas votaciones por parte del administrador. El chat añade una dimensión social básica a la aplicación.

### 7.6 Marcador en directo y noticias

El marcador en directo se integra como una sección de consulta rápida del estado de partidos. Las noticias utilizan JavaScript y contenido embebido para enriquecer la experiencia de usuario sin añadir complejidad excesiva al backend.

### 7.7 Administración y sincronización de datos

El administrador puede seleccionar una temporada y pulsar el botón "Actualizar NBA". El sistema utiliza esa temporada como parámetro para cargar datos desde fuentes externas y adaptarlos al modelo interno. Durante la carga se muestra una espera visual para mejorar la experiencia.

### 7.8 Filtros y experiencia de usuario

Se añadieron filtros en secciones de datos para mejorar la navegación. Esto incluye filtros por equipo, temporada, categoría, fechas y búsquedas textuales. La interfaz se revisó para evitar elementos demasiado pegados, selectores poco legibles y diferencias visuales entre páginas.

---

## 8. Obtención e integración de datos NBA

### 8.1 Datos iniciales estáticos

El proyecto mantiene un fichero `data.sql` con datos de respaldo. Esta decisión permite que la aplicación se pueda ejecutar y demostrar aunque las fuentes externas fallen, cambien o limiten el acceso.

### 8.2 Intento de scraping con Basketball Reference

Basketball Reference fue una de las primeras fuentes analizadas. La ventaja era la riqueza de datos históricos. La desventaja fue la fragilidad del scraping: cambios en etiquetas HTML, selectores o estructura de página pueden romper el proceso.

Además, Sports Reference establece condiciones de uso y advertencias sobre acceso automatizado y reutilización masiva de datos [Sports Reference Terms](https://www.sports-reference.com/termsofuse.html). Por este motivo, se mantuvo el scraping como prueba técnica, pero no como dependencia única del sistema.

### 8.3 Uso de la API balldontlie y limitaciones

La API balldontlie ofrece datos estructurados para NBA, incluyendo equipos, jugadores, partidos y estadísticas [balldontlie NBA API](https://docs.balldontlie.io/). Sin embargo, el uso de APIs externas obliga a tener en cuenta autenticación, paginación, límites de llamadas y disponibilidad del servicio.

En el proyecto esta API se integró como aproximación técnica, pero las limitaciones de llamadas dificultaron cargar todo el volumen de datos deseado.

### 8.4 Carga desde fuentes públicas

Para complementar la API, se trabajó con fuentes públicas basadas en ficheros. Este enfoque reduce el número de llamadas HTTP y facilita cargar una temporada completa. FiveThirtyEight publica datos históricos NBA con información de partidos, temporadas, equipos, resultados y ratings Elo [FiveThirtyEight NBA Elo Data](https://fivethirtyeightdata.github.io/fivethirtyeightdata/reference/nba_elo.html).

### 8.5 Adaptación al modelo interno

Uno de los retos fue adaptar datos externos al modelo propio. Los nombres, abreviaturas, temporadas y campos no siempre coinciden directamente. Por ello se incorporaron DTOs y servicios de sincronización para transformar la información externa en entidades internas como `Equipo`, `Jugador` o `Partido`.

### 8.6 Datos de respaldo

El sistema mantiene datos locales para no depender exclusivamente de Internet. Esto es importante en una defensa o demostración académica, porque evita que una caída de red o un cambio de API impida mostrar la aplicación.

---

## 9. Simulaciones y análisis deportivo

### 9.1 Objetivo del módulo

El módulo de simulación busca añadir valor analítico a la aplicación. Su finalidad es que el usuario no solo consulte datos, sino que pueda plantear escenarios: qué equipo tiene más opciones de playoff, cómo quedaría una temporada, qué traspaso mejora más una plantilla o qué jugadores encajan mejor en un quinteto.

### 9.2 Tipo de algoritmo utilizado

El sistema utiliza un modelo heurístico con componentes probabilísticos. No es un modelo de machine learning entrenado y tampoco es una simulación Monte Carlo completa en sentido estricto.

Una simulación Monte Carlo suele ejecutar muchas iteraciones aleatorias para estimar distribuciones de resultados. En este proyecto sí existen elementos aleatorios, pero normalmente se ejecuta una simulación concreta, no miles de repeticiones. Por tanto, la descripción más precisa es:

**modelo heurístico de simulación deportiva con aleatoriedad controlada**.

Esta decisión tiene una ventaja clara para un TFG: los resultados son explicables. Cada predicción se puede justificar a partir de reglas visibles en el código.

### 9.3 Cálculo de rating de jugadores y equipos

El rating de jugador combina:

- Años All-Star.
- Años de experiencia NBA.
- Edad.
- Puntos acumulados.
- Asistencias.
- Rebotes.
- Triples.
- Tiros de campo.
- Tiros libres.
- Robos.
- Tapones.

El rating de equipo se calcula agregando los ratings individuales de sus jugadores. Este rating se usa después como base para predicciones de victorias, playoffs y probabilidades.

### 9.4 Predicción de playoffs

La predicción de playoffs es determinista. A partir del rating de plantilla se calculan:

- Probabilidad de entrar en playoffs.
- Probabilidad de llegar a finales.
- Probabilidad de ser campeón.
- Categoría competitiva del equipo.
- Mensaje de diagnóstico.

No se obtiene una predicción oficial, sino una estimación interna coherente con los datos disponibles.

### 9.5 Simulación de bracket

La simulación de bracket ordena equipos por rating, selecciona los mejores y crea cruces tipo playoff. Cada serie se simula hasta que un equipo gana cuatro partidos.

En cada partido de la serie se calcula la probabilidad de victoria en función del rating relativo:

```text
probabilidadA = ratingA / (ratingA + ratingB)
```

Después se utiliza un número aleatorio para decidir el ganador de cada partido. Este enfoque es probabilístico, pero no Monte Carlo completo porque no repite el bracket muchas veces para estimar frecuencias.

### 9.6 Simulación de temporada

La simulación de temporada convierte el rating de un equipo en una estimación de victorias sobre 82 partidos. El resultado se limita a un rango razonable para evitar valores extremos. Después se ordenan los equipos por victorias y se selecciona un equipo destacado.

### 9.7 Simulación de partido en directo

La simulación de partido en directo genera puntuaciones por cuarto usando rangos aleatorios controlados. Después calcula ganador, probabilidad de victoria y estado del partido. Es una funcionalidad pensada para visualizar escenarios de marcador, no para reproducir un partido real posesión por posesión.

### 9.8 Análisis de traspasos

El análisis de traspasos utiliza reglas de puntuación. Se parte de una base de 50 puntos y se ajusta según:

- Diferencia de experiencia.
- Diferencia de años All-Star.
- Edad del jugador que llega.
- Coincidencia de posición.
- Salario estimado.
- Impacto previsto en victorias.

Este enfoque permite comparar jugadores y estimar si un movimiento mejora, equilibra o empeora una plantilla.

### 9.9 Análisis de dinastías

La simulación de dinastías proyecta varios años de rendimiento. Genera temporadas futuras mediante valores aleatorios controlados y clasifica resultados como campeón, final de conferencia, semifinal o temporada media. El objetivo es ofrecer una visión lúdica y analítica de continuidad competitiva.

### 9.10 Tablero de quintetos

El tablero permite seleccionar jugadores sobre una pista y analizar:

- Rating ofensivo.
- Spacing.
- Defensa.
- Equilibrio posicional.
- Mejores compañeros disponibles.
- Rivales favorables.
- Equipos donde encajaría mejor un jugador.
- Sugerencias para casillas vacías.

El cálculo de defensa utiliza rebotes, tapones, robos, experiencia y posición. El cálculo de tiro utiliza triples, tiros de campo, tiros libres e historial All-Star. El encaje por equipo tiene en cuenta la necesidad de posición y la profundidad de plantilla.

### 9.11 Limitaciones del modelo

Las principales limitaciones son:

- No se entrena con datasets históricos completos.
- No incorpora lesiones, minutos reales, salarios oficiales ni contratos completos.
- No ejecuta miles de simulaciones por escenario.
- La calidad depende de que los jugadores tengan estadísticas suficientes.
- Algunas métricas se estiman mediante reglas internas.

Estas limitaciones no invalidan el módulo, pero deben explicarse claramente. El valor del módulo está en su integración con la aplicación y en la transparencia del razonamiento.

---

## 10. Pruebas y validación

### 10.1 Estrategia de pruebas

La validación se ha basado en pruebas manuales de navegación, compilación con Maven, revisión de vistas, comprobación de formularios y ejecución de flujos principales.

Para compilar el proyecto se utiliza:

```bash
./mvnw -DskipTests package
```

En Windows:

```powershell
.\mvnw.cmd -DskipTests package
```

Maven ejecuta las fases necesarias hasta generar el paquete de la aplicación [Maven Lifecycle](https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html).

### 10.2 Pruebas funcionales

Se probaron los siguientes flujos:

- Acceso a página principal.
- Navegación entre secciones.
- Consulta de equipos.
- Consulta de jugadores y entrenadores.
- Filtros por equipo.
- Consulta de partidos y playoffs.
- Registro e inicio de sesión.
- Edición de perfil.
- Subida de avatar.
- Cambio de contraseña.
- Creación y participación en votaciones.
- Uso del chat.
- Actualización de datos NBA.
- Simulación de temporada y playoffs.
- Uso del tablero de quintetos.

### 10.3 Pruebas de interfaz

Se revisaron márgenes, botones, formularios, tablas, selectores, contenedores y diseño responsive. También se corrigieron problemas de caracteres corruptos provocados por codificación incorrecta.

### 10.4 Pruebas de seguridad

Se comprobó que las páginas privadas redirigen al login cuando no hay sesión. También se revisó la separación entre usuario normal y administrador. En la gestión de contraseñas se utiliza bcrypt, evitando almacenamiento en texto plano.

### 10.5 Pruebas de sincronización de datos

La sincronización se validó comprobando que, tras seleccionar una temporada y ejecutar la actualización, los datos cargados se reflejan en secciones como jugadores o partidos. También se mantuvo la posibilidad de trabajar con datos de respaldo.

### 10.6 Pruebas del módulo de simulación

Las simulaciones se validaron comprobando que:

- No fallan con datos incompletos.
- Devuelven porcentajes acotados.
- Generan resultados interpretables.
- Ordenan recomendaciones de forma coherente.
- No duplican jugadores sugeridos en el tablero.
- Permiten reiniciar selecciones.

---

## 11. Conclusiones y trabajo futuro

### 11.1 Objetivos alcanzados

El proyecto ha conseguido desarrollar una aplicación web completa sobre la NBA, con consulta de datos, usuarios, seguridad, participación, integración externa, rediseño visual y simulaciones deportivas.

También se ha conseguido que la aplicación evolucione desde una base de datos estática hasta un sistema capaz de trabajar con fuentes externas y datos de respaldo. Esto aporta robustez y permite defender decisiones técnicas tomadas durante el desarrollo.

### 11.2 Dificultades encontradas

Las principales dificultades fueron:

- Mantener coherencia visual entre páginas desarrolladas en momentos distintos.
- Trabajar con fuentes externas limitadas o cambiantes.
- Adaptar datos externos al modelo interno.
- Evitar que el scraping fuese la única fuente del sistema.
- Construir simulaciones explicables con datos incompletos.
- Retomar el proyecto tras pausas largas sin perder continuidad.

### 11.3 Valoración personal

El desarrollo del proyecto ha permitido aplicar conocimientos de programación web, bases de datos, seguridad, diseño de interfaces y análisis de datos. También ha obligado a tomar decisiones prácticas: cuándo usar datos reales, cuándo mantener respaldo, cuándo simplificar un modelo y cuándo priorizar mantenibilidad frente a complejidad.

Una de las conclusiones más importantes es que una aplicación de este tipo no depende solo de programar vistas y controladores. La calidad del resultado también depende de la estructura de datos, la disponibilidad de fuentes externas, la experiencia de usuario y la capacidad de explicar las decisiones tomadas.

### 11.4 Mejoras futuras

Como trabajo futuro se proponen:

- Ejecutar simulaciones Monte Carlo completas con muchas iteraciones por escenario.
- Incorporar métricas avanzadas reales como eficiencia ofensiva/defensiva, usage rate o win shares.
- Añadir contratos y salarios oficiales para mejorar el análisis de traspasos.
- Mejorar la sincronización con una fuente externa estable.
- Añadir tests automatizados de controladores y servicios.
- Externalizar claves de API mediante variables de entorno.
- Usar Thumbnailator para redimensionar avatares automáticamente.
- Exportar resultados de simulaciones en PDF.
- Añadir panel estadístico con gráficas.

---

## Bibliografía y fuentes consultadas

- Apache Maven. "Introduction to the Build Lifecycle". Disponible en: https://maven.apache.org/guides/introduction/introduction-to-the-lifecycle.html
- Apache Maven. "POM Reference". Disponible en: https://maven.apache.org/pom.html
- Basketball Reference. "Four Factors". Disponible en: https://www.basketball-reference.com/about/factors.html
- balldontlie. "NBA API Documentation". Disponible en: https://docs.balldontlie.io/
- Eclipse Foundation. "Jakarta Standard Tag Library". Disponible en: https://projects.eclipse.org/projects/ee4j.jstl
- FasterXML. "Jackson Project". Disponible en: https://github.com/FasterXML/jackson
- FiveThirtyEight. "How Our NBA Predictions Work". Disponible en: https://fivethirtyeight.com/methodology/how-our-nba-predictions-work/
- FiveThirtyEight Data. "NBA Elo Ratings". Disponible en: https://fivethirtyeightdata.github.io/fivethirtyeightdata/reference/nba_elo.html
- H2 Database. "H2 Database Engine". Disponible en: https://h2database.github.io/html/main.html
- jsoup. "jsoup Java HTML Parser Documentation". Disponible en: https://jsoup.org/apidocs/
- Marcotte, E. "Responsive Web Design". A List Apart. Disponible en: https://alistapart.com/article/responsive-web-design/
- NIST. "Digital Identity Guidelines: Authentication and Lifecycle Management, SP 800-63B". Disponible en: https://pages.nist.gov/800-63-4/sp800-63b.html
- OpenJDK. "JDK 17". Disponible en: https://openjdk.org/projects/jdk/17/
- OWASP. "Password Storage Cheat Sheet". Disponible en: https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html
- Reenskaug, T. "Models-Views-Controllers". Xerox PARC, 1979. Disponible en: https://doi.org/10.5281/zenodo.3676092
- Spring. "Spring Boot Reference Documentation". Disponible en: https://docs.spring.io/spring-boot/reference/
- Spring. "Spring Data JPA Reference Documentation". Disponible en: https://docs.spring.io/spring-data/jpa/reference/jpa.html
- Spring. "Spring Security Reference Documentation". Disponible en: https://docs.spring.io/spring-security/reference/
- Sports Reference. "SR and Data Use". Disponible en: https://www.sports-reference.com/data_use.html
- Sports Reference. "Terms of Use". Disponible en: https://www.sports-reference.com/termsofuse.html

---

## Anexos propuestos

### Anexo A. Manual de instalación

1. Instalar Java 17.
2. Clonar o descargar el proyecto.
3. Ejecutar `.\mvnw.cmd -DskipTests package`.
4. Arrancar la aplicación con `.\mvnw.cmd spring-boot:run`.
5. Acceder a `http://localhost:8081`.

### Anexo B. Manual de usuario

El usuario puede navegar por equipos, jugadores, partidos, playoffs, transferencias, votaciones, noticias y simulaciones. Si está registrado, puede acceder a perfil, editar datos, votar y usar el chat.

### Anexo C. Manual de administrador

El administrador puede crear votaciones y actualizar datos NBA mediante el selector de temporada y el botón "Actualizar NBA".

### Anexo D. Modelo de base de datos

Incluir diagrama entidad-relación con las entidades principales: `Equipo`, `Jugador`, `Entrenador`, `Partido`, `Temporada`, `Jornada`, `Playoff`, `Transferencia`, `Usuario`, `Votacion`, `VotoUsuario` y `MensajeChat`.

### Anexo E. Capturas de la aplicación

Incluir capturas de:

- Página principal.
- Listado de equipos.
- Detalle de equipo.
- Listado de jugadores.
- Playoffs.
- Votaciones.
- Perfil.
- Marcador.
- Simulaciones.
- Tablero de quintetos.
- Pantalla de administración.

### Anexo F. Fragmentos de código relevantes

Incluir fragmentos breves de:

- Configuración de seguridad.
- Repositorio JPA.
- Controlador de simulaciones.
- Servicio de sincronización NBA.
- Cálculo de rating.
- Simulación de serie.
- Análisis del tablero de quintetos.

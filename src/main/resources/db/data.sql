-- =========================================================
-- HooperSoftware NBA - datos base de demostracion
-- =========================================================
-- Backup local para arrancar la app sin depender de internet.
-- Los datos fake se distinguen por IDs negativos, temporada de referencia y marcas internas:
--   equipos.logo_equipo = 'fake-data'
--   jugador.temporada_jugador = '2023-2024'
--   jugador.foto_jugador = 'fake-data'
--   entrenador.foto_entrenador = 'fake-data'

-- USUARIOS
INSERT INTO usuario(nombre_usuario, password, correo, equipo_favorito, foto, enabled, username, numero_telefono, biografia, mensajes_enviados, votos_emitidos, reputacion, fecha_registro) VALUES
('Admin Demo', '$2a$12$HBi9mqAheugvoehw0QNzcOtSl11G.2qDFZcqlKetZ552mXsTA.1Hq', 'admin@admin.es', 'Chicago Bulls', 'admin.png', TRUE, 'admin', '623126742', 'Cuenta administradora para pruebas del TFG.', 0, 0, 10, '2024-01-01'),
('Usuario Demo', '$2a$12$HBi9mqAheugvoehw0QNzcOtSl11G.2qDFZcqlKetZ552mXsTA.1Hq', 'demo@hoopersoftware.es', 'Boston Celtics', 'default-avatar.png', TRUE, 'demo', '600000001', 'Cuenta de usuario para probar votaciones, perfil y chat.', 0, 0, 1, '2024-01-02');

INSERT INTO authorities(id, username, authority) VALUES
(1, 'admin', 'admin'),
(2, 'demo', 'usuario');

-- EQUIPOS
INSERT INTO equipo(id_equipo, nombre_equipo, ciudad, conferencia, division, ano_fundacion, anos_nba, titulos_nba, titulos_conferencia, partidos_ganados, partidos_perdidos, balance_temporada, logo_equipo, posicion, estadio, siglas, dorsales_retirados) VALUES
(1, 'Boston Celtics', 'Boston', 'Este', 'Atlantico', 1946, 78, 18, 23, 64, 18, 46.0, 'fake-data', 1, 'TD Garden', 'BOS', '6, 17, 33, 34'),
(2, 'Brooklyn Nets', 'Brooklyn', 'Este', 'Atlantico', 1967, 57, 0, 2, 32, 50, -18.0, 'fake-data', 11, 'Barclays Center', 'BKN', '3, 5, 23'),
(3, 'New York Knicks', 'New York', 'Este', 'Atlantico', 1946, 78, 2, 8, 50, 32, 18.0, 'fake-data', 4, 'Madison Square Garden', 'NYK', '10, 15, 33'),
(4, 'Philadelphia 76ers', 'Philadelphia', 'Este', 'Atlantico', 1946, 78, 3, 9, 47, 35, 12.0, 'fake-data', 7, 'Wells Fargo Center', 'PHI', '2, 3, 6, 13'),
(5, 'Toronto Raptors', 'Toronto', 'Este', 'Atlantico', 1995, 29, 1, 1, 25, 57, -32.0, 'fake-data', 12, 'Scotiabank Arena', 'TOR', '15'),
(6, 'Chicago Bulls', 'Chicago', 'Este', 'Central', 1966, 58, 6, 6, 39, 43, -4.0, 'fake-data', 9, 'United Center', 'CHI', '23, 33'),
(7, 'Cleveland Cavaliers', 'Cleveland', 'Este', 'Central', 1970, 54, 1, 5, 48, 34, 14.0, 'fake-data', 6, 'Rocket Mortgage FieldHouse', 'CLE', '7, 22'),
(8, 'Detroit Pistons', 'Detroit', 'Este', 'Central', 1941, 78, 3, 5, 14, 68, -54.0, 'fake-data', 15, 'Little Caesars Arena', 'DET', '1, 4, 11'),
(9, 'Indiana Pacers', 'Indianapolis', 'Este', 'Central', 1967, 57, 0, 1, 47, 35, 12.0, 'fake-data', 8, 'Gainbridge Fieldhouse', 'IND', '30, 31'),
(10, 'Milwaukee Bucks', 'Milwaukee', 'Este', 'Central', 1968, 56, 2, 3, 49, 33, 16.0, 'fake-data', 5, 'Fiserv Forum', 'MIL', '1, 33'),
(11, 'Atlanta Hawks', 'Atlanta', 'Este', 'Sureste', 1946, 78, 1, 1, 36, 46, -10.0, 'fake-data', 10, 'State Farm Arena', 'ATL', '9, 21, 55'),
(12, 'Charlotte Hornets', 'Charlotte', 'Este', 'Sureste', 1988, 36, 0, 0, 21, 61, -40.0, 'fake-data', 14, 'Spectrum Center', 'CHA', '13'),
(13, 'Miami Heat', 'Miami', 'Este', 'Sureste', 1988, 36, 3, 7, 46, 36, 10.0, 'fake-data', 8, 'Kaseya Center', 'MIA', '1, 3, 10, 32'),
(14, 'Orlando Magic', 'Orlando', 'Este', 'Sureste', 1989, 35, 0, 2, 47, 35, 12.0, 'fake-data', 7, 'Kia Center', 'ORL', '6'),
(15, 'Washington Wizards', 'Washington', 'Este', 'Sureste', 1961, 63, 1, 4, 15, 67, -52.0, 'fake-data', 15, 'Capital One Arena', 'WAS', '10, 11, 25'),
(16, 'Denver Nuggets', 'Denver', 'Oeste', 'Noroeste', 1967, 57, 1, 1, 57, 25, 32.0, 'fake-data', 2, 'Ball Arena', 'DEN', '2, 12, 33'),
(17, 'Minnesota Timberwolves', 'Minneapolis', 'Oeste', 'Noroeste', 1989, 35, 0, 0, 56, 26, 30.0, 'fake-data', 3, 'Target Center', 'MIN', '2'),
(18, 'Oklahoma City Thunder', 'Oklahoma City', 'Oeste', 'Noroeste', 2008, 16, 0, 1, 57, 25, 32.0, 'fake-data', 1, 'Paycom Center', 'OKC', '4'),
(19, 'Portland Trail Blazers', 'Portland', 'Oeste', 'Noroeste', 1970, 54, 1, 3, 21, 61, -40.0, 'fake-data', 14, 'Moda Center', 'POR', '1, 22, 32'),
(20, 'Utah Jazz', 'Salt Lake City', 'Oeste', 'Noroeste', 1974, 50, 0, 2, 31, 51, -20.0, 'fake-data', 12, 'Delta Center', 'UTA', '12, 32, 53'),
(21, 'Golden State Warriors', 'San Francisco', 'Oeste', 'Pacifico', 1946, 78, 7, 12, 46, 36, 10.0, 'fake-data', 10, 'Chase Center', 'GSW', '13, 14, 24'),
(22, 'Los Angeles Clippers', 'Los Angeles', 'Oeste', 'Pacifico', 1970, 54, 0, 0, 51, 31, 20.0, 'fake-data', 5, 'Intuit Dome', 'LAC', '32'),
(23, 'Los Angeles Lakers', 'Los Angeles', 'Oeste', 'Pacifico', 1947, 77, 17, 32, 47, 35, 12.0, 'fake-data', 8, 'Crypto.com Arena', 'LAL', '8, 24, 32, 33'),
(24, 'Phoenix Suns', 'Phoenix', 'Oeste', 'Pacifico', 1968, 56, 0, 3, 49, 33, 16.0, 'fake-data', 6, 'Footprint Center', 'PHX', '5, 6, 7, 13'),
(25, 'Sacramento Kings', 'Sacramento', 'Oeste', 'Pacifico', 1923, 78, 1, 1, 46, 36, 10.0, 'fake-data', 9, 'Golden 1 Center', 'SAC', '1, 2, 4'),
(26, 'Dallas Mavericks', 'Dallas', 'Oeste', 'Suroeste', 1980, 44, 1, 2, 50, 32, 18.0, 'fake-data', 4, 'American Airlines Center', 'DAL', '12, 15, 22, 41'),
(27, 'Houston Rockets', 'Houston', 'Oeste', 'Suroeste', 1967, 57, 2, 4, 41, 41, 0.0, 'fake-data', 11, 'Toyota Center', 'HOU', '11, 22, 34, 45'),
(28, 'Memphis Grizzlies', 'Memphis', 'Oeste', 'Suroeste', 1995, 29, 0, 0, 27, 55, -28.0, 'fake-data', 13, 'FedExForum', 'MEM', '9, 33, 50'),
(29, 'New Orleans Pelicans', 'New Orleans', 'Oeste', 'Suroeste', 2002, 22, 0, 0, 49, 33, 16.0, 'fake-data', 7, 'Smoothie King Center', 'NOP', '7'),
(30, 'San Antonio Spurs', 'San Antonio', 'Oeste', 'Suroeste', 1967, 57, 5, 6, 22, 60, -38.0, 'fake-data', 15, 'Frost Bank Center', 'SAS', '6, 9, 20, 21');

-- JUGADORES Y ESTADISTICAS
INSERT INTO estadisticas_jugador(id_est_jugador, puntos_totales, asistencias_totales, rebotes_totales, tapones_totales, robos_totales, partidos_jugados_jug, partidos_ganados_jug, partidos_perdidos_jug, triples_anotados, tiros_libres_anotados, tiros_de_campo_anotados, minutos_totales, titulos_ganado_nba_jug, titulos_perdidos_nba_jug, titulos_ganado_conferencia_jug, titulos_perdidos_conferencia_jug) VALUES
(-101, 27409, 1796, 16212, 1733, 1089, 1329, 820, 509, 8, 9018, 9435, 45071, 1, 2, 3, 2),
(-102, 32292, 5633, 6672, 893, 2514, 1072, 706, 366, 581, 7327, 12192, 41011, 6, 0, 6, 0),
(-103, 33643, 6306, 7047, 640, 1944, 1346, 836, 510, 1827, 8378, 11719, 48643, 5, 2, 7, 1),
(-104, 23668, 6119, 4509, 236, 1473, 956, 618, 338, 3747, 4047, 8180, 34254, 4, 2, 6, 2),
(-105, 19143, 3910, 7958, 557, 1210, 1250, 780, 470, 557, 5560, 7265, 38234, 1, 1, 3, 2),
(-106, 14218, 4667, 7219, 491, 822, 675, 442, 233, 640, 2794, 5412, 21142, 1, 0, 1, 0),
(-107, 12071, 1934, 5115, 941, 735, 596, 372, 224, 471, 4312, 3952, 18580, 0, 1, 1, 1),
(-108, 11852, 2410, 3740, 521, 685, 704, 418, 286, 1236, 2910, 4115, 20504, 0, 0, 1, 0),
(-109, 28924, 4645, 7454, 941, 1120, 1061, 711, 350, 2090, 7175, 10243, 37723, 2, 2, 4, 2),
(-110, 12890, 3681, 3860, 321, 871, 742, 438, 304, 1201, 3022, 4510, 22902, 0, 0, 1, 0),
(-111, 40474, 11009, 11185, 1111, 2275, 1492, 965, 527, 2410, 8836, 15000, 56597, 4, 6, 10, 1),
(-112, 10388, 1690, 3318, 366, 756, 611, 358, 253, 956, 2140, 4072, 17888, 0, 0, 0, 0);

INSERT INTO jugador(id_jugador, nombre_jugador, posicion, dorsal, retirado, hall_of_fame, universidad, pais_nacimiento, ciudad_nacimiento, altura_jug, peso_jug, trayectoria_jug, ano_draft, edad_jug, anos_all_star_jug, anos_nba_jug, anos_otra_liga_jug, temporada_jugador, foto_jugador, estadisticas_jug, id_equipo) VALUES
(-101, 'Moses Malone', 'Pivot', 2, TRUE, TRUE, 'Petersburg High School', 'Estados Unidos', 'Petersburg', '2.08 m', '118 kg', 'Houston Rockets, Philadelphia 76ers, Atlanta Hawks', 1974, 49, 12, 21, 2, '2023-2024', 'fake-data', -101, 1),
(-102, 'Michael Jordan', 'Escolta', 23, TRUE, TRUE, 'North Carolina', 'Estados Unidos', 'Brooklyn', '1.98 m', '98 kg', 'Chicago Bulls, Washington Wizards', 1984, 61, 14, 15, 0, '2023-2024', 'fake-data', -102, 6),
(-103, 'Kobe Bryant', 'Escolta', 24, TRUE, TRUE, 'Lower Merion', 'Estados Unidos', 'Philadelphia', '1.98 m', '96 kg', 'Los Angeles Lakers', 1996, 41, 18, 20, 0, '2023-2024', 'fake-data', -103, 23),
(-104, 'Stephen Curry', 'Base', 30, FALSE, TRUE, 'Davidson', 'Estados Unidos', 'Akron', '1.88 m', '84 kg', 'Golden State Warriors', 2009, 36, 10, 15, 0, '2023-2024', 'fake-data', -104, 21),
(-105, 'Kevin Garnett', 'Ala-pivot', 21, TRUE, TRUE, 'Farragut Academy', 'Estados Unidos', 'Greenville', '2.11 m', '109 kg', 'Minnesota Timberwolves, Boston Celtics, Brooklyn Nets', 1995, 48, 15, 21, 0, '2023-2024', 'fake-data', -105, 17),
(-106, 'Nikola Jokic', 'Pivot', 15, FALSE, TRUE, 'Mega Basket', 'Serbia', 'Sombor', '2.11 m', '129 kg', 'Denver Nuggets', 2014, 29, 6, 9, 0, '2023-2024', 'fake-data', -106, 16),
(-107, 'Joel Embiid', 'Pivot', 21, FALSE, FALSE, 'Kansas', 'Camerun', 'Yaounde', '2.13 m', '127 kg', 'Philadelphia 76ers', 2014, 30, 7, 8, 0, '2023-2024', 'fake-data', -107, 4),
(-108, 'Jayson Tatum', 'Alero', 0, FALSE, FALSE, 'Duke', 'Estados Unidos', 'St. Louis', '2.03 m', '95 kg', 'Boston Celtics', 2017, 26, 5, 7, 0, '2023-2024', 'fake-data', -108, 1),
(-109, 'Kevin Durant', 'Alero', 35, FALSE, TRUE, 'Texas', 'Estados Unidos', 'Washington', '2.08 m', '109 kg', 'Thunder, Warriors, Nets, Suns', 2007, 35, 14, 16, 0, '2023-2024', 'fake-data', -109, 24),
(-110, 'Luka Doncic', 'Base', 77, FALSE, FALSE, 'Real Madrid', 'Eslovenia', 'Ljubljana', '2.01 m', '104 kg', 'Dallas Mavericks', 2018, 25, 5, 6, 3, '2023-2024', 'fake-data', -110, 26),
(-111, 'LeBron James', 'Alero', 23, FALSE, TRUE, 'St. Vincent-St. Mary', 'Estados Unidos', 'Akron', '2.06 m', '113 kg', 'Cavaliers, Heat, Lakers', 2003, 39, 20, 21, 0, '2023-2024', 'fake-data', -111, 23),
(-112, 'Anthony Edwards', 'Escolta', 5, FALSE, FALSE, 'Georgia', 'Estados Unidos', 'Atlanta', '1.93 m', '102 kg', 'Minnesota Timberwolves', 2020, 22, 2, 4, 0, '2023-2024', 'fake-data', -112, 17);

-- ENTRENADORES
INSERT INTO estadisticas_entrenador(id_est_entrenador, partidos_jugados_entr, partidos_ganados_entr, partidos_perdidos_entr, titulos_ganado_nba_entr, titulos_perdidos_nba_entr, titulos_ganado_conferencia_entr, titulos_perdidos_conferencia_entr) VALUES
(-201, 1820, 1190, 630, 6, 1, 9, 2),
(-202, 902, 520, 382, 1, 0, 1, 0),
(-203, 820, 475, 345, 0, 1, 1, 1),
(-204, 615, 390, 225, 1, 0, 1, 0),
(-205, 1300, 755, 545, 0, 1, 2, 1),
(-206, 700, 415, 285, 0, 0, 0, 0);

INSERT INTO entrenador(id_entrenador, nombe_entrenador, equipo_entr, trayectoria_entr, edad_entr, anos_nba_entr, anos_otras_ligas_entr, anos_all_star_entr, a_sido_jugador, foto_entrenador, estadisticas_entr, id_equipo) VALUES
(-201, 'Phil Jackson', 'Chicago Bulls', 'Chicago Bulls, Los Angeles Lakers', 78, 20, 0, 4, TRUE, 'fake-data', -201, 6),
(-202, 'Steve Kerr', 'Golden State Warriors', 'Golden State Warriors', 58, 10, 0, 2, TRUE, 'fake-data', -202, 21),
(-203, 'Erik Spoelstra', 'Miami Heat', 'Miami Heat', 53, 16, 0, 2, FALSE, 'fake-data', -203, 13),
(-204, 'Michael Malone', 'Denver Nuggets', 'Sacramento Kings, Denver Nuggets', 52, 11, 0, 1, FALSE, 'fake-data', -204, 16),
(-205, 'Doc Rivers', 'Milwaukee Bucks', 'Magic, Celtics, Clippers, 76ers, Bucks', 62, 25, 0, 3, TRUE, 'fake-data', -205, 10),
(-206, 'Joe Mazzulla', 'Boston Celtics', 'Boston Celtics', 35, 2, 0, 1, FALSE, 'fake-data', -206, 1);

-- TEMPORADAS, JORNADAS Y PLAYOFFS
INSERT INTO temporada(id_temporada, anos_temporada, campeon_temporada, mvp_temporada, rookie_temporada, defensor_temporada, sexto_hombre_temporada, jugador_mas_mejorado_temporada, entrenador_temporada, campeon_oeste_temp, campeon_este_temp, campeon_nba_temp) VALUES
(-301, '2023-2024', 'Boston Celtics', 'Nikola Jokic', 'Victor Wembanyama', 'Rudy Gobert', 'Naz Reid', 'Tyrese Maxey', 'Mark Daigneault', 'Dallas Mavericks', 'Boston Celtics', 'Boston Celtics'),
(-302, '2022-2023', 'Denver Nuggets', 'Joel Embiid', 'Paolo Banchero', 'Jaren Jackson Jr.', 'Malcolm Brogdon', 'Lauri Markkanen', 'Mike Brown', 'Denver Nuggets', 'Miami Heat', 'Denver Nuggets'),
(-303, '1995-1996', 'Chicago Bulls', 'Michael Jordan', 'Damon Stoudamire', 'Gary Payton', 'Toni Kukoc', 'Gheorghe Muresan', 'Phil Jackson', 'Utah Jazz', 'Chicago Bulls', 'Chicago Bulls');

INSERT INTO playoff(id_play_off, temporada, oeste, este, campeones_cuartos_oeste, campeones_semis_oeste, campeon_final_oeste, campeones_cuartos_este, campeones_semis_este, campeon_final_este, campeon_final_nba) VALUES
(-401, '2023-2024', 'Thunder, Nuggets, Timberwolves, Mavericks', 'Celtics, Knicks, Pacers, Bucks', 'Timberwolves, Mavericks', 'Mavericks', 'Dallas Mavericks', 'Celtics, Pacers', 'Celtics', 'Boston Celtics', 'Boston Celtics'),
(-402, '2022-2023', 'Nuggets, Suns, Warriors, Lakers', 'Bucks, Heat, Celtics, 76ers', 'Nuggets, Lakers', 'Nuggets', 'Denver Nuggets', 'Heat, Celtics', 'Heat', 'Miami Heat', 'Denver Nuggets'),
(-403, '1995-1996', 'Jazz, Rockets, Spurs, Lakers', 'Bulls, Knicks, Magic, Hawks', 'Jazz, Rockets', 'Jazz', 'Utah Jazz', 'Bulls, Magic', 'Bulls', 'Chicago Bulls', 'Chicago Bulls');

INSERT INTO jornada(id_jornada, temporada, fecha_jornada, num_jornada, numero_partido, partido_cancelado, play_off) VALUES
(-501, '2023-2024', '2024-01-12', 12, 4, FALSE, FALSE),
(-502, '2023-2024', '2024-06-06', 1, 1, FALSE, TRUE),
(-503, '2022-2023', '2023-06-12', 5, 1, FALSE, TRUE);

INSERT INTO clasificacion(temporada, primero_este, segundo_este, tercero_este, cuarto_este, quinto_este, sexto_este, septimo_este, octavo_este, primero_oeste, segundo_oeste, tercero_oeste, cuarto_oeste, quinto_oeste, sexto_oeste, septimo_oeste, octavo_oeste) VALUES
('2023-2024', 'Boston Celtics', 'New York Knicks', 'Milwaukee Bucks', 'Cleveland Cavaliers', 'Orlando Magic', 'Indiana Pacers', 'Philadelphia 76ers', 'Miami Heat', 'Oklahoma City Thunder', 'Denver Nuggets', 'Minnesota Timberwolves', 'Los Angeles Clippers', 'Dallas Mavericks', 'Phoenix Suns', 'Los Angeles Lakers', 'New Orleans Pelicans');

-- PARTIDOS
INSERT INTO partido(id_partido, resultadoc1, resultadoc2, resultadoc3, resultadoc4, resultado_total, prorroga, resultado_prorroga, play_off_siono, temporada, victoria_serie, equipo_local, equipo_visitante, id_play_off, fecha, ganador, equipo_local_ta, equipo_visitante_ta) VALUES
(-601, '31-25', '28-27', '30-24', '24-26', '113-102', FALSE, NULL, FALSE, '2023-2024', NULL, 'Boston Celtics', 'Chicago Bulls', NULL, '2024-01-12', 'Boston Celtics', 1, 6),
(-602, '29-30', '27-24', '26-28', '31-25', '113-107', FALSE, NULL, FALSE, '2023-2024', NULL, 'Golden State Warriors', 'Los Angeles Lakers', NULL, '2024-02-03', 'Golden State Warriors', 21, 23),
(-603, '26-26', '31-29', '24-28', '33-30', '114-113', FALSE, NULL, FALSE, '2023-2024', NULL, 'Dallas Mavericks', 'Denver Nuggets', NULL, '2024-03-17', 'Dallas Mavericks', 26, 16),
(-604, '27-25', '25-31', '28-27', '26-29', '106-112', FALSE, NULL, FALSE, '2023-2024', NULL, 'Phoenix Suns', 'Minnesota Timberwolves', NULL, '2024-04-05', 'Minnesota Timberwolves', 24, 17),
(-605, '37-20', '26-22', '23-24', '21-23', '107-89', FALSE, NULL, TRUE, '2023-2024', '1-0', 'Boston Celtics', 'Dallas Mavericks', -401, '2024-06-06', 'Boston Celtics', 1, 26),
(-606, '25-28', '26-23', '34-19', '22-18', '107-88', FALSE, NULL, TRUE, '2023-2024', '2-0', 'Boston Celtics', 'Dallas Mavericks', -401, '2024-06-09', 'Boston Celtics', 1, 26),
(-607, '24-22', '26-29', '30-26', '29-17', '109-94', FALSE, NULL, TRUE, '2022-2023', '4-1', 'Denver Nuggets', 'Miami Heat', -402, '2023-06-12', 'Denver Nuggets', 16, 13),
(-608, '25-27', '30-23', '28-24', '24-22', '107-96', FALSE, NULL, TRUE, '1995-1996', '4-2', 'Chicago Bulls', 'Utah Jazz', -403, '1996-06-16', 'Chicago Bulls', 6, 20);

INSERT INTO temporada_jornadas(temporada_id_temporada, jornadas_id_jornada) VALUES
(-301, -501),
(-301, -502),
(-302, -503);

INSERT INTO jornada_partidos(jornada_id_jornada, partidos_id_partido) VALUES
(-501, -601),
(-502, -605),
(-503, -607);

INSERT INTO playoff_equipos(equipos_id_equipo, playoff_id_play_off) VALUES
(1, -401), (26, -401), (18, -401), (17, -401), (16, -401), (23, -401), (10, -401), (9, -401),
(16, -402), (13, -402), (1, -402), (23, -402),
(6, -403), (20, -403), (27, -403), (30, -403);

-- TRANSFERENCIAS
INSERT INTO transferencia(id_transferencia, precio, ronda_draft, fecha, equipo_origen, equipo_destino, info_ronda_draft, equipo_origen_string, equipo_destino_string) VALUES
(-701, 0, TRUE, '2024-02-08', 1, 19, 'Primera ronda protegida y dos segundas rondas', 'Boston Celtics', 'Portland Trail Blazers'),
(-702, 32000000, FALSE, '2024-01-15', 23, 26, 'Traspaso simulado para probar filtros y detalle', 'Los Angeles Lakers', 'Dallas Mavericks'),
(-703, 0, TRUE, '2023-07-01', 17, 21, 'Intercambio de pick y jugador de rotacion', 'Minnesota Timberwolves', 'Golden State Warriors');

-- VOTACIONES
INSERT INTO votacion(id_votacion, ganador, duracion_votacion, categotia_votacion, opciones_votacion, en_curso, oficial, temporada, jornada, fecha, total_votos) VALUES
(-801, '', 7, 2, 'Nikola Jokic, Luka Doncic, Jayson Tatum', TRUE, TRUE, '2023-2024', 'All Season', '2024-04-15', 0),
(-802, 'Victor Wembanyama', 7, 1, 'Victor Wembanyama, Chet Holmgren, Brandon Miller', FALSE, TRUE, '2023-2024', 'All Season', '2024-04-15', 18),
(-803, 'Naz Reid', 5, 3, 'Naz Reid, Malik Monk, Bobby Portis', FALSE, TRUE, '2023-2024', 'All Season', '2024-04-15', 11),
(-804, '', 3, 27, 'Anthony Edwards, Ja Morant, Zion Williamson', TRUE, FALSE, '2023-2024', 'Jornada 22', '2024-02-20', 4);

-- CHAT
INSERT INTO mensaje_chat(id, username, mensaje, fecha) VALUES
(-901, 'admin', 'Mensaje fake para comprobar el chat global.', '2024-01-01T10:00:00');

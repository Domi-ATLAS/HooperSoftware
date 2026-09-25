package HooperSoftware.TFG.entidad;



public enum Categoria {
    jugadorCluchAno("Jugador clutch del año"),
    rookieAno("Rookie del año"),
    MVP("MVP"),
    sextoHombreDelAño("Sexto hombre del año"),
    jugadorMasMejorado("Jugador más mejorado"),
    jugadorHustle("Jugador hustle"),
    jugadorMes("Jugador del mes"),
    jugadorSemana("Jugador de la semana"),
    jugadorJornada("Jugador de la jornada"),
    defensorAno("Defensor del año"),
    defensorMes("Defensor del mes"),
    defensorSemana("Defensor de la semana"),
    defensorJornada("Defensor de la jornada"),
    atacanteAno("Atacante del año"),
    atacanteMes("Atacante del mes"),
    atacanteSemana("Atacante de la semana"),
    atacanteJornada("Atacante de la jornada"),
    dominadorAno("Dominador del año"),
    dominadorMes("Dominador del mes"),
    dominadorSemana("Dominador de la semana"),
    dominadorJornada("Dominador de la jornada"),
    entrenadorAno("Entrenador del año"),
    entrenadorMes("Entrenador del mes"),
    entrenadorSemana("Entrenador de la semana"),
    entrenadorJornada("Entrenador de la jornada"),
    dunkerAno("Dunker del año"),
    dunkerMes("Dunker del mes"),
    dunkerSemana("Dunker de la semana"),
    dunkerJornada("Dunker de la jornada"),
    tiradorAno("Tirador del año"),
    tiradorMes("Tirador del mes"),
    tiradorSemana("Tirador de la semana"),
    tiradorJornada("Tirador de la jornada");

    private final String displayName;

    Categoria(String displayName) {
        this.displayName = displayName;
    }

    public String getDisplayName() {
        return displayName;
    }
}


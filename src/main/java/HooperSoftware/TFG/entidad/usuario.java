package HooperSoftware.TFG.entidad;

import java.time.LocalDate;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@Entity
public class Usuario {

    String nombreUsuario;

    Integer numeroTelefono;

    String correo;

    String equipoFavorito;

    @Id
    String username;

    Boolean enabled;

    String password;

    String foto;

    String biografia;

    Integer mensajesEnviados;

    Integer votosEmitidos;

    Integer reputacion;

    LocalDate fechaRegistro;

    public void setFoto(String foto) {
        this.foto = foto;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public String getCorreo() {
        return correo;
    }

    public String getEquipoFavorito() {
        return equipoFavorito;
    }

    public Integer getNumeroTelefono() {
        return numeroTelefono;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setNumeroTelefono(Integer numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }

    public void setEquipoFavorito(String equipoFavorito) {
        this.equipoFavorito = equipoFavorito;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFoto() {
        return foto;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }

    public String getUsername() {
        return username;
    }

    public void setFechaRegistro(LocalDate fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public void setVotosEmitidos(Integer votosEmitidos) {
        this.votosEmitidos = votosEmitidos;
    }

    public void setMensajesEnviados(Integer mensajesEnviados) {
        this.mensajesEnviados = mensajesEnviados;
    }

    public LocalDate getFechaRegistro() {
        return fechaRegistro;
    }

    public Integer getVotosEmitidos() {
        return votosEmitidos;
    }

    public Integer getMensajesEnviados() {
        return mensajesEnviados;
    }

}

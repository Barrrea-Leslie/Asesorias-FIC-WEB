class UsuarioToken {
  final int id;
  final String usuario;
  final String nombreCompleto;
  final int idRol; // Lo puse como int porque abajo vi que le pusiste ?? 0

  // 1. El constructor que te hacía falta para registrar las variables
  UsuarioToken({
    required this.id,
    required this.usuario,
    required this.nombreCompleto,
    required this.idRol,
  });

  // 2. El constructor factory corregido con llaves bien cerradas
  factory UsuarioToken.fromJwt(Map<String, dynamic> json) {
    return UsuarioToken(
      id: json['id_usuario'] ?? 0,
      usuario: json['usuario'] ?? 'sin_usuario',
      nombreCompleto: json['nombre_completo'] ?? 'sin_nombre',
      idRol: json['id_rol'] ?? 0,
    );
  }
}
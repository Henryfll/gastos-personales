class Usuario {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> cuentas;
  final List<String> categorias;

  Usuario({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.cuentas,
    required this.categorias,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'cuentas': cuentas,
      'categorias': categorias,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      cuentas: List<String>.from(map['cuentas'] ?? []),
      categorias: List<String>.from(map['categorias'] ?? []),
    );
  }
}

class Usuario {
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String> cuentas;

  Usuario({
    required this.uid,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.cuentas,
  });


  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'cuentas': cuentas,
    };
  }


  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      cuentas: List<String>.from(map['cuentas'] ?? []),
    );
  }
}

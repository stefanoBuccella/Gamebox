class AuthUser {
  final String id;
  final String? email;

  AuthUser({
    required this.id,
    this.email,
  });

  factory AuthUser.fromSupabase(dynamic user) {
    return AuthUser(
      id: user.id,
      email: user.email,
    );
  }
}
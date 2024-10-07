class Otp {
  final String email;
  final String secret;
  final String issuer;

  Otp({
    required this.email,
    required this.secret,
    required this.issuer,
  });

  @override
  int get hashCode => secret.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Otp &&
      other.email == email &&
      other.secret == secret &&
      issuer == other.issuer;
}

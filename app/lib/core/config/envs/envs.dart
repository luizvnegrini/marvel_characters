class Envs {
  static get baseUrl => const String.fromEnvironment('BASE_URL');
  static get publicKey => const String.fromEnvironment('PUBLIC_KEY');
  static get privateKey => const String.fromEnvironment('PRIVATE_KEY');
}

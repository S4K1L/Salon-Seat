/// Masks local part after the first 4 characters, e.g. `abcd****@mail.com`.
String maskEmail(String email) {
  final at = email.indexOf('@');
  if (at <= 0 || at >= email.length - 1) return email;
  final local = email.substring(0, at);
  final domain = email.substring(at);
  if (local.length <= 4) {
    return '${local[0]}${'*' * (local.length - 1)}$domain';
  }
  return '${local.substring(0, 4)}${'*' * (local.length - 4)}$domain';
}

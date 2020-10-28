import 'dart:math';

class Utils{
  static String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AEFGHKMNPQRWXYZ1234679';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join()
        .toUpperCase();
  }
}
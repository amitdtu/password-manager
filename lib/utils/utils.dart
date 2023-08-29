import 'package:crypto/crypto.dart';
import 'dart:convert';

String createHash(String text) {
  var bytes = utf8.encode(text); // data being hashed

  var digest = sha256.convert(bytes);

  return digest.toString();
}

import 'dart:convert';

String encode(String value) {
  return base64.encode(utf8.encode(value));
}

String decode(String value) {
  return utf8.decode(base64.decode(value));
}

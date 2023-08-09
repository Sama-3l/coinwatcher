import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Crypt {
  String encodeToSha256(String input) {
    // Convert the input string to bytes
    List<int> bytes = utf8.encode(input);

    // Create a SHA-256 hash
    Digest digest = sha256.convert(bytes);

    // Convert the digest to a hexadecimal representation
    String encoded = digest.toString();

    return encoded;
  }
}

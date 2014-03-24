import 'package:unittest/unittest.dart';

import 'package:jwt/base64url.dart';

void main() {
  group("The Base64Url codec", () {
    final b64a = "Hello there, it works".codeUnits;
    final b64b = "Let's try to get a pad".codeUnits;

    test("encodes base64 strings", () {
      expect(Base64Url.encoder.convertFromBase64String("Adsd=+-//as"), equals("Adsd--__as"));
      expect(Base64Url.encode(b64a), equals("SGVsbG8gdGhlcmUsIGl0IHdvcmtz"));
      expect(Base64Url.encode(b64b), equals("TGV0J3MgdHJ5IHRvIGdldCBhIHBhZA"));
    });

    test("decodes base64 strings", () {
      expect(Base64Url.decoder.convertToBase64String("Adsd-__as"), equals("Adsd+//as==="));
      expect(Base64Url.decode(Base64Url.encode(b64a)), equals(b64a));
      expect(Base64Url.decode(Base64Url.encode(b64b)), equals(b64b));
    });
  });
}
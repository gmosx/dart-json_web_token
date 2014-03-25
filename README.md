JSON Web Token
==============

[JSON Web Token](http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html) 
(JWT) is a compact URL-safe means of representing claims to be 
transferred between two parties. The claims in a JWT are encoded as a 
JavaScript Object Notation (JSON) object that is used as the payload of a JSON 
Web Signature (JWS) structure or as the plaintext of a JSON Web Encryption 
(JWE) structure, enabling the claims to be digitally signed or MACed and/or 
encrypted.

The JWT spec is implemented as a standard Dart Codec.


Example usage
-------------

```dart
import 'package:jwt/json_web_token.dart';

// Encode (i.e. sign) a payload into a JWT token.

final jwt = new JsonWebTokenCodec(secret: "My secret key");
final payload = {
  'iss': 'joe',
  'exp': 1300819380,
  'http://example.com/is_root': true
};
final token = jwt.encode(payload);

// Validate a token.

jwt.isValid(token);

// Decode (i.e. extract) the payload from a JWT token.

final payload = jwt.decode(token);
```


Status
------

The API is not stable. The intend is to strictly follow Dart conventions, i.e.
make the API as 'dartish' as possible while maintaining simplicity. We are
open to any suggestions towards that goal.


Links
-----

* [JSON Web Token](http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html)
* [JSON Web Algorithms](https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-24)
* [Using OAuth 2.0 for Server to Server Applications](https://developers.google.com/accounts/docs/OAuth2ServiceAccount)


Credits
-------

Copyright (c) 2014 George Moschovitis <george.moschovitis@gmail.com>.

/**
 * [JSON Web Token spec](http://self-issued.info/docs/draft-ietf-oauth-json-web-token.html)
 */
library json_web_token;

import 'jws.dart' as jws;

/**
 *
 */
String sign(payload, String secret) {
  final header = {
    'typ': 'JWT',
    'alg': 'HS256'
  };

  return jws.sign(header, payload, secret);
}

///**
// *
// */
//Map verify(String token, String secret) {
//  return jws.verify(token, secret);
//}
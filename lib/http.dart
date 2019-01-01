import "package:http/http.dart" as http;
import "dart:convert" as convert;

const BASE = 'https://api.binance.com';

class BinanceHttp {
  final String key;

  BinanceHttp([this.key]);

  Future<Map> _public(String path) =>
      http.get("$BASE/api/$path").then((r) => convert.jsonDecode(r.body));

  /// Return true if the server is available
  Future<bool> ping() =>
      _public('/v1/ping').then((r) => true).catchError((r) => false);

  /// Return the current server time
  Future<DateTime> time() => _public('/v1/time')
      .then((r) => DateTime.fromMillisecondsSinceEpoch(r["serverTime"]));
}

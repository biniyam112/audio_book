import 'package:http/http.dart' as http;

class AmolePaymentDP {
  final http.Client client;

  AmolePaymentDP({required this.client});

  Future<void> commitPurchase() async {
    var response = await client.post(
      Uri.parse('http://api.marakigebeya.com.et/api/amole/recieve/SendOTP'),
      body: {
        "pin": "9999",
        "phoneNumber": "+251911602370",
        "amount": 0,
        "orderDescription": "sample"
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

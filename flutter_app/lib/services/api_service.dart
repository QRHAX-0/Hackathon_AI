import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ApiService {
  static Future<List<Product>> fetchProducts() async {
    try {
      String? localIp = await getLocalIP(); // جلب IP الديناميكي
      if (localIp == null) throw Exception("لا يمكن الحصول على IP الجهاز");

      final response = await http.get(
        Uri.parse(
          "http://192.168.1.10:3000/products/",
        ), // استخدام IP الديناميكي
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        for (var item in data) {
          print("Product Image: ${item['image']}");
        }
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  // دالة جلب IP المحلي
  static Future<String?> getLocalIP() async {
    for (var interface in await NetworkInterface.list()) {
      for (var addr in interface.addresses) {
        if (addr.type == InternetAddressType.IPv4) {
          return addr.address;
        }
      }
    }
    return null;
  }
}

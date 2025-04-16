// controllers/product_controller.dart
import '../models/product.dart';
import '../services/file_service.dart';

class ProductController {
  final String fileName = 'products';
  List<Product> products = [];

  Future<void> loadProducts() async {
    final data = await FileService.readData(fileName);
    products = data.map((json) => Product.fromJson(json)).toList();
  }

  Future<void> saveProducts() async {
    await FileService.saveData(fileName, products.map((p) => p.toJson()).toList());
  }

  Future<void> addProduct(Product product) async {
    products.add(product);
    await saveProducts();
  }

  Future<void> updateProduct(Product product) async {
    final index = products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      products[index] = product;
      await saveProducts();
    }
  }

  Future<void> deleteProduct(int id) async {
    products.removeWhere((p) => p.id == id);
    await saveProducts();
  }
}

// First step to create a service to fetch all products from the API
// لجلب كل المنتجات من ال API
import 'package:scholar_store_app/helper/api.dart';
import 'package:scholar_store_app/models/product_model.dart';

class AllProductService {
  // This class would contain methods to fetch all products

  Future<List<ProductModel>> getAllProducts() async {
    // Implementation to fetch products from the API
    // http.Response response = await http.get(Uri.parse('$_baseUrl/products'));
    List<dynamic> data =await Api().getRequest(endpoint: '/products');
      List<ProductModel> products = [];
      for (int i = 0; i < data.length; i++) {
        products.add(ProductModel.fromJson(data[i]));
      }
      return products;
  }
}

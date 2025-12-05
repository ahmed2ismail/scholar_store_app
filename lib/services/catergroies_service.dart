// third step to create a service to fetch products by category from the API
// خدمة جلب المنتجات حسب فئة معينة من ال API
import 'package:scholar_store_app/helper/api.dart';
import 'package:scholar_store_app/models/product_model.dart';

class CatergroiesService {
  Future<List<ProductModel>> getCategoriesProduct({
    required String categoryName,
  }) async {
    List<dynamic> data =await Api().getRequest(endpoint: '/products/category/$categoryName');
    // http.Response response = await http.get(
      // Uri.parse('$_baseUrl/products/category/$categoryName'),
    // );
      List<ProductModel> products = [];
      for (int i = 0; i < data.length; i++) {
        products.add(ProductModel.fromJson(data[i]));
      }
      return products;
    }
  }

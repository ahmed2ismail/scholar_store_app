// second step to create a service to fetch all categories from the API
// خدمة جلب كل الفئات من ال API
import 'package:scholar_store_app/helper/api.dart';
import 'package:scholar_store_app/models/product_model.dart';

class AllCategoriesService {
  Future<List<dynamic>> getAllCategories() async {
    // Implementation to fetch categories from the API
    // خدمة لجلب قائمة بأسماء كل الفئات
    // http.Response response = await http.get(
    // Uri.parse('$_baseUrl/products/categories'),
    // );
    List<dynamic> data = await Api().getRequest(
      endpoint: '/products/categories',
    );
    return data;
  }

  // خدمة لجلب كل المنتجات التي تنتمي لفئة معينة
  Future<List<ProductModel>> getProductsByCategory({required String categoryName,}) async {
    List<dynamic> data = await Api().getRequest(
      endpoint: '/products/category/$categoryName',
    );

    List<ProductModel> categoryProductsList = [];
    for (int i = 0; i < data.length; i++) {
      categoryProductsList.add(ProductModel.fromJson(data[i]));
    }
    return categoryProductsList;
  }
}
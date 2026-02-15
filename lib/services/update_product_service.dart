// Service to update a product in the API
// لتحديث منتج معين.
import 'package:scholar_store_app/helper/api.dart';
import 'package:scholar_store_app/models/product_model.dart';

class UpdateProductService {
  Future<ProductModel> updateProduct({
    required int id,
    required String title,
    required String price,
    required String desc,
    required String image,
    required String category,
  }) async {
    dynamic data = await Api().putRequest(
      endpoint: '/products/$id',
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category,
      },
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    // print('Update response data: $data'); // Debug print to check the response data
    return ProductModel.fromJson(data);
  }
}
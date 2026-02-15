// fourth step to create a service to add a product to the API
// خدمة إضافة منتج جديد إلى ال API
import 'dart:developer';

import 'package:scholar_store_app/helper/api.dart';
import 'package:scholar_store_app/models/product_model.dart';

class AddProductService {
  Future<ProductModel> addProduct({
    required String title,
    required String price,
    required String desc,
    required String image,
    required String category,
  }) async {
    // استدعاء دالة postRequest لإرسال البيانات إلى ال API
    dynamic data = await Api().postRequest(
      endpoint: '/products',
      body: {
        'title': title,
        'price': price,
        'description': desc,
        'image': image,
        'category': category,
      },
      // headers: {
        // 'Accept': 'application/json',
        // 'Content-Type': 'application/x-www-form-urlencoded',
      // },
    );
    log('Product added successfully: ${data['title']}');
    // تحويل الاستجابة القادمة من الـ API إلى ProductModel
    return ProductModel.fromJson(data);
  }
}

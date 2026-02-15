import 'package:scholar_store_app/models/product_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {} // البداية خالص

class ProductsLoading extends ProductsState {} // بنحمل..

class ProductsSuccess extends ProductsState {
  final List<ProductModel> products; // هنا بنشيل البيانات اللي رجعت
  ProductsSuccess({required this.products});
}
class ProductsFailure extends ProductsState {
  final String errorMessage; // هنا بنشيل رسالة الخطأ
  ProductsFailure({required this.errorMessage});
}
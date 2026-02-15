import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_store_app/services/all_product_service.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  // الدالة دي هي اللي هتنادي الـ API
  void fetchAllProducts() async {
    emit(ProductsLoading()); // 1. قولي للشاشة تظهر علامة التحميل
    try {
      // 2. نادي الخدمة اللي بتجيب البيانات
      var products = await AllProductService().getAllProducts(); 
      emit(ProductsSuccess(products: products)); // 3. قولي للشاشة البيانات جت اهي
    } catch (e) {
      emit(ProductsFailure(errorMessage: e.toString())); // 4. قولي للشاشة حصل مشكلة
    }
  }
}
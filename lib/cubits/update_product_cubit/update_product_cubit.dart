import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scholar_store_app/models/product_model.dart';
import 'package:scholar_store_app/services/update_product_service.dart';

part 'update_product_state.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {
  UpdateProductCubit() : super(UpdateProductInitial());

  void updateProduct({required ProductModel product, String? description, String? image, String? price, String? productName}) async {
    // هنا هنادي ال API بتاعت ال update
    emit(UpdateProductLoading()); // 1. قولي للشاشة تظهر علامة التحميل
    try {
      // 2. نادي الخدمة اللي بتعمل ال update
      // لو ال update نجحت
    await UpdateProductService().updateProduct(
      id: product.id,
      title: productName ?? product.title,
      desc: description ?? product.description,
      price: price ?? product.price.toString(),
      image: image ?? product.image,
      category: product.category,
    );
      emit(UpdateProductSuccess(product: product)); // 3. قولي للشاشة ال update نجحت
    } catch (e) {
      emit(UpdateProductFailure(errorMessage: e.toString())); // 4. قولي للشاشة حصل مشكلة
    }
  }
}

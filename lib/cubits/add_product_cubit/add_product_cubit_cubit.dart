import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:scholar_store_app/services/add_product_service.dart';

part 'add_product_cubit_state.dart';

class AddProductCubit extends Cubit<AddProductCubitState> {
  AddProductCubit() : super(AddProductCubitInitial());

  void addProduct({required String name, required String price, required String desc, required String image, required String category}) async {
    emit(AddProductCubitLoading()); // بنقول للشاشة إني ببدأ عملية الإضافة
    try {
      // بننادي الخدمة اللي بتعمل الـ POST
      await AddProductService().addProduct(
        title: name,
        price: price,
        desc: desc,
        image: image,
        category: category,
      );
      emit(AddProductCubitSuccess()); // بنقول للشاشة تمت الإضافة بنجاح
    } catch (e) {
      emit(AddProductCubitFailure(errorMessage: e.toString())); // حصلت مشكلة في الـ API
    }
  }
}
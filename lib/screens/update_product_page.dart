import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_store_app/cubits/update_product_cubit/update_product_cubit.dart';
import 'package:scholar_store_app/models/product_model.dart';
import 'package:scholar_store_app/widgets/custom_button.dart';
import 'package:scholar_store_app/widgets/custom_textformfield.dart';

class UpdateProductPage extends StatelessWidget {
  UpdateProductPage({super.key}); // شيلنا الـ const لأننا هنعرف متغيرات
  static String id = 'product_details';

  // المتغيرات دي بنعرفها هنا عشان نخزن فيها القيم اللي المستخدم بيكتبها
  String? productName, description, image, price;

  @override
  Widget build(BuildContext context) {
    // استلام البيانات من الـ Route
    ProductModel product = ModalRoute.of(context)!.settings.arguments as ProductModel;

    return BlocProvider(
      create: (context) => UpdateProductCubit(),
      child: BlocConsumer<UpdateProductCubit, UpdateProductState>(
        listener: (context, state) {
          if (state is UpdateProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product updated successfully')),
            );
            Navigator.pop(context); 
          } else if (state is UpdateProductFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            // الـ Cubit بيتحكم في ظهور علامة التحميل
            inAsyncCall: state is UpdateProductLoading,
            child: Scaffold(
              appBar: AppBar(
                title: const Text('Update Product', style: TextStyle(color: Colors.black)),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: const IconThemeData(color: Colors.black),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      CustomTextField(
                        hintText: 'Product Name',
                        onChanged: (data) => productName = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Description',
                        onChanged: (data) => description = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Price',
                        keyboardType: TextInputType.number,
                        onChanged: (data) => price = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Image',
                        onChanged: (data) => image = data,
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        text: 'Update',
                        onTap: () {
                          // مناداة الـ Cubit مباشرة بدون دالة وسيطة في الصفحة
                          BlocProvider.of<UpdateProductCubit>(context).updateProduct(
                            product: product,
                            productName: productName,
                            description: description,
                            price: price,
                            image: image,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
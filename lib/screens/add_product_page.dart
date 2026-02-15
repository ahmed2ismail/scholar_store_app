import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_store_app/cubits/add_product_cubit/add_product_cubit_cubit.dart';
import 'package:scholar_store_app/widgets/custom_button.dart';
import 'package:scholar_store_app/widgets/custom_textformfield.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});
  static String id = 'add_product';

  // متغيرات لتخزين اللي المستخدم هيكتبه
  String? name, price, desc, image, category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(),
      child: BlocConsumer<AddProductCubit, AddProductCubitState>(
        listener: (context, state) {
          if (state is AddProductCubitSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product Added Successfully!')),
            );
            Navigator.pop(context); // ارجع للرئيسية بعد النجاح
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: state is AddProductCubitLoading,
            child: Scaffold(
              appBar: AppBar(title: const Text('Add New Product')),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 50),
                      CustomTextField(
                        hintText: 'Product Name',
                        onChanged: (data) => name = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Price',
                        keyboardType: TextInputType.number,
                        onChanged: (data) => price = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Description',
                        onChanged: (data) => desc = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Category',
                        onChanged: (data) => category = data,
                      ),
                      const SizedBox(height: 10),
                      CustomTextField(
                        hintText: 'Image Link',
                        onChanged: (data) => image = data,
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: 'Add Product',
                        onTap: () {
                          // بننادي الـ Cubit ونبعتله البيانات الـ 5 المطلوبة
                          BlocProvider.of<AddProductCubit>(context).addProduct(
                            name: name!,
                            price: price!,
                            desc: desc!,
                            image: image!,
                            category: category!,
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

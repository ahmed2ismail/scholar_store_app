import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_store_app/cubits/products_cubit/products_cubit.dart';
import 'package:scholar_store_app/cubits/products_cubit/products_state.dart';
import 'package:scholar_store_app/screens/Add_Product_Page.dart';
import 'package:scholar_store_app/widgets/custom_card.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static String id = 'home_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('New Trend', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        actions: [
          // استخدام مكتبة FontAwesomeIcons لعرض أيقونة الجرس
          // Icon(FontAwesomeIcons.bell, color: Colors.black),
          // SizedBox(width: 20),
          IconButton(
            onPressed: () async {
              // 1. بنروح لصفحة الإضافة ونستنى
              await Navigator.pushNamed(context, AddProductPage.id);
              // 2. الحارس (The Guard): لو الصفحة اتقفلت وأنا بره، متكملش تنفيذ الكود
              if (!context.mounted) return;
              // 3. لو الصفحة لسه موجودة، نادى المدير وحدث البيانات
              BlocProvider.of<ProductsCubit>(context).fetchAllProducts();
            },
            icon: const Icon(Icons.add_box_outlined, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          // 1. بنروح لصفحة الإضافة ونستنى
          await Navigator.pushNamed(context, AddProductPage.id);
          // 2. الحارس (The Guard): لو الصفحة اتقفلت وأنا بره، متكملش تنفيذ الكود
          if (!context.mounted) return;
          // 3. لو الصفحة لسه موجودة، نادى المدير وحدث البيانات
          BlocProvider.of<ProductsCubit>(context).fetchAllProducts();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {
          if (state is ProductsFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
        },
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsSuccess) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 65.0,
              ),
              child: GridView.builder(
                clipBehavior: Clip.none,
                physics: const BouncingScrollPhysics(),
                itemCount: state.products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 100,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return CustomCard(products: state.products[index]);
                },
              ),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}

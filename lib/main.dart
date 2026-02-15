import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_store_app/cubits/products_cubit/products_cubit.dart';
import 'package:scholar_store_app/screens/Add_Product_Page.dart';
import 'package:scholar_store_app/screens/home_page.dart';
import 'package:scholar_store_app/screens/update_product_page.dart';

void main() {
  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit()
        ..fetchAllProducts(), // علامة ..fetchAllProducts معناها شغله أول ما يتكريت
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => const HomePage(),
          UpdateProductPage.id: (context) => UpdateProductPage(),
          AddProductPage.id: (context) => AddProductPage(),
        },
      ),
    );
  }
}

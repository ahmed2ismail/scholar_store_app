import 'package:flutter/material.dart';
import 'package:scholar_store_app/models/product_model.dart';
import 'package:scholar_store_app/services/all_product_service.dart';
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
        title: Text('New Trend', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        actions: [
          // استخدام مكتبة FontAwesomeIcons لعرض أيقونة الجرس
          // Icon(FontAwesomeIcons.bell, color: Colors.black),
          // SizedBox(width: 20),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart, color: Colors.black),
          ),
        ],
      ),
      // بما ان الداتا بتجي من الانترنت لازم نستخدم FutureBuilder
      body: FutureBuilder<List<ProductModel>>(
        future: AllProductService().getAllProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 65.0,
              ),
              child: GridView.builder(
                clipBehavior: Clip.none,
                physics: BouncingScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 100,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  return CustomCard(products: products[index]);
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

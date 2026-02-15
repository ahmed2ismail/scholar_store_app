// here is the code for update product details.
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_store_app/models/product_model.dart';
import 'package:scholar_store_app/services/update_product_service.dart';
import 'package:scholar_store_app/widgets/custom_button.dart';
import 'package:scholar_store_app/widgets/custom_textformfield.dart';

class UpdateProductPage extends StatefulWidget {
  const UpdateProductPage({super.key});
  static String id = 'product_details';

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  String? productName, description, image, price;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel; // No changes here, just for context
    return Scaffold(
      // Using ModalProgressHUD here can be complex with async/await inside onTap.
      // A simpler approach for now is to manage the loading state directly.
      appBar: AppBar(
        title: const Text('Update Product', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100),
                CustomTextField(
                  hintText: 'Product Name',
                  onChanged: (data) {
                    productName = data;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Description',
                  onChanged: (data) {
                    description = data;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Price',
                  keyboardType: TextInputType.number,
                  onChanged: (data) {
                    price = data;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Image',
                  onChanged: (data) {
                    image = data;
                  },
                ),
                const SizedBox(height: 50),
                CustomButton(
                  text: 'Update',
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await updateProduct(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Product updated successfully')),
                      );
                    } on Exception catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to update product: $e')),
                      );
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
      id: product.id,
      title: productName ?? product.title,
      desc: description ?? product.description,
      price: price ?? product.price.toString(),
      image: image ?? product.image,
      category: product.category,
    );
  }
}

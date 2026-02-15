import 'package:flutter/material.dart';
import 'package:scholar_store_app/models/product_model.dart';
import 'package:scholar_store_app/screens/update_product_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.products});
  final ProductModel products;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODo: Navigate to product details page (update product page)
        Navigator.pushNamed(context, UpdateProductPage.id, arguments: products);
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  spacing: 3,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      products.title.substring(0, 6),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${products.price}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 2,
            top: -60,
            child: Image.network(products.image, height: 100, width: 100),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:footwearclient/model/product/product.dart';
import 'package:get/get.dart';

class ProductDescriptionPage extends StatelessWidget {
  const ProductDescriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments['data'];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                product.image?? '',
                fit: BoxFit.contain,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             Text(
              product.name?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
             const SizedBox(
              height: 20,
            ),
             Text(
              product.description ??'',
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
             Text(
              'Rs:${product.price?? ''}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ), const SizedBox(
              height: 20,
            ),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                labelText: 'Enter Your Billing Address',
              ),
            ), const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.indigo,
                ),child: const Text('Buy Now',style: TextStyle(fontSize: 18,color: Colors.white),
              ),onPressed: (){
                  Get.snackbar("Success", "Order Successful",
                  snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    duration: const Duration(seconds: 3),
                  );
              },
              ),
            )
          ],
        ),
      ),
    );
  }
}

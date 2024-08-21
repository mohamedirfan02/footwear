import 'package:flutter/material.dart';
import 'package:footwearclient/controller/home_controller.dart';
import 'package:footwearclient/pages/login_page.dart';
import 'package:footwearclient/pages/product_description_page.dart';
import 'package:footwearclient/pages/widgets/dropdown_button.dart';
import 'package:footwearclient/pages/widgets/multiselect_dropdown.dart';
import 'package:footwearclient/pages/widgets/product_cart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      // List of banner images
      List<String> bannerImages = [
        'https://m.media-amazon.com/images/S/al-eu-726f4d26-7fdb/c5303c56-2cef-461e-abf0-44e36492a038._CR0,0,1200,628_SX430_QL70_.jpg',
        'https://m.media-amazon.com/images/S/al-eu-726f4d26-7fdb/e99211cb-d0e7-44f2-93ca-a0fc7083e81c._CR0%2C0%2C1501%2C300_SX1500_.jpg',
        'https://m.media-amazon.com/images/S/al-eu-726f4d26-7fdb/98ca55d9-41a9-420c-accc-797b0f2a8c5b._CR0,1279,1755,919_SX430_QL70_.jpg',
        'https://m.media-amazon.com/images/I/61MF7n4RECL._SX3000_.jpg',
        'https://m.media-amazon.com/images/G/31/img24/Fashion/AF/3.0/PC/hero/Premium-Luggage_2._CB555362677_.png',
        'https://m.media-amazon.com/images/G/31/img24/Fashion/AF/3.0/PC/hero/Monsoon-Friendly-Footwear_4._CB555362677_.png',
      ];

      return RefreshIndicator(
        onRefresh: () async {
          // Fetch products on pull-to-refresh
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple, // Set the background color of the AppBar
            title: const Text(
              '𝑺𝒕𝒆𝒍𝒍𝒂𝒓𝑺𝒕𝒆𝒑',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            automaticallyImplyLeading: false, // Remove the back icon from the AppBar
            actions: [
              IconButton(
                onPressed: () {
                  GetStorage box = GetStorage();
                  box.erase(); // Clear stored data on logout
                  Get.offAll(const LoginPage()); // Navigate to LoginPage
                },
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: Column(
            children: [
              // Category Chips
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ctrl.productCategories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ctrl.filterByCategory(
                          ctrl.productCategories[index].name ?? '',
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Chip(
                          label: Text(
                            ctrl.productCategories[index].name ?? 'Error',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Dropdowns for sorting and filtering
              Row(
                children: [
                  Flexible(
                    child: DropDownBtn(
                      item: const ['Rs: low to high', 'Rs: high to low'],
                      selectedItemsText: 'Sort',
                      OnsSelected: (selected) {
                        ctrl.sortByPrice(
                          ascending: selected == 'Rs: low to high',
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: MultiSelectDropDown(
                      items: const [
                        'Sketchers',
                        'Adidas',
                        'Puma',
                        'Clerks'
                      ],
                      onSelectionChanged: (selectedItems) {
                        ctrl.filterByBrand(selectedItems);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Banner Images Section
              SizedBox(
                height: 150, // Adjust the height as needed
                child: PageView.builder(
                  itemCount: bannerImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          bannerImages[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              // Products Grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: ctrl.productShowInUi.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                      name: ctrl.productShowInUi[index].name ?? 'No name',
                      imageUrl: ctrl.productShowInUi[index].image ?? 'Url',
                      price: ctrl.productShowInUi[index].price ?? 00,
                      offerTag: '20 % off',
                      onTap: () {
                        Get.to(
                          const ProductDescriptionPage(),
                          arguments: {'data': ctrl.productShowInUi[index]},
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

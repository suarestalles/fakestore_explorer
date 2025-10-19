import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:franq_store/main.dart';
import 'package:franq_store/objectbox.g.dart';
import 'package:franq_store/products/controllers/favorite_products_controller.dart';
import 'package:franq_store/products/controllers/product_list_controller.dart';
import 'package:franq_store/products/models/product_model.dart';
import 'package:franq_store/products/pages/favorite_products_list.dart';
import 'package:franq_store/utils/constants.dart';
import 'package:franq_store/utils/my_snackbars.dart';
import 'package:franq_store/widgets/my_drawer.dart';
import 'package:franq_store/widgets/stars_rating.dart';
import 'package:get/get.dart';

class ProductDetails extends StatefulWidget {
  final Product? product;
  const ProductDetails(this.product, {super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FavoriteProductsListController());
    final productBox = objectbox.store.box<Product>();
    Product? isFavorite = productBox.query(Product_.externalId.equals(widget.product!.externalId!)).build().findFirst();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            alignment: AlignmentGeometry.topRight,
            children: [
              IconButton(
                onPressed: () => Get.to(() => FavoriteProductsList()),
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
              ),
              Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  color: Color.fromARGB(50, 0, 0, 0),
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Text(
                  objectbox.store.box<Product>().getAll().length.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                )
              ),
            ],
          ),
        ],
        actionsPadding: EdgeInsets.all(defaultPadding),
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Image.network(widget.product?.image ?? ''),
              ),
              Divider(),
              Stack(
                alignment: AlignmentGeometry.bottomRight,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product?.title ?? '-',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      if (isFavorite == null) {
                        Product newProduct = widget.product!;
                        newProduct.id = 0;
                        productBox.put(newProduct);
                        MySnackbars.successSnackBar('Product successfully added to favorites list!');
                      } else {
                        productBox.remove(isFavorite!.id!);
                        MySnackbars.successSnackBar('Product successfully removed to favorites list!');
                      }
                      setState(() {
                        isFavorite = productBox.query(Product_.externalId.equals(widget.product!.externalId!)).build().findFirst();
                      });
                      Get.find<ProductListController>().update();
                      Get.find<FavoriteProductsListController>().update();
                    },
                    icon: Icon(
                      isFavorite == null ? Icons.favorite_border : Icons.favorite,
                      color: isFavorite == null ? Get.theme.iconTheme.color : Colors.red,
                    )
                  ),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    UtilBrasilFields.obterReal(widget.product?.price ?? 0),
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.green,
                      shadows: [Shadow(color: Colors.blueGrey, blurRadius: 5)]
                    )
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Product Rating: ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          StarsRating(widget.product?.rating?.rate ?? 0),
                        ],
                      ),
                      Text(
                        'Rating: ${widget.product?.rating?.rate?.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Votes: ${widget.product?.rating?.count.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: defaultPadding,
                    children: [
                      Text(
                        'Product Category:',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product?.category?.capitalizeFirst ?? '-',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Text(
                    'Product Description:',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.product?.description?.capitalizeFirst ?? '-',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
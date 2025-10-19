import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:franq_store/main.dart';
import 'package:franq_store/objectbox.g.dart';
import 'package:franq_store/products/controllers/favorite_products_controller.dart';
import 'package:franq_store/products/controllers/product_list_controller.dart';
import 'package:franq_store/products/models/product_model.dart';
import 'package:franq_store/products/pages/product_details.dart';
import 'package:franq_store/utils/constants.dart';
import 'package:franq_store/utils/my_snackbars.dart';
import 'package:get/get.dart';

class ProductListCard extends StatefulWidget {
  final Product? product;
  const ProductListCard(this.product, {super.key});

  @override
  State<ProductListCard> createState() => _ProductListCardState();
}

class _ProductListCardState extends State<ProductListCard> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FavoriteProductsListController());
    final productBox = objectbox.store.box<Product>();
    Product? isFavorite = productBox.query(Product_.externalId.equals(widget.product!.externalId!)).build().findFirst();
    return InkWell(
      onTap: () {
        Get.to(() => ProductDetails(widget.product));
      },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Row(
            spacing: defaultPadding,
            children: [
              Image.network(
                widget.product?.image ?? '',
                width: 100,
                height: 100,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product?.title ?? '-',
                      // overflow: TextOverflow.,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      UtilBrasilFields.obterReal(widget.product?.price ?? 0),
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.green, blurRadius: 5)]
                      )
                    )
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  if (isFavorite == null) {
                    Product newProduct = widget.product!;
                    newProduct.id = 0;
                    productBox.put(newProduct);
                    MySnackbars.successSnackBar('Product successfully added to favorites list!');
                  } else {
                    productBox.remove(isFavorite.id!);
                    MySnackbars.successSnackBar('Product successfully removed to favorites list!');
                  }
                  Get.find<ProductListController>().update();
                  Get.find<FavoriteProductsListController>().update();
                },
                icon: Icon(
                  isFavorite == null ? Icons.favorite_border : Icons.favorite,
                  color: isFavorite == null ? Colors.white : Colors.red,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
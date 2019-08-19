import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/datas/cart_product.dart';
import 'package:loja_virtual/datas/product_data.dart';

class CardTile extends StatelessWidget {
  final CartProduct cardProduct;

  CardTile(this.cardProduct);

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {}

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cardProduct.productData == null
          ? FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(cardProduct.category)
                  .collection("itens")
                  .document(cardProduct.pid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  cardProduct.productData =
                      ProductData.formDocument(snapshot.data);
                  _buildContent();
                } else {
                  return Container(
                      height: 70,
                      child: CircularProgressIndicator(),
                      alignment: Alignment.center);
                }
              },
            )
          : _buildContent(),
    );
  }
}

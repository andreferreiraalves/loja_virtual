import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          "Cupom de desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection("coupons")
                    .document(text)
                    .get()
                    .then((docsnap) {
                  if (docsnap.data != null) {
                    CartModel.of(context)
                        .setCoupon(text, docsnap.data["percent"]);

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Desconto de ${docsnap.data["percent"]}% aplicado!"),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Cupom não existente !"),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

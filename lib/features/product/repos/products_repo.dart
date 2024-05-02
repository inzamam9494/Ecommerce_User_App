import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/features/product/model/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductsRepo {
  static Future<List<ProductModel>> getProducts() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('Product').get();
    final docs = snapshot.docs;
    List<ProductModel> products = [];
    for (int i = 0; i < docs.length; i++) {
      products.add(ProductModel(name: docs[i]['name'],
          price: docs[i]['price'],
          product: docs[i]['product'],
          status: docs[i]['status']));
    }
    return products;
  }


  static updateMyCart(String productId) async {
    User? currUser = FirebaseAuth.instance.currentUser;
    if (currUser != null) {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('user').doc(currUser.uid).get();
      if(documentSnapshot.exists){
        List cartList = documentSnapshot['carList'] ?? [];
      }
    }
  }
}
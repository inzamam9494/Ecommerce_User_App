import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_user/features/cart/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepo {
  static Future<List<CartModel>?> fetchUserCart() async {

    try{
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser?.uid??"")
          .get();
      List<CartModel> cartModels = [];
      for(int i = 0; i < documentSnapshot['cartList'].length; i++){
        cartModels.add(CartModel(productId: documentSnapshot['cartList'][i]['productId'],
            quantity: documentSnapshot['cartList'][i]['quantity']));
      }
       // if(cartList != null){
      return cartModels;
      // }else{
      // return null;
      // }
    }catch(e){
      log(e.toString());
    }
    return null;


  }
}

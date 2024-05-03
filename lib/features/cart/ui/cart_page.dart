import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cart_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    // TODO: implement initState
    cartBloc.add(CartLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Shopping Cart',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadState:
              return const Center(child: CircularProgressIndicator(),);
            case CartErrorState:
              return const Center(child: Text("Something Went Wrong"),);
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return Column(
                children: List.generate(successState.cartList.length, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.grey.shade200,
                    title: Text(successState.cartList[index].productId),
                    subtitle: Text(successState.cartList[index].quantity.toString()),
                  ),
                )),
              );
            default:
            return const Center(child: CircularProgressIndicator(),);
          }
          Container();
        },
      ),
    );
  }
}

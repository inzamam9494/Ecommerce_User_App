import 'package:ecommerce_user/features/cart/ui/cart_page.dart';
import 'package:ecommerce_user/features/product/bloc/products_bloc.dart';
import 'package:ecommerce_user/features/product/repos/products_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductsBloc productsBloc = ProductsBloc();

  @override
  void initState() {
    productsBloc.add(ProductsFetchInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Products Page",
          style: TextStyle(
              color: Colors.white
          ),),
        elevation: 2,
        shadowColor: Colors.black,
        actions: [
          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.login_outlined, color: Colors.white,)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
          }, icon: Icon(Icons.shopping_cart, color: Colors.white,))
        ],
      ),
      body: BlocConsumer<ProductsBloc, ProductsState>(
        bloc: productsBloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType){
            case ProductFetchLoadingState :
              return const Center(child: CircularProgressIndicator(),);
            case ProductFetchErrorState :
              return const Center(child: Text('Something went wrong'),);
            case ProductFetchSuccessState :
              final successState = state as ProductFetchSuccessState;
              return Container(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      height: 40,
                    );
                  },
                  padding: const EdgeInsets.only(top: 12),
                  itemCount: successState.products.length,
                    itemBuilder: (context, index){
                    return ListTile(
                      title: Text(successState.products[index].name.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.products[index].product.toString()),
                          Text('Rs. '+ successState.products[index].price.toString() + '/-'),
                          Text(successState.products[index].status.toString()),
                          SizedBox(height: 10,),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: (){
                                ProductsRepo.updateMyCart(
                                  successState.products[index].id
                                );
                              },
                              child: const Text("Add to Cart",
                              style: TextStyle(
                                color: Colors.white
                              ),),
                            ),
                          )
                        ],
                      ),
                    );
                    },
                ),
              );
            default: return Container();
          }
        },
      ),
    );
  }
}

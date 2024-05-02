import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:ecommerce_user/features/product/model/product_model.dart';
import 'package:ecommerce_user/features/product/repos/products_repo.dart';
import 'package:meta/meta.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsFetchInitialEvent>(productsFetchInitialEvent);
  }

  FutureOr<void> productsFetchInitialEvent(
      ProductsFetchInitialEvent event, Emitter<ProductsState> emit) async{
    try{
      emit(ProductFetchLoadingState());
      List<ProductModel> products = await ProductsRepo.getProducts();
      log(products.map((e) => e.toMap()).toString());
      emit(ProductFetchSuccessState(products: products));
    }catch(e){
      log(e.toString());
      emit(ProductFetchErrorState());
    }
  }
}

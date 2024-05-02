part of 'products_bloc.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

class ProductFetchSuccessState extends ProductsState {
  final List<ProductModel> products;
  ProductFetchSuccessState({required this.products});
}

class ProductFetchErrorState extends ProductsState {}

class ProductFetchLoadingState extends ProductsState {}

part of 'update_product_cubit.dart';

@immutable
sealed class UpdateProductState {}

final class UpdateProductInitial extends UpdateProductState {}

final class UpdateProductLoading extends UpdateProductState {}

final class UpdateProductSuccess extends UpdateProductState {
  final ProductModel product;
  UpdateProductSuccess({required this.product});
}

final class UpdateProductFailure extends UpdateProductState {
  final String errorMessage;
  UpdateProductFailure({required this.errorMessage});
}
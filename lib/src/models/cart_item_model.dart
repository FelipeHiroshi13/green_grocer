// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

import 'item_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  @JsonKey(name: 'product')
  ItemModel item;
  int quantity;
  String id;

  CartItemModel({
    required this.id,
    required this.item,
    required this.quantity,
  });

  totalPrice() => item.price * quantity;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);

  @override
  String toString() =>
      'CartItemModel(item: $item, quantity: $quantity, id: $id)';
}

import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/custom_color.dart';
import 'package:greengrocer/src/pages/common_widgets/quantity_widget.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';

class Cartile extends StatefulWidget {
  final CartItemModel cartItem;
  final Function(CartItemModel) remove;

  const Cartile({
    Key? key,
    required this.cartItem,
    required this.remove,
  }) : super(key: key);

  @override
  State<Cartile> createState() => _CartileState();
}

class _CartileState extends State<Cartile> {
  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        //Imagem
        leading: Image.asset(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),

        //Titulo
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),

        //Total
        subtitle: Text(
          utilsServices.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),

        //Quantidade
        trailing: QuantityWidget(
          value: widget.cartItem.quantity,
          suffixText: widget.cartItem.item.unit,
          isRemovable: true,
          result: (quantity) {
            setState(() {
              widget.cartItem.quantity = quantity;

              if (quantity == 0) {
                widget.remove(widget.cartItem);
              }
            });
          },
        ),
      ),
    );
  }
}

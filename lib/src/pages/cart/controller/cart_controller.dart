import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';
import '../../orders/components/payment_dialog.dart';
import '../cart_result/cart_result.dart';

class CartController extends GetxController {
  final cartRespository = CartRespository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  List<CartItemModel> cartItems = [];

  bool isCheckoutLoading = false;

  @override
  void onInit() {
    super.onInit();
    getCartItems();
  }

  double cartTotalPrice() {
    double total = 0;

    for (final item in cartItems) {
      total += item.totalPrice();
    }

    return total;
  }

  Future<bool> changeItemQuantity(
      {required CartItemModel item, required int quantity}) async {
    final result = await cartRespository.changeItemQuantity(
      cartItemId: item.id,
      quantity: quantity,
      token: authController.user.token!,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity =
            quantity;
      }
      update();
    } else {
      utilsServices.showToast(
        message: 'Erro ao alterrar a quantidade de produtos',
        isError: true,
      );
    }

    return result;
  }

  Future<void> getCartItems() async {
    final result = await cartRespository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      sucess: (data) {
        cartItems = data;
        update();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      //produto ja existe na listagem
      final product = cartItems[itemIndex];

      await changeItemQuantity(
        item: product,
        quantity: (product.quantity + quantity),
      );
    } else {
      final CartResult<String> result = await cartRespository.addItemToCart(
        userId: authController.user.id!,
        token: authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(
        sucess: (cartItemId) {
          cartItems.add(
            CartItemModel(
              id: cartItemId,
              item: item,
              quantity: quantity,
            ),
          );
        },
        error: (message) {
          utilsServices.showToast(message: message, isError: true);
        },
      );
    }

    update();
  }

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

  Future checkoutCart() async {
    setCheckoutLoading(true);
    final result = await cartRespository.checkoutCart(
      token: authController.user.token!,
      total: cartTotalPrice(),
    );
    setCheckoutLoading(false);

    result.when(
      sucess: (order) {
        cartItems.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (_) {
            return PaymentDialog(
              order: order,
            );
          },
        );
      },
      error: (message) {
        utilsServices.showToast(message: message);
      },
    );
  }
}

import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

import '../../../models/cart_item_model.dart';
import '../../../models/order_model.dart';

class CartRespository {
  final _httpManager = HttpManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {'X-Parse-Session-Token': token},
      body: {
        'user': userId,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.sucess(data);
    } else {
      return CartResult<List<CartItemModel>>.error(
          'erro ao recuperar os itens do carrinho');
    }
  }

  Future<bool> changeItemQuantity({
    required String cartItemId,
    required int quantity,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.modifyItemQuantity,
      method: HttpMethods.post,
      body: {
        'cartItemId': cartItemId,
        'quantity': quantity,
      },
      headers: {'X-Parse-Session-Token': token},
    );
    return result.isEmpty;
  }

  Future<CartResult<OrderModel>> checkoutCart({
    required String token,
    required double total,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.checkout,
      method: HttpMethods.post,
      body: {
        'total': total,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      final order = OrderModel.fromJson(result['result']);
      return CartResult<OrderModel>.sucess(order);
    } else {
      return CartResult.error('Não foi possível realizar o pedido');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemToCart,
      method: HttpMethods.post,
      body: {
        'user': userId,
        'quantity': quantity,
        'productId': productId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      return CartResult<String>.sucess(result['result']['id']);
    } else {
      return CartResult<String>.error(
          'Não foi possíve adicionar o item no carrinho');
    }
  }
}

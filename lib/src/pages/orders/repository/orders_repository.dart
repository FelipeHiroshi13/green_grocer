import 'package:greengrocer/src/constants/endpoints.dart';
import 'package:greengrocer/src/models/cart_item_model.dart';
import 'package:greengrocer/src/models/order_model.dart';
import 'package:greengrocer/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrocer/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HttpMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();

      return OrdersResult<List<OrderModel>>.sucess(orders);
    } else {
      return OrdersResult.error('Não foi possível listar os pedidos');
    }
  }

  Future<OrdersResult<List<CartItemModel>>> getOrdersItems(
      {required String orderId, required String token}) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getOrdersItems,
      method: HttpMethods.post,
      body: {
        'orderId': orderId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return OrdersResult<List<CartItemModel>>.sucess(items);
    } else {
      return OrdersResult.error('Não foi possivel recuperar os pedidos');
    }
  }
}

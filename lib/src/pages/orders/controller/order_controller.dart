import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../../models/order_model.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController(this.order);

  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final result = await ordersRepository.getOrdersItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setLoading(false);
    result.when(
      sucess: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utilsServices.showToast(message: message, isError: true);
      },
    );
  }
}

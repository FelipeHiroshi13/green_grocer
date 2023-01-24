import 'package:get/get.dart';
import 'package:greengrocer/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrocer/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrocer/src/services/utils_services.dart';

import '../../../models/order_model.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    final result = await ordersRepository.getAllOrders(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(
      sucess: (orders) {
        allOrders = orders;
        update();
      },
      error: (message) {
        utilsServices.showToast(message: message);
      },
    );
  }
}

import 'package:greengrocer/src/models/item_model.dart';
import 'package:greengrocer/src/pages/home/result/home_result.dart';

import '../../../constants/endpoints.dart';
import '../../../models/category_model.dart';
import '../../../services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map((e) => CategoryModel.fromJson(e))
              .toList();

      return HomeResult<CategoryModel>.sucess(data);
    } else {
      return HomeResult.error('Ocorreu um erro ao recuperar categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map((e) => ItemModel.fromJson(e))
          .toList();

      return HomeResult<ItemModel>.sucess(data);
    } else {
      return HomeResult.error('Ocorreu um erro ao recuperar os produtos');
    }
  }
}

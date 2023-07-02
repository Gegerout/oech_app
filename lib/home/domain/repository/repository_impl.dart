import 'package:oech_app/home/domain/usecases/order_usecase.dart';

import '../usecases/images_usecase.dart';
import '../usecases/user_usecase.dart';

abstract class Repository {
  Future<ImagesUseCase> getImages();
  Future<UserUseCase> getUserData();
  Future<void> updateBalance(String balance);
  Future<void> logout();
  Future<void> createOrder(OrderUseCase data);
  Future<OrderUseCase> getOrder(String track);
  Future<void> createTransaction(List data);
  Future<List<String>> getOrders();
  Future<void> setOrderState(List data, String track);
  Future<OrderUseCase> getOrderDetails(String track);
}
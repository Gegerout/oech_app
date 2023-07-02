import 'package:oech_app/home/data/data_sources/remote_data.dart';
import 'package:oech_app/home/domain/usecases/images_usecase.dart';
import 'package:oech_app/home/domain/usecases/order_usecase.dart';

import '../../domain/repository/repository_impl.dart';
import '../../domain/usecases/user_usecase.dart';

class DataRepository extends Repository {
  @override
  Future<ImagesUseCase> getImages() async {
    final data = await RemoteData().getImages();
    final usecase = ImagesUseCase(data);
    return usecase;
  }

  @override
  Future<UserUseCase> getUserData() async {
    final data = await RemoteData().getUserData();
    final usecase = UserUseCase(data);
    return usecase;
  }

  @override
  Future<void> updateBalance(String balance) async {
    await RemoteData().updateBalance(balance);
  }

  @override
  Future<void> logout() async {
    await RemoteData().logout();
  }

  @override
  Future<void> createOrder(OrderUseCase data) async {
    await RemoteData().createOrder(data.data);
  }

  @override
  Future<OrderUseCase> getOrder(String track) async {
    final data = await RemoteData().getOrder(track);
    final usecase = OrderUseCase(data);
    return usecase;
  }

  @override
  Future<void> createTransaction(List data) async {
    await RemoteData().createTransaction(data);
  }

  @override
  Future<List<String>> getOrders() async {
    final data = await RemoteData().getOrders();
    return data;
  }

  @override
  Future<void> setOrderState(List data, String track) async {
    await RemoteData().setOrderState(data, track);
  }

  @override
  Future<OrderUseCase> getOrderDetails(String track) async {
    final data = await RemoteData().getOrderDetails(track);
    final usecase = OrderUseCase(data);
    return usecase;
  }
}
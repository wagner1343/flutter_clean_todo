import 'package:flutter_clean_todo/ioc/locator.dart';
import 'package:get_it/get_it.dart';

class GetItLocator implements Locator {
  final GetIt instance;

  GetItLocator(this.instance);

  @override
  T get<T extends Object>() => instance.get<T>();
}

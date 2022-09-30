import 'package:budget_app/objectbox.g.dart';


class ObjectBox {
  /// The Store of this app.
  late final Store store;
  ObjectBox();

  Box<T> getMyBox<T>() {
    return store.box<T>();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  Future<void> create() async {
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    store = await openStore();
  }

  void close() {
    store.close();
  }
}

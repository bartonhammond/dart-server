import '../server.dart';

class Product extends ManagedObject<_Product> {}

class _Product {
// This class inherits the following from ManagedAuthenticatable:

  @primaryKey
  int id;

  @Column(unique: true, indexed: true)
  String name;

  String description;

  double price;
}

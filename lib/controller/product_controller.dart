import '../model/product.dart';
import '../server.dart';

class ProductController extends ManagedObjectController<Product> {
  ProductController(ManagedContext context) : super(context);
}

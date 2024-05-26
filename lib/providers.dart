import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'features/auth/data/openfoodfacts.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/auth/repositories/auth_repository_impl.dart';
import 'features/home/data/openfoodfacts.dart';
import 'features/home/repositories/product_repository.dart';
import 'features/home/repositories/product_repository_impl.dart';

class AppProviders {
  static List<SingleChildWidget> getProviders() {
    return [
      Provider<AuthRepository>(
        create: (_) => AuthRepositoryImpl(
          remoteDataSource: AuthRemoteDataSource(),
        ),
      ),
      Provider<ProductRepository>(
        create: (_) => ProductRepositoryImpl(
          remoteDataSource: ProductRemoteDataSource(),
        ),
      ),
    ];
  }
}

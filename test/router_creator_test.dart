import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_classes/src/router_creator.dart';
import 'package:test/test.dart';

void main() {
  test('getRoutersByClass returns a Router', () {
    final result = getRoutersByClass([]);
    expect(result.runtimeType, Router);
  });
}

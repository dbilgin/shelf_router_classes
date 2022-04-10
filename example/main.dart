import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_classes/shelf_router_classes.dart';

import 'example_second_service.dart';
import 'example_service.dart';

void main(List<String> arguments) async {
  Router router = getRoutersByClass([ExampleService, ExampleSecondService]);
  await serve(logRequests().addHandler(router), 'localhost', 8080);
}

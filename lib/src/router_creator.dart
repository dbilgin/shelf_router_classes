import 'package:shelf_router/shelf_router.dart';

import 'router_builder.dart';

/// Gets a reference list of classes as `Type` list and goes
/// through each one of them to determine the routes within
/// these classes, declared through a `@Route` annotation.
/// So in this case, every class would represent a bundle
/// of controllers and every function with a `@Route` annotation
/// would represent a controller itself.
///
/// The usage is fairly simple. You first need to declare your
/// routes as shown below:
/// ```dart
/// import 'package:shelf/shelf.dart';
/// import 'package:shelf_router/shelf_router.dart';
/// import 'package:shelf_router_classes/shelf_router_classes.dart';
///
/// @RoutePrefix('/prefix')
/// class ExampleService {
///   @Route('GET', '/example')
///   Response getAllExamples(Request request) {
///     return Response.ok('["1", "2", "3", "4"]');
///   }
///
///   @Route('GET', '/example/<number>')
///   Response getSpecificExample(Request request, int number) {
///     return Response.ok(number);
///   }
///
///   @Route('POST', '/example')
///   Future<Response> postExampe(Request request) async {
///     return Response.ok(await request.readAsString());
///   }
/// }
/// ```
///
/// After doing this, your controller is ready. Now you can
/// pass references of your classes into `getRoutersByClass`.
/// You can declare your router as below and serve it:
///
/// ```dart
/// void main(List<String> arguments) async {
///   Router router = getRoutersByClass([ExampleService, ExampleSecondService]);
///   await serve(logRequests().addHandler(router), 'localhost', 8080);
/// }
/// ```
///
/// Now all the annotations that you declared on top of your methods inside
/// the classes passed into `getRoutersByClass` will automatically be
/// declared inside your router and be served.
Router getRoutersByClass(List<Type> routeClasses) {
  var methods = getRouteData(routeClasses);

  final _router = Router();
  setupRoutes(methods, _router);
  return _router;
}

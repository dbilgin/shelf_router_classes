# shelf_router_classes
[![Pub Version](https://img.shields.io/pub/v/shelf_router_classes?color=blueviolet)](https://pub.dev/packages/shelf_router_classes)

An easier way to declare and use routes for the [shelf](https://pub.dev/packages/shelf) and [shelf_router](https://pub.dev/packages/shelf_router) packages using classes and Route annotations. It handles all the declaration automatically and no code generation is required.

## Installation

Add `shelf_router_classes` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

<h1>Usage</h1>

The usage is fairly simple. You first need to declare your routes using classes and `@Route` annotations as shown below:

```dart
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ExampleService {
  @Route('GET', '/example')
  Response getAllExamples(Request request) {
    return Response.ok('["1", "2", "3", "4"]');
  }
  @Route('GET', '/example/<number>')
  Response getSpecificExample(Request request, int number) {
    return Response.ok(number);
  }
  @Route('POST', '/example')
  Future<Response> postExampe(Request request) async {
    return Response.ok(await request.readAsString());
  }
}
```

After doing this, your first controller is ready. Now you can pass a reference of your class into `getRoutersByClass`. You can declare your router as below and serve it:

```dart
void main(List<String> arguments) async {
  Router router = getRoutersByClass([ExampleService]);
  await serve(logRequests().addHandler(router), 'localhost', 8080);
}
```

Now all the `@Route` annotations that you declared on top of your methods inside the classes passed into `getRoutersByClass` will automatically be declared inside your router and be served.

You can quickly test it by going to http://localhost:8080/example
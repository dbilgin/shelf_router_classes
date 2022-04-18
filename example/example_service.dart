import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_router_classes/shelf_router_classes.dart';

@RoutePrefix('/prefix')
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

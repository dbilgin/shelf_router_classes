import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class ExampleSecondService {
  @Route('GET', '/second')
  Response getAllSecondExamples(Request request) {
    return Response.ok('["1", "2", "3", "4"]');
  }
}

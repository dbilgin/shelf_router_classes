import 'package:shelf_router_classes/src/router_builder.dart';
import 'package:test/test.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

void main() {
  test('getRouteData should return empty list', () {
    final result = getRouteData([]);
    expect(result.length, 0);
  });

  test('getRouteData should return empty list', () {
    final result = getRouteData([MockEmptyService]);
    expect(result.length, 0);
  });

  test('getRouteData should return correct data', () {
    final result = getRouteData([MockService]);
    expect(result.length, 1);
    expect(result[0].requestType, 'GET');
    expect(result[0].methodPath, '/example');
    expect(
        result[0].method.toString(), MockService().getAllExamples.toString());
  });

  test('getRouteData should return correct data - multiple classes', () {
    final result = getRouteData([MockService, MockService2]);
    expect(result.length, 3);

    expect(result[0].requestType, 'GET');
    expect(result[0].methodPath, '/example');
    expect(
        result[0].method.toString(), MockService().getAllExamples.toString());

    expect(result[1].requestType, 'GET');
    expect(result[1].methodPath, '/second');
    expect(
        result[1].method.toString(), MockService2().getAllExamples.toString());

    expect(result[2].requestType, 'POST');
    expect(result[2].methodPath, '/second');
    expect(result[2].method.toString(),
        MockService2().getAllExamplesPost.toString());
  });
}

class MockService {
  @Route('GET', '/example')
  Response getAllExamples(Request request) {
    return Response.ok('["1", "2", "3", "4"]');
  }
}

class MockService2 {
  @Route('GET', '/second')
  Response getAllExamples(Request request) {
    return Response.ok('["1", "2", "3", "4"]');
  }

  @Route('POST', '/second')
  Response getAllExamplesPost(Request request) {
    return Response.ok('["1", "2", "3", "4"]');
  }
}

class MockEmptyService {
  Response getAllExamples(Request request) {
    return Response.ok('["1", "2", "3", "4"]');
  }
}

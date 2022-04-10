import 'dart:mirrors';

import 'package:shelf_router/shelf_router.dart';

import 'method_data.dart';

/// Loops through all the determined route [methods] and adds their
/// necessary data into the [router].
void setupRoutes(List<MethodData> methods, Router router) {
  for (var method in methods) {
    router.add(
      method.requestType,
      method.methodPath,
      method.method,
    );
  }
}

/// Loops through the class references named as [types] and creates
/// a [ClassMirror]instance for each one, which allows it to access the
/// class instance members.
/// Finally it loops through every instance member of every class creates
/// the route data by adding the data inside a [MethodData] list.
List<MethodData> getRouteData(List<Type> types) {
  List<MethodData> routeData = [];
  for (var i = 0; i < types.length; i++) {
    final classMirror = reflectClass(types[i]);
    final classInstanceMembers = classMirror.instanceMembers.values.toList();

    for (var member in classInstanceMembers) {
      final methods = _getMethodAnnotationPath(member, classMirror);
      routeData.addAll(methods);
    }
  }
  return routeData;
}

/// Creates a dummy instance out of the passed [ClassMirror]. Which gives
/// it access to every field inside that class, including the methods.
/// The [DeclarationMirror] allows us to go through the metadata of every
/// method that's declared and through this [declaration] it is able
/// to find out whether the method has a [Route] annotation or not.
/// If it indeed has the [Route] annotation, then the method is added
/// to the list of router methods along with its `path` and `verb`.
List<MethodData> _getMethodAnnotationPath(
  DeclarationMirror declaration,
  ClassMirror classMirror,
) {
  final newInst = classMirror.newInstance(const Symbol(''), []);
  List<MethodData> methods = [];

  for (var instance in declaration.metadata) {
    if (instance.hasReflectee) {
      var reflectee = instance.reflectee;
      if (reflectee.runtimeType == Route && reflectee is Route) {
        final field = newInst.getField(declaration.simpleName);
        final routeMethod = field.reflectee;

        methods.add(MethodData(
          reflectee.route,
          reflectee.verb,
          routeMethod,
        ));
      }
    }
  }

  return methods;
}

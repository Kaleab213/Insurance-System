import 'package:flutter/material.dart';
import '../models/request.dart';
import 'Add_request.dart';
import 'request_detail.dart';
import 'requests.dart';

class RequestAppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) => Requests());
    }

    if (settings.name == AddRequest.routeName) {
      RequestArgument args = settings.arguments as RequestArgument;
      return MaterialPageRoute(
        builder: (context) => AddRequest(
          args: args,
        ),
      );
    }

    // if (settings.name == UpdateRequest.routeName) {
    //   RequestArgument args = settings.arguments as RequestArgument;
    //   return MaterialPageRoute(
    //     builder: (context) => UpdateRequest(
    //       args: args,
    //     ),
    //   );
    // }

    if (settings.name == RequestDetail.routeName) {
      Request request = settings.arguments as Request;
      return MaterialPageRoute(
        builder: (context) => RequestDetail(
          request: request,
        ),
      );
    }

    return MaterialPageRoute(builder: (context) => Requests());
  }
}

class RequestArgument {
  final Request? request;
  final bool edit;
  RequestArgument({this.request, required this.edit});
}

import '../../common/base/request_model.dart';

abstract class UseCase<Request, Response> {
  Future<Response> execute({RequestModel<Request>? request});
}

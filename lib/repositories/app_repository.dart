import 'package:jify_app/models/initial_data_model.dart';
import 'package:jify_app/network/api_requests.dart';

class AppRepository {
  final _apiRequests = ApiRequests();

  Future<InitialDataModel?> getInitialData() async {
    final result = await _apiRequests.init();
    if (result != null) {
      return InitialDataModel.fromJson(result.data);
    }
    return null;
  }

  Future<String?> contactSupport(String fullName, String email, String subject,
      String orderId, String message) async {
    final result = await _apiRequests.contactSupport({
      "fullname": fullName,
      "email": email,
      "subject": subject,
      "orderId": orderId,
      "message": message
    });

    if (result != null) {
      return result.data["msg"] as String;
    }
    return null;
  }
}

part of '../app_api.dart';

extension UtilityApi on AppApi {
  // Redirect to login or handle the auth failure
  void _handleAuthRedirect() {
    Get.offAllNamed('/login');
  }

  Future<void> ping() async {
    await dio.get('/ping');
  }

  Future<void> securePing() async {
    await dio.get('/secure-ping');
  }

  // Utility function to check if the error is a permission-denied error
  bool _isPermissionDenied(e) {
    return e.toString().contains('code=permission-denied'); // TODO: Any better way to do this?
  }

  /// Middleware function that wraps Firebase calls
  ///
  /// Example usage of the middleware function
  ///
  ///
  /// Future<List<PaymentVoucherModel>> getVoucherList() async {
  ///
  ///   return _handleFirebaseOperation<List<PaymentVoucherModel>>(() async {
  ///
  ///     QuerySnapshot querySnapshot = await AppFirestore().getAllDocuments(AppFirestoreCollectionEnum.vouchers);
  ///
  ///     return querySnapshot.docs.map((doc) => PaymentVoucherModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  ///
  ///   });
  ///
  /// }
  Future<T> _handleFirebaseOperation<T>(Future<T> Function() operation) async {
    try {
      return await operation();
    } catch (e, st) {
      if (_isPermissionDenied(e)) {
        _handleAuthRedirect();

        AppErrorUtility.defaultErrorDialog(
          ErrorModel(
            type: ErrorType.network,
            shownText: 'Your token has expired, please re-login',
            error: e,
            stackTrace: st,
          ),
        );
        // Optionally, you could return a default value or null here if it makes sense
        // for your application, or keep the throw to ensure the calling code knows the operation
        // did not succeed.
      }
      rethrow; // For any other errors, re-throw them.
    }
  }

  Future<bool> checkIfUserDocumentExists(AppFirestoreCollectionEnum collectionEnum, String docId) async {
    DocumentSnapshot userDocument = await AppFirestore().getDocument(collectionEnum, docId);

    // Check if the document exists
    return userDocument.exists;
  }
}

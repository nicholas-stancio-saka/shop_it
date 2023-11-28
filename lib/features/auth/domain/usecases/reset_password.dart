import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
import 'package:shop_it/features/auth/domain/repositories/auth_repository.dart';

class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);

  Future<void> call(String email) async {
    await AppErrorUtility.defaultErrorDialog(
      ErrorModel(
        type: ErrorType.presentation,
        shownTitle: 'Not Implemented',
        shownText: 'Sorry! This feature is not yet implemented!',
        sendError: false,
      ),
    );
  }
}

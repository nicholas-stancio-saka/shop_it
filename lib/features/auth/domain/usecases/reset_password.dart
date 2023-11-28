import 'package:shop_it/features/auth/domain/repositories/auth_repository.dart';
import 'package:shop_it/features/shared/widgets/dialog.dart';

class ResetPassword {
  final AuthRepository repository;

  ResetPassword(this.repository);

  Future<void> call(String email) async {
    // await repository.resetPassword(email);
    const AppSimpleDialog(
      text: 'Not Implemented',
    );
  }
}

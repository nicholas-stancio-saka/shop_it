import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shop_it/core/error/error_model.dart';
import 'package:shop_it/core/error/error_utility.dart';
import 'package:shop_it/core/services/network/firebase/auth.dart';
import 'package:shop_it/core/services/network/firebase/firestore.dart';

// Include the parts
part 'parts/utility_api.dart';
part 'parts/auth_api.dart';

/// Main API class that handles all network requests.
///
/// This class is split into multiple parts for better organization and maintainability.
/// Each part handles a specific domain of the API.
class AppApi {
  final Dio dio;

  AppApi({required this.dio});

  // TODO: IMPLEMENT THIS
  Future<void> resetEmailPassword(String email) async {
    // await AppFirebaseAuth().resetEmailPassword(email);
  }

  // Remove all storage
  Future<void> logout() async {
    await AppFirebaseAuth().signOut();
  }

  // -----

  // TODO: 1
  // Future<UserDTO> getUser(String userId) async {
  //   return _handleFirebaseOperation<UserDTO>(() async {
  //     // Retrieve the document snapshot from Firestore
  //     DocumentSnapshot docSnapshot = await AppFirestore().getDocument(AppFirestoreCollectionEnum.users, userId);

  //     // If the document exists and has data, return the mapped model
  //     if (docSnapshot.exists && docSnapshot.data() != null) {
  //       return UserDTO.fromJson(docSnapshot.data() as Map<String, dynamic>);
  //     } else {
  //       // Handle the case where the voucher does not exist or there is no data
  //       throw Exception('User not found or the data is null');
  //     }
  //   });
  // }
}

// TODO: Seharusnya disini return raw json. tp berhubung masih pake firestore, ditaro disini semua biar transitionnya gampang
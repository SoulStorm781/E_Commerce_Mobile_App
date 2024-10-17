import 'package:af_store/utils/formatters/formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String username;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;

  UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profilePicture,
  });

  //Helper functions to get full name
  String get fullName => '$firstName $lastName';

  //Helper function to getphone format
  String get formattedPhone => FFormatter.formatNumber(phoneNumber);

  static List<String> nameParts(fullname) => fullname.split(" ");

// Static function to get split full name into first and last name
  static String generateUsername(fullname) {
    List<String> nameParts = fullname.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String LastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername = '$firstName$LastName';
    String usernamewithPrefix = 'cwt_$camelCaseUsername';
    return usernamewithPrefix;
  }

  //static function to create empty user model
  static UserModel empty() => UserModel(
        id: '',
        email: '',
        username: '',
        firstName: '',
        lastName: '',
        phoneNumber: '',
        profilePicture: '',
      );

  //convert model to json structure for firestore
  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'firstName': firstName,
        'lastName': lastName,
        'phoneNumber': phoneNumber,
        'profilePicture': profilePicture,
      };

  // factory method to create user model from firestore
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModel(
        id: document.id,
        email: data['email'] ?? '',
        username: data['username'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        profilePicture: data['profilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}

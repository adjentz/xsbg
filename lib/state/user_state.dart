import 'package:uuid/uuid.dart';

class UserState {
  final String userId;
  UserState() : userId = Uuid().v4();
}

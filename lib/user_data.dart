class UserData {
  static final UserData _instance = UserData._internal(); // Private static instance

  factory UserData() => _instance; // Factory constructor

  UserData._internal(); // Private constructor



  List<Map<String, dynamic>> Users= [{

    'username':'admin',
    'email':'admin',
    'password':'admin',
    'phone':''
  }
  ];
}

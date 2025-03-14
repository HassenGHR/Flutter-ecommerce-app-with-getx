class UserModel {
  // Field keys for consistency with Firebase Database
  static const String ID = 'id';
  static const String NAME = 'name';
  static const String EMAIL = 'email';
  static const String PHONE = 'phone';
  static const String ADDRESS = 'address';
  static const String IMAGEURL = 'imageUrl';
  static const String TOKEN = 'token';
  static const String CREATEDAT = 'createdAt';

  // Properties
  String id;
  String name;
  String email;
  String phone;
  String address;
  String imageUrl;
  String? token;
  DateTime? createdAt;

  // Constructor
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.imageUrl,
    required this.token,
    this.createdAt,
  });

  // Named constructor for creating a UserModel from a Firebase Database map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[ID] ?? '',
      name: map[NAME] ?? '',
      email: map[EMAIL] ?? '',
      phone: map[PHONE] ?? '',
      address: map[ADDRESS] ?? '',
      imageUrl: map[IMAGEURL] ??
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
      token: map[TOKEN],
      createdAt: map[CREATEDAT] != null
          ? DateTime.fromMillisecondsSinceEpoch(map[CREATEDAT])
          : null,
    );
  }

  // Convert UserModel to a map for Firebase Database storage
  Map<String, dynamic> toMap() {
    return {
      ID: id,
      NAME: name,
      EMAIL: email,
      PHONE: phone,
      ADDRESS: address,
      IMAGEURL: imageUrl,
      TOKEN: token,
      CREATEDAT: createdAt?.millisecondsSinceEpoch ??
          DateTime.now().millisecondsSinceEpoch,
    };
  }

  // CopyWith method to create a modified copy of the UserModel
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? address,
    String? imageUrl,
    String? token,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      imageUrl: imageUrl ?? this.imageUrl,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Equality operator for comparison
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.address == address &&
        other.imageUrl == imageUrl &&
        other.token == token &&
        other.createdAt == createdAt;
  }

  // HashCode for collections
  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        address.hashCode ^
        imageUrl.hashCode ^
        token.hashCode ^
        createdAt.hashCode;
  }

  // ToString for debugging
  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phone: $phone)';
  }
}

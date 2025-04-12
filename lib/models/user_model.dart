enum UserRole {
  citizen,
  treeOfficer,
  treeAuthority,
  none,
}

class User {
  final String? id;
  final String? name;
  final String? phoneNumber;
  final UserRole role;
  final bool isRegistered;

  User({
    this.id,
    this.name,
    this.phoneNumber,
    this.role = UserRole.none,
    this.isRegistered = false,
  });

  User copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    UserRole? role,
    bool? isRegistered,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
} 
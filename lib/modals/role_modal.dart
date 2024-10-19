
class Role {
  String id;
  String roleName;
  List<RoleType> roleTypes;

  Role({required this.id, required this.roleName, required this.roleTypes});

  factory Role.fromJson(Map<String, dynamic> json) {
    var list = json['roleTypes'] as List;
    List<RoleType> roleTypesList =
        list.map((i) => RoleType.fromJson(i)).toList();

    return Role(
      id: json['_id'],
      roleName: json['roleName'],
      roleTypes: roleTypesList,
    );
  }
}

class RoleType {
  String id;
  String roleTypeName;

  RoleType({required this.id, required this.roleTypeName});

  factory RoleType.fromJson(Map<String, dynamic> json) {
    return RoleType(
      id: json['_id'],
      roleTypeName: json['roleTypeName'],
    );
  }
}

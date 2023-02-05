class UserDetailModel {
  final String name;
  final String address;

  UserDetailModel({required this.name, required this.address});

  Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
      };

  factory UserDetailModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailModel(name: json["name"], address: json["address"]);
  }
}

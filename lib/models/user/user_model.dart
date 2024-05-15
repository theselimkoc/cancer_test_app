class UserModel{
  late String name, email, age;

  UserModel({required this.name, required this.email, required this.age,});

  UserModel.fromJson(Map<String, dynamic> json){
    name = json["name"];
    age = json["age"];
    email = json["email"];
  }

  Map<String, dynamic> toJson(){
    return {
      "name": name,
      "email": email,
      "age": age
    };
  }
}
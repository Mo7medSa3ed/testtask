class User {
  num id;
  String mobile;
  String name_ar;
  String name_en;
  String password;
  String birthdate;
  String api_token;
  List created_at;
  User({this.birthdate, this.mobile, this.name_ar, this.name_en, this.password,this.api_token,this.created_at,this.id});

  factory User.fromJson(Map<String, dynamic> json) => User(
      mobile: json['mobile'],
      name_ar: json['name_ar'],
      name_en: json['name_en'],
      password: json['password'],
      api_token: json['api_token'],
      created_at: json['created_at'],
      id: json['id'],
      birthdate: json['birthdate']);

  Map<String, dynamic> toJson() => {
        'mobile': mobile,
        'name_ar': name_ar,
        'name_en': name_en,
        'password': password,
        'birthdate': birthdate,
      };
}

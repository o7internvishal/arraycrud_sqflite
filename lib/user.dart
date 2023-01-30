
class User{
// Database db
    String name;
    String address;

  User(this.name, this.address);
  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'address':address
    };
  }
}
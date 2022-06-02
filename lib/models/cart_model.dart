class CartModel {
  String? pic, name, disc,details,size,color,id;
  int?  howMany,price;

  CartModel({required this.name, required this.pic,required this.disc,required this.price,this.color,this.id,this.details,this.howMany,this.size});
  CartModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    pic = json['picture'];
    disc = json['disc'];
    price = json['price'];
    details = json['details'];
    size = json['size'];
    color = json['color'];
    id = json['id'];
    howMany = json['howMany'];
  }
  Map<String,dynamic> toMap()=>{
    'name':this.name,
    'picture':this.pic,
    'disc':this.disc,
    'price':this.price,
    'details':this.details ,
    'size':this.size,
    'color':this.color,
    'id':this.id,
    'howMany':this.howMany,
  };
}

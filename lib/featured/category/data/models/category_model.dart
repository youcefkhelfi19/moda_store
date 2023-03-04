import 'package:equatable/equatable.dart';
class CategoryModel extends Equatable {
 final String imageLink;
 final String title;

  const CategoryModel({required this.imageLink, required this.title});

  @override
  // TODO: implement props
  List<Object?> get props => [imageLink,title];


 Map<String, dynamic> toJson() => {
  'title': title,

  'image':imageLink,
 };

 static CategoryModel fromJson(Map<dynamic, dynamic> json) {
  return CategoryModel(
   imageLink: json['image'],
   title: json['title'],
  );
 }
}
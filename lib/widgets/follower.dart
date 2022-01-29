import 'package:flutter/cupertino.dart';

class Follower {
  AnimationController? controller;
  String? name;
  int? followers;
  int? price;
  bool? isLike=false;
  Follower({
    this.name,this.followers,this.price,this.isLike,this.controller,
  });
}
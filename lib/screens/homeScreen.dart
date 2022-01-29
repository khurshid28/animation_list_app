import 'package:animation_list_app/widgets/follower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin{
  List<Follower> users=[];

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
        ScreenUtil.init(
        BoxConstraints(
            maxWidth: size.width,
            maxHeight: size.height),
        designSize:const Size(411.4, 899.4),
        context: context,
        minTextAdapt: true,
        orientation: Orientation.portrait);
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 1,
        shadowColor: Colors.white,
        title: Text("Animation List App",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),),
        ),
        floatingActionButton: InkWell(
          onTap: (){
          users.add(Follower(
            name: "Xurshid",
            followers: 123,
            isLike: false,
            price: 5000,
            controller: AnimationController(vsync: this,duration:const Duration(milliseconds: 800))..forward()..addListener(() { })
              ),
            );
            setState(() {});
          },
          radius: 40.r,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 42.r,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 40.r,
              child: Text("add",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
              users.length,
               (index) => AnimatedBuilder(
                 animation: users[index].controller!,
                 builder: (context, snapshot) {
                   return SizedBox(
                     width: size.width,
                     height: 92.h,
                     child: Stack(
                       children: [
                         Positioned(
                           left: size.width*(users[index].controller!.value-1),
                           child: SizedBox(
                             width: size.width,
                             height: 92.h,
                             child: InkWell(
                               onLongPress: (){
                                   showDialog(
                         context: context,
                          builder: (context)=>CupertinoAlertDialog(
                           content:  Text( "Are you sure that Item deleted?",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: SizedBox(
                                  width: 90.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:const [
                                      Text("CANCEL",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                onPressed: () async{
                                  Navigator.of(context).pop();
                                },),
                              CupertinoDialogAction(
                                child: SizedBox(
                                  width: 90.w,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:const [
                                      Text("OK",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                onPressed: () async{
                                  Navigator.of(context).pop(); 
                                  await (users[index].controller!..duration=const Duration(milliseconds: 500)).reverse();
                                  List<Follower> _newList=[];
                                  for (var i = 0; i < users.length; i++) {
                                    if (i != index) {
                                    _newList.add(users[i]);
                                    }
                                  }
                                  users=_newList;
                                  setState(() {});
                                  
                               
                                },),

                          ],
                          ),
                         );
                               },
                               child: Card(
                                 margin: EdgeInsets.all(6.w),
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(14.r)
                                 ),
                                 color: Colors.black,
                                 elevation: 3,
                                 shadowColor: Colors.white,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 23.r,
                                      child:const Icon(Icons.person_outline_sharp,color: Colors.black,size: 30,),
                                      ),
                                    title: Text(users[index].name!,style:const  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,),),
                                    subtitle:  Text(users[index].followers!.toString(),style: TextStyle(color: Colors.white,fontSize: 12.sp),),
                                    trailing: SizedBox(
                                      width: 126.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         InkWell(
                                           onTap: (){
                                              users[index].isLike= !users[index].isLike!;
                                              setState(() {});
                                           },
                                           radius: 23.r,
                                           splashColor: Colors.transparent,
                                           highlightColor: Colors.transparent,
                                           child: CircleAvatar(
                                             backgroundColor: Colors.transparent,
                                             radius: 23.r,
                                             child:users[index].isLike! ?  const Icon(Icons.favorite,color: Colors.redAccent,size: 28,): const Icon(Icons.favorite_border_outlined,color: Colors.white,size: 28,),
                                             ),
                                         ),
                                         Text(users[index].price!.toString()+" \$",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 18.sp))
                                       ],
                                      ),
                                    ),
                                  ),   
                               ),
                             ),
                           ),
                         ),
                       ],
                     ),
                   );
                 }
               ),
            ),
          ),
        ),

    );
  }
}
import 'package:flutter/material.dart';
import 'package:rupiya/models/loading_model.dart';
import 'package:rupiya/themes/AppColor.dart';
import 'package:provider/provider.dart';
import 'snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';

String newUsername;
final firebaseUser = FirebaseAuth.instance.currentUser;


AlertDialog editUsernameAlert(BuildContext context) {

  var firebaseUser = FirebaseAuth.instance.currentUser;
  return AlertDialog(
    backgroundColor: AppColor.bodyColor,
    elevation: 4.0,
    content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightTextColor),
            borderRadius: BorderRadius.circular(10.0),
            shape: BoxShape.rectangle),
        child: TextField(
          onChanged: (value) => newUsername = value,
          autofocus: true,
          cursorColor: AppColor.textColor,
          keyboardType: TextInputType.text,
          style: TextStyle(color: AppColor.textColor),
          decoration: InputDecoration(
            hintText: 'New Username',
            hintStyle: TextStyle(color: AppColor.lightTextColor),
            contentPadding: EdgeInsets.all(0),
            border: OutlineInputBorder(borderSide: BorderSide.none),
          ),
        )),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text('GO BACK', style: TextStyle(color: AppColor.textColor)),
      ),
      Consumer<LoadingScreenModel>(
        builder: (_,loadingscreenmodel,child) => TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  loadingscreenmodel.loadingScreen();
                  await firebaseUser.updateDisplayName(newUsername)
                  .then((value) { 
                    loadingscreenmodel.loadingScreen();
                    }
                  ).catchError((e) {
                    loadingscreenmodel.loadingScreen();
                    showSnackBar(context,'Something went wrong. Try again');
                  });
                  
                 },
                child: Text('ADD', style: TextStyle(color: AppColor.textColor)),
              ),
      ),
    
      
    ],
  );
}



// AlertDialog newCategoryAlert(BuildContext context) {

//   var categoryData = Provider.of<DocumentSnapshot>(context);

//   if(categoryData!=null) {

//     // we get the list first, then make chnages and send it again
//     List myList = categoryData['Category List'];
//       return AlertDialog(
//       backgroundColor: AppColor.bodyColor,
//       elevation: 4.0,
//       content: Container(
//           padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
//           decoration: BoxDecoration(
//               border: Border.all(color: AppColor.lightTextColor),
//               borderRadius: BorderRadius.circular(10.0),
//               shape: BoxShape.rectangle),
//           child: TextField(
//             onChanged: (value) => newCategoryName = value,
//             autofocus: true,
//             cursorColor: AppColor.textColor,
//             keyboardType: TextInputType.text,
//             style: TextStyle(color: AppColor.textColor),
//             decoration: InputDecoration(
//               hintText: 'New Category Name',
//               hintStyle: TextStyle(color: AppColor.lightTextColor),
//               contentPadding: EdgeInsets.all(0),
//               border: OutlineInputBorder(borderSide: BorderSide.none),
//             ),
//           )),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('GO BACK', style: TextStyle(color: AppColor.textColor)),
//         ),
//         TextButton(
//             onPressed: () async{
//               myList.add(newCategoryName);
//               await DatabaseService(uid: firebaseUser.uid).updateUserCategoryList(myList)
//               .then((value) {
//                 if(value=='List Updated') {
//                   Navigator.of(context).pop();
//                   showSnackBar(context,'Category added successfully');
//                 } else {
//                   Navigator.of(context).pop();
//                   showSnackBar(context,'Something went wrong. Try Again');
//                 }
//               });
//             },
//             child: Text('ADD', style: TextStyle(color: AppColor.textColor)),
//           ),
//       ],
//     );
//   } else {
//       return AlertDialog(
//         backgroundColor: AppColor.bodyColor,
//         elevation: 4.0,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         content: SizedBox(
//           width: 150.0,
//           height: 200.0,
//           child: Center(child: Text('Fetching data...',style: Theme.of(context).textTheme.headline4)),
//           ),
//       );
//   }
  
// }

// AlertDialog deleteCategoryAlert(BuildContext context) {

//   var categoryData = Provider.of<DocumentSnapshot>(context);

//   if(categoryData!=null) {
//     List categoryList = categoryData['Category List'];
//     var isselected = List<bool>.filled(categoryList.length,false);

//     return AlertDialog(
//       backgroundColor: AppColor.bodyColor,
//       title: Text('Select an item',style: TextStyle(color: AppColor.textColor,fontSize: 20.0,fontWeight: FontWeight.w500),textAlign: TextAlign.center),
//       contentPadding: EdgeInsets.all(10.0),
//       elevation: 4.0,
//       actions: [
//         TextButton(
//           onPressed: () => Navigator.of(context).pop(),
//           child: Text('GO BACK', style: TextStyle(color: AppColor.textColor)),
//         ),
//         TextButton(
//           onPressed: () {
//             // maybe a deleteCategory parameter will store the category selected and search for that in list and delete it
//           },
//           child: Text('DELETE', style: TextStyle(color: Colors.red[500])),
//         ),
//       ],
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       content: SizedBox(
//             width: 150.0,
//             height: 200.0,
//             child: ListView.builder(
//               itemCount: categoryList.length,
//               itemBuilder: (context,index) {
//                 return Consumer<CategoryData>(
//                   builder: (_,categorydata,child) => CategoryListTileWidget(
//                     categoryName: categoryList[index],
//                     isSelected: categorydata.createList(categoryList.length)[index],
//                     onTap: () {
//                       // should select the category and also make changes in the UI
//                       categorydata.modifyList(index);
//                     },
//                   ),
//                 );
//               }
//             ),
//           ),
//     );
//   } else {
//       return AlertDialog(
//         backgroundColor: AppColor.bodyColor,
//         contentPadding: EdgeInsets.all(20.0),
//         elevation: 4.0,
//         content: SizedBox(
//           width: 150.0,
//           height: 200.0,
//           child: Center(child: Text('Fetching data...',style: Theme.of(context).textTheme.headline4)),
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       );
//   }
// }



// AlertDialog chooseCategoriesAlert(BuildContext context) {

//   var categoryData = Provider.of<DocumentSnapshot>(context);  
//   print(categoryData);
  
//   if(categoryData!=null) {
//       List categoryList = categoryData['Category List'];
//       return AlertDialog(
//         backgroundColor: AppColor.bodyColor,
//         contentPadding: EdgeInsets.all(20.0),
//         elevation: 4.0,
//         content: SizedBox(
//           width: 150.0,
//           height: 200.0,
//           child: ListView.builder(
//             itemCount: categoryList.length,
//             itemBuilder: (context,index) {
//               return Consumer<CategoryData>(
//                 builder: (_,categorydata,child) => CategoryListTileWidget(
//                   isSelected: false,
//                   categoryName: categoryList[index],
//                   onTap: () {
//                     categorydata.selectCategory(categoryList[index]);
//                     Navigator.pop(context);
//                   },
//                 ),
//               );
//             }
//           ),
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       );
//     } else {
//       return AlertDialog(
//         backgroundColor: AppColor.bodyColor,
//         contentPadding: EdgeInsets.all(20.0),
//         elevation: 4.0,
//         content: SizedBox(
//           width: 150.0,
//           height: 200.0,
//           child: Center(child: Text('Fetching data...',style: Theme.of(context).textTheme.headline4)),
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//       );
//     } 
  
// }


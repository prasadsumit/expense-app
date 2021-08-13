import 'package:flutter/material.dart';

class NewCategoryModel extends ChangeNotifier {
  
  String selectedValue = 'Grocery';
  
  List<Map> mapOfItems = [
    {"name": "Grocery",
      "isSelected" : false,
    },
    {"name": "Fish",
      "isSelected" : false,
    },
    {"name": "Vegetables",
      "isSelected" : false,
    },
    {"name": "Medical",
      "isSelected" : false,
    }
    
  ];

  List<String> categoryList = ['Grocery','Fish','Vegetables','Medical'];

  void createNewCategory(String value) {
    categoryList.add(value);
      final Map newMap = {
        "name": value,
        "isSelected" : false,
      };
      mapOfItems.add(newMap);
      notifyListeners();
  }
  void deleteCategory() {
    
    int length = categoryList.length;///very imp line, this fixed the problem
    for(int index=0; index < length; index++) {
            Map data = mapOfItems[index];
            if(data['isSelected']==true && data['name'] == selectedValue) {
                data['isSelected'] = false;
            }
            if(data['isSelected']==true && data['name'] != selectedValue) {
                categoryList.remove(data['name']);
            }
            
    }
    mapOfItems.retainWhere((element) => element['isSelected'] == false);
    notifyListeners();
  }
  void updateMapandList() {
    notifyListeners();
  }
}
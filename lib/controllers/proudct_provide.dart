import 'package:flutter/foundation.dart';

import '../models/sneaker_model.dart';
import '../services/help.dart';

class ProudctNotifier extends ChangeNotifier {
  int _activePage = 0;
  List<dynamic>_shoeSizes=[];
    final List<String>_sizes=[];

  int get activePage => _activePage;
  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }
  List<dynamic>get shoeSizes => _shoeSizes;

set shoeSizes(List<dynamic>newSizes){
  _shoeSizes=newSizes;
  notifyListeners();

}

void toggleCheck(int index){
  for(int i=0;i<_shoeSizes.length;i++){
    if(i==index){
      _shoeSizes[i]['isSelected']=!_shoeSizes[i]['isSelected'];
    }
  }
  notifyListeners();


}
List<String> get sizes=>_sizes;
set sizes(List<String>newSizes){
notifyListeners();
}
 late Future<List<Sneakers>> male;
  late Future<List<Sneakers>>female;
  late Future<List<Sneakers>>kids;
  late Future<Sneakers>snakers;

  void getMale() {
    male = Helper().getMaleSneakers();
  }

  void getFemale() {
   female = Helper().getFemaleSneakers();
  }

  void getKids() {
   kids = Helper().getKidsSneakers();
  }
  void getShoes(String category,String id ) {
    if (category == "Mens Running") {
      snakers = Helper().getMaleSneakersById(id) ;
    } else if (category == "Womens Running") {
      snakers = Helper().getFealeSneakersById(id);
    } else if (category == "Kids Running") {
      snakers = Helper().getKidsSneakersById(id) ;
    }
  }
}


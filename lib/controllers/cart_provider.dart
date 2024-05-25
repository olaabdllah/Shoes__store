import 'package:flutter/material.dart';
 //تتيح لك هذه األسطر استيراد حزم Flutter الالزمة إلنشاء التطبيق، بما في ذلك "Material "و."Hive"
import 'package:hive/hive.dart';
class CartProvider with ChangeNotifier{  //2. إنشاء الفئة "CartProvider "مع استخدام:"ChangeNotifier"
  final _cartBox = Hive.box('cart_box');//3. إنشاء متغير خاص بصندوق :Hive
  //تعتبر "CartProvider "فئة تستخدم الـ "ChangeNotifier "لتوفير إشعارات (notifications (عندما 
//يتم تغيير حالة البيانات .
  List<dynamic>_cart=[];//يتم استخدام cartBox _للوصول إلى صندوق Hive المسمى."box_cart"
//4. تعريف قائمة cart _لتخزين العناصر في السلة:
  List<dynamic>get cart=>_cart;//5. إنشاء getter للوصول إلى السلة:(cart(
  set cart(List<dynamic>newCart){
    /*. إنشاء setter لتعيين السلة (cart (وإشعار المستمعين (listeners (بالتغييرات :
    */
    _cart=newCart;
    notifyListeners();
  }
//إنشاء دالة ()getCard السترداد العناصر من صندوق Hive وتحويلها إلى قائمة من العناصر في 
//السلة:
  getCard(){
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "key": key,
        "id": item['id'],
        "category": item['category'],
        "name": item['name'],
        "imageUrl": item['imageUrl'],
        "price": item['price'],
        "qty": item['qty'],
        "sizes": item['sizes'],
      };
    }).toList();
    _cart = cartData.reversed.toList();
  }
 
  Future<void>deleteCart(int key)async{
    await _cartBox.delete(key);
  }

  int _counter=0;
  int get counter=>_counter;
  void incerment(){
    _counter++;
    notifyListeners();
  }
  void decrement (){
    if(_counter>=1){
      _counter--;
      notifyListeners();
    }
  }
}
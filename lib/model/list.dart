// Item Class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/firebase_options.dart';
import 'package:intl/intl.dart';

@immutable
class Item{
  String id;
  String name;
  String type;
  String access;
  String date;

  Item(this.id, this.name, this.type, this.access, this.date);
}



class ItemList extends ChangeNotifier{
  final user = FirebaseAuth.instance.currentUser!;

  //final Map<String, Item> _items = {};
  final List <Item> _items = [];
  // List <Item> get items => _items.values.toList();
  List <Item> get items => _items.toList();


  sort(bool ascending){
    _items.sort((item1, item2) => compareString(ascending, item1.name, item2.name));
    notifyListeners();
    print('SORTER');

  }

  sortDate(bool ascending){
    _items.sort((item1, item2) => compareString(ascending, item1.date, item2.date));
    notifyListeners();
    print('SORTER Date');

  }

  
  int compareString(bool ascending, String value1, String value2) {
    return ascending ? value1.compareTo(value2) : value2.compareTo(value1);
  }

  // fügt alle Objekte, die in der DB in _items
  Future<void> init() async{
    _items.clear();
    var list = await ListUpdater.readAll();
    list.forEach((element) {
      if(element.access.contains(user.email!)){
        //_items[element.id] = element;
        _items.add(element);
      }
    });
    notifyListeners();
    
  }

  // Neues Item erzeugen
  void create(type, name, access) async{
    var item = await ListUpdater.create(type, name, access);
    //_items[item.id] = item;
    _items.add(item);

    notifyListeners();
  }

  // Delete
  void delete(id) async{
    var list = await ListUpdater.delete(id);
    init();
    // if(list){
    //   _items.remove(id);
    //   notifyListeners();
    // }
  }

  //Update für Zugriffsrechte
  Future<void> updateAccess(Item item, String text) async {
    var ret = await ListUpdater.updateAccess(item, text);
    //_items[item.id]=ret;
    init();

    notifyListeners();
  }
  

}

class ListUpdater {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Alles auslesen
  static Future<List<Item>> readAll() async {
    //print('DEBUG: READALL');
    List<Item> list = <Item>[];
    QuerySnapshot querySnapshot = await firestore.collection('item').get();
    for(var doc in querySnapshot.docs.toList()){
      Item a =Item(doc.id, doc['name'], doc['type'],doc['access'],doc['date']);
      list.add(a);
    }
    // print('DEBUG: HIER');
    // print(list.length);
    return list;
  }

  //Item erstellen
  static Future<Item> create(type, name, access) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd.MM.yyyy, HH:mm');
    String formattedDate = formatter.format(now);
    print('DEBUG DATE: '+formattedDate);
    DocumentReference docRef = await firestore.collection('item').add({
      'name': name,
      'type': type,
      'access': access,
      'date': formattedDate,
    });
    return Item(docRef.id, name, type, access, formattedDate);
  }

  // Delete
  static Future<bool> delete(id) async{
    var ret = await firestore.collection('item').doc(id).delete();
    return true;
  }

  //Update von Access
  static Future<Item> updateAccess(Item item, String text) async {
    await firestore
        .collection('item')
        .doc(item.id)
        .update({'access':text});
    return Item(item.id, item.name, item.type, text, item.date);
  }

  // main() async{
  // List<Item> list = await readAll();
  // list.forEach((element) {
  //   print(element.getId()+'Name: '+element.getName()+', Type: '+element.type+', Access: '+element.access+', Datum: '+element.getDate());
  // });

  //}
}



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  List<Item> list = await ListUpdater.readAll();
  list.forEach((element) {
    print(element.id+'Name: '+element.name+', Type: '+element.type+', Access: '+element.access);
  });

  print('--------------------------------');
  list.forEach((element) {
    if(element.access.contains('rafael@famgeiser.de')){
      print(element.id+'Name: '+element.name+', Type: '+element.type+', Access: '+element.access);
    }
  });
}
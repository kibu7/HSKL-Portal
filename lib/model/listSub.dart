// Item Class

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/firebase_options.dart';
import 'package:intl/intl.dart';

@immutable
class ItemSub{
  String id;
  String name;
  String type;
  String date;
  String parentID;

  ItemSub(this.id, this.name, this.type, this.date, this.parentID);
}


class ItemListSub extends ChangeNotifier{
  final user = FirebaseAuth.instance.currentUser!;

  final List <ItemSub> _items = [];
  List <ItemSub> get items => _items.toList();
  
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
  Future<void> init(String str) async{
    var list = await ListUpdater.readAll();
    _items.clear();
    for (var element in list) {
      //_items[element.id] = element;
      if(element.parentID.contains(str)){
        _items.add(element);
      }
    }
    notifyListeners();
    
  }

  // Neues Item erzeugen
  void create(type, name, parentID) async{
    var item = await ListUpdater.create(type, name, parentID);
    _items.add(item);
    notifyListeners();
  }

  // Delete
  void delete(id, String parentID) async{
    var list = await ListUpdater.delete(id);
    init(parentID);
  }

}

class ListUpdater {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Alles auslesen
  static Future<List<ItemSub>> readAll() async {
    print('Sub: ReadAll - - - - - - - - - - - - - ------------------------>');
    List<ItemSub> list = <ItemSub>[];
    QuerySnapshot querySnapshot = await firestore.collection('subfolder').get();
    for(var doc in querySnapshot.docs.toList()){
      ItemSub a =ItemSub(doc.id, doc['name'], doc['type'],doc['date'],doc['parentID']);
      list.add(a);
    }
    print(list.length);
    return list;
  }

  //Item erstellen
  static Future<ItemSub> create(type, name, parentID) async {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd.MM.yyyy, HH:mm');
    String formattedDate = formatter.format(now);
    DocumentReference docRef = await firestore.collection('subfolder').add({
      'name': name,
      'type': type,
      'date': formattedDate,
      'parentID': parentID,
    });
    return ItemSub(docRef.id, name, type, formattedDate, parentID);
  }

  // Delete
  static Future<bool> delete(id) async{
    var ret = await firestore.collection('subfolder').doc(id).delete();
    return true;
  }
}
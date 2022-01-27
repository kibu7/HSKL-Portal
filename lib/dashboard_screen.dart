import 'package:flutter/material.dart';
import 'package:hskl_portal/Komponenten/add_button.dart';
import 'package:hskl_portal/Komponenten/add_buttonSub.dart';
import 'package:hskl_portal/Komponenten/filesdata.dart';
import 'package:hskl_portal/Komponenten/filesdataSub.dart';
import 'package:hskl_portal/constants.dart';

import 'Komponenten/header.dart';

//Dashboard Screen
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}



class _DashboardScreenState extends State<DashboardScreen> {
  bool state = true;
  ValueNotifier parentID = ValueNotifier('EMPTY');
  ValueNotifier parentName = ValueNotifier('EMPTY');
  
  refresh(){
    setState(() {
      state? state=false:state=true;
    });
    // print('PARENT ID:'+parentID.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children:[
                          state? const AddButton(): AddButtonSub(parentID.value),
                        ],
                      ),
                      const SizedBox(height: defaultPadding),

                      //Tabelle
                      state? FilesData(parentID, parentName, notifyParent: refresh):FilesDataSUB(parentID, parentName, notifyParent: refresh),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
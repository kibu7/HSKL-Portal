import 'package:flutter/material.dart';
import 'package:hskl_portal/Komponenten/filesdata.dart';
import 'package:hskl_portal/constants.dart';
import 'package:hskl_portal/model/listSub.dart';
import 'package:provider/provider.dart';


class FilesDataSUB extends StatefulWidget {
  ValueNotifier parentID;
  ValueNotifier parentName;
  final Function() notifyParent;
  FilesDataSUB(this.parentID, this.parentName,{Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<FilesDataSUB> createState() => _FilesDataSUBState();
}

class _FilesDataSUBState extends State<FilesDataSUB> {
  int? sortColumnIndex;
  bool isAScending = false;

  
  @override
  void initState() {
    Future(() {
      var prov = Provider.of<ItemListSub>(context, listen: false);
      prov.init(widget.parentID.value).then((value) {});
    });
    super.initState();
  }

  void onSort(int columnindex, bool ascending) {
      if (columnindex == 0) {
         Provider.of<ItemListSub>(context, listen: false).sort(ascending);
      }
      else if (columnindex == 1) {
         Provider.of<ItemListSub>(context, listen: false).sortDate(ascending);
      }

      setState(() {
        this.sortColumnIndex = columnindex;
        this.isAScending = ascending;
      });
    }

  Widget build(BuildContext context) {
    var list = context.watch<ItemListSub>();
    
    inIncluded(){

    }

    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(widget.parentName.value,
              style: TextStyle(fontSize: 30),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: DataTable(
                sortColumnIndex: sortColumnIndex,
                sortAscending: isAScending,
                horizontalMargin: 0,
                columnSpacing: defaultPadding,
                columns: [
                  DataColumn(
                    onSort: onSort,
                    label: const Text(
                      'Name',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  DataColumn(
                    onSort: onSort,
                    label: Text(
                      'Datum',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const DataColumn(
                    label: Text(
                      'Teilen',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  const DataColumn(
                      label: Text(
                    'Löschen',
                    style: TextStyle(fontSize: 22),
                  )),
                ],
                rows: List.generate(list.items.length,
                    (index) => FileDataRow(list, list.items[index],context, widget)),
              ),
              
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton BackButton() {
    return ElevatedButton.icon(onPressed: widget.notifyParent, icon: Icon(Icons.arrow_back_ios), label: Text('Zurück'),
          style: ElevatedButton.styleFrom(
            primary: primaryColor,
            padding: EdgeInsets.all(defaultPadding),
          ),
        );
  }
}

  DataRow FileDataRow(list, ItemSub item, context, FilesDataSUB widget) {
    final _formKey = GlobalKey<FormState>();
    if (item.type == 'beebusy') {
      return DataRowBeebusy(item, context, _formKey, list, widget);
    } else if (item.type == 'brainwriter') {
      return DataRowBrainwriter(item, context, _formKey, list, widget);
    } else if (item.type == 'whitebird') {
      return DataRowWhitebird(item, context, _formKey, list, widget);
    }
    return DataRowWhitebird(item, context, _formKey, list, widget);
  }


DataRow DataRowBeebusy(ItemSub item, context, GlobalKey<FormState> _formKey, list, FilesDataSUB widget) {
  return DataRow(cells: [
    DataCell(
      ListTile(
        leading: Image.asset('assets/images/beebusy.png',
            height: 25, color: Colors.white),
        title: Text(item.name, style: TextStyle(fontSize: 16)),
      ),
    ),
    DataCell(
      Text(
        item.date,
        style: TextStyle(fontSize: 16),
      ),
    ),

    DataCell(
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.share),
      ),
    ),

    // Delete Button
    DataCell(
      IconButton(
        onPressed: () {
          DialogScreenDelete(context, _formKey, item, list, widget);
        },
        icon: Icon(Icons.delete),
      ),
    ),
  ]);
}


DataRow DataRowBrainwriter(ItemSub item, context, GlobalKey<FormState> _formKey, list, FilesDataSUB widget) {
  return DataRow(cells: [
    DataCell(
      ListTile(
        leading: Image.asset('assets/images/brainwriter.png',
            height: 25, color: Colors.white),
        title: Text(item.name, style: TextStyle(fontSize: 16)),
      ),
    ),
    DataCell(
      Text(
        item.date,
        style: TextStyle(fontSize: 16),
      ),
    ),

    DataCell(
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.share),
      ),
    ),

    // Delete Button
    DataCell(
      IconButton(
        onPressed: () {
          DialogScreenDelete(context, _formKey, item, list, widget);
        },
        icon: Icon(Icons.delete),
      ),
    ),
  ]);
}


DataRow DataRowWhitebird(ItemSub item, context, GlobalKey<FormState> _formKey, list, FilesDataSUB widget) {
  return DataRow(cells: [
    DataCell(
      ListTile(
        leading: Image.asset('assets/images/whitebird.png',
            height: 25, color: Colors.white),
        title: Text(item.name, style: TextStyle(fontSize: 16)),
      ),
    ),
    DataCell(
      Text(
        item.date,
        style: TextStyle(fontSize: 16),
      ),
    ),

    DataCell(
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.share),
      ),
    ),

    // Delete Button
    DataCell(
      IconButton(
        onPressed: () {
          DialogScreenDelete(context, _formKey, item, list, widget);
        },
        icon: Icon(Icons.delete),
      ),
    ),
  ]);
}


//Abfrage vor Löschen
Future<dynamic> DialogScreenDelete(BuildContext context, GlobalKey<FormState> _formKey, ItemSub item, list, FilesDataSUB widget) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Container(
              width: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Löschen von ',
                            style: Theme.of(context).textTheme.headline5),
                        Text(item.name,
                            style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Row(
                        children: [
                          Text('Wollen Sie wirklich '+item.name+' löschen?'

                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Nein')
              ),
            ElevatedButton(
              onPressed: () {
                list.delete(item.id, item.parentID);
                Navigator.pop(context);
              },
              child: Text('Ja')
              ),  
          ],
        );
      });
}

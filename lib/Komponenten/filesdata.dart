import 'package:flutter/material.dart';
import 'package:hskl_portal/constants.dart';
import 'package:hskl_portal/model/list.dart';
import 'package:provider/provider.dart';

class FilesData extends StatefulWidget {
  ValueNotifier parentID;
  ValueNotifier parentName;
  Function() notifyParent;
  FilesData(this.parentID, this.parentName, {Key? key, required this.notifyParent})
      : super(key: key);

  @override
  State<FilesData> createState() => FilesDataState();
}

class FilesDataState extends State<FilesData> {
  int? sortColumnIndex;
  bool isAScending = false;

  @override
  void initState() {
    Future(() {
      var prov = Provider.of<ItemList>(context, listen: false);
      prov.init().then((value) {});
    });
    super.initState();
  }


  Widget build(BuildContext context) {
    var list = context.watch<ItemList>();
    
    //Sort funktioniert
    void onSort(int columnindex, bool ascending) {
      if (columnindex == 0) {
         Provider.of<ItemList>(context, listen: false).sort(ascending);
      }
      else if (columnindex == 1) {
         Provider.of<ItemList>(context, listen: false).sortDate(ascending);
      }

      setState(() {
        this.sortColumnIndex = columnindex;
        this.isAScending = ascending;
      });
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
          Padding(
            padding: EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              'HOME',
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
                      'Wer hat Zugriff?',
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
                    (index) => FileDataRow(list, list.items[index], context)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  DataRow FileDataRow(list, Item item, context) {
    final _formKey = GlobalKey<FormState>();
    if (item.type == 'folder') {
      return DataRowFolder(item, context, _formKey, list);
    } else if (item.type == 'beebusy') {
      return DataRowBeebusy(item, context, _formKey, list);
    } else if (item.type == 'brainwriter') {
      return DataRowBrainwriter(item, context, _formKey, list);
    } else if (item.type == 'whitebird') {
      return DataRowWhitebird(item, context, _formKey, list);
    }
    return DataRowFolder(item, context, _formKey, list);
  }

  DataRow DataRowFolder(Item item, context, GlobalKey<FormState> _formKey, list) {
    return DataRow(cells: [
      DataCell(
        InkWell(
          onTap: () {
            widget.parentID.value = item.id;
            widget.parentName.value = item.name;
            widget.notifyParent();
          },
          child: ListTile(
            leading: Icon(Icons.folder),
            title: Text(item.name, style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
      DataCell(
        Text(
          item.date,
          style: TextStyle(fontSize: 16),
        ),
      ),

      // Wer hat Zugriff und bearbeitung
      DataCell(
        InkWell(
          onTap: () {
            DialogScreenAccess(context, _formKey, item);
          },
          child: Text(
            item.access,
            style: TextStyle(fontSize: 16),
          ),
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
            DialogScreenDelete(context, _formKey, item, list);
            //list.delete(item.id);
          },
          icon: Icon(Icons.delete),
        ),
      ),
    ]);
  }
}

DataRow DataRowBeebusy(Item item, context, GlobalKey<FormState> _formKey, list) {
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

    // Wer hat Zugriff und bearbeitung
    DataCell(
      InkWell(
        onTap: () {
          DialogScreenAccess(context, _formKey, item);
        },
        child: Text(
          item.access,
          style: TextStyle(fontSize: 16),
        ),
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
          DialogScreenDelete(context, _formKey, item, list);
        },
        icon: Icon(Icons.delete),
      ),
    ),
  ]);
}

DataRow DataRowBrainwriter(Item item, context, GlobalKey<FormState> _formKey, list) {
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

    // Wer hat Zugriff und bearbeitung
    DataCell(
      InkWell(
        onTap: () {
          DialogScreenAccess(context, _formKey, item);
        },
        child: Text(
          item.access,
          style: TextStyle(fontSize: 16),
        ),
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
          DialogScreenDelete(context, _formKey, item, list);
        },
        icon: Icon(Icons.delete),
      ),
    ),
  ]);
}

DataRow DataRowWhitebird(Item item, context, GlobalKey<FormState> _formKey, list) {
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

    // Wer hat Zugriff und bearbeitung
    DataCell(
      InkWell(
        onTap: () {
          DialogScreenAccess(context, _formKey, item);
        },
        child: Text(
          item.access,
          style: TextStyle(fontSize: 16),
        ),
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
          DialogScreenDelete(context, _formKey, item, list);
        },
        icon: Icon(Icons.delete),
      ),
    ),
  ]);
}


//Abfrage vor Löschen
Future<dynamic> DialogScreenDelete(
    BuildContext context, GlobalKey<FormState> _formKey, Item item, list) {
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
                list.delete(item.id);
                Navigator.pop(context);
              },
              child: Text('Ja')
              ),  
          ],
        );
      });
}



//Ändern von Zugriffsrechten
Future<dynamic> DialogScreenAccess(
    BuildContext context, GlobalKey<FormState> _formKey, Item item) {
  return showDialog(
      context: context,
      builder: (context) {
        //Controller
        final _personsController = TextEditingController(text: item.access);

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
                        Text('Änderung von Zugriffsrechten',
                            style: Theme.of(context).textTheme.headline5),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        controller: _personsController,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Provider.of<ItemList>(context, listen: false)
                                .updateAccess(item, _personsController.text);
                            Navigator.of(context).pop();
                          },
                          child: const Text('Update Bestätigen'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      });
}

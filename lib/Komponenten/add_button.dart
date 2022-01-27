import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hskl_portal/constants.dart';
import 'package:hskl_portal/model/list.dart';
import 'package:provider/provider.dart';

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return PopupMenuButton(
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 2),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          //border: Border.all(color: Colors.blueAccent),
        ),
        child: Row(
          children: const [
            Icon(Icons.add_circle_outline),
            Padding(
              padding: EdgeInsets.only(left: defaultPadding),
              child: Text('Neu', style: TextStyle(fontSize: 18)),
            ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      offset: const Offset(0, 45),
      itemBuilder: (context) => <PopupMenuEntry<String>>[
        // create Folder
         PopupMenuItem(
          value: 'folder',
          child: ListTile(
            leading: Icon(Icons.folder),
            title: Text('Projekt'),
          ),
        ),

        const PopupMenuDivider(),

        //Beebusy
        PopupMenuItem(
          value: 'beebusy',
          child: ListTile(
            leading: Image.asset(whichTypePath('beebusy'),color: Colors.white, height: 25),
            title: Text('Beebusy'),
          ),
        ),

        const PopupMenuDivider(),

        //Brainwriter
        PopupMenuItem(
          value: 'brainwriter',
          child: ListTile(
            leading: Image.asset(whichTypePath('brainwriter'), color: Colors.white, height: 25),
            title: Text('Brainwriter'),
          ),
        ),

        const PopupMenuDivider(),

        //Whitebird
         PopupMenuItem(
          value: 'whitebird',
          child: ListTile(
            leading: Image.asset('assets/images/whitebird.png', height: 25),
            title: Text('Whitebird'),
          ),
        ),
      ],
      onSelected: (String value) {
        if (value == 'folder') {
          DialogScreen(context, _formKey, 'folder');
        } else if (value == 'beebusy') {
          DialogScreen(context, _formKey, 'beebusy');
        } else if (value == 'brainwriter') {
          DialogScreen(context, _formKey, 'brainwriter');
        } else if (value == 'whitebird') {
          DialogScreen(context, _formKey, 'whitebird');
        }
      },
    );
  }

  Future<dynamic> DialogScreen(
      BuildContext context, GlobalKey<FormState> _formKey, type) {
    return showDialog(
        context: context,
        builder: (context) {
          //Controllers
          final TextEditingController _nameController = TextEditingController();
          final TextEditingController _personsController =
              TextEditingController();

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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                            child: Image.asset(whichTypePath(type), height: 50, color: Colors.white),
                          ),
                          Text(whichType(type),
                              style: Theme.of(context).textTheme.headline5),
                        ],
                      ),

                      // TextField for name for the item
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(hintText: 'Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Bitte einen Namen eingeben';
                          }
                        },
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding),

                        // TextField for persons who have access to this item
                        child: TextFormField(
                          controller: _personsController,
                          decoration: const InputDecoration(
                              hintText: 'Personen einladen'),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  createItem(
                                      context,
                                      type,
                                      _nameController.text,
                                      _personsController.text);
                                  Navigator.of(context).pop();
                                }
                              },
                              child: const Text('Erstellen')),
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
}

createItem(context, type, name, persons) {
  final user = FirebaseAuth.instance.currentUser!;
  String str;
  if (persons == '') {
    str = user.email!;
  } else {
    str = persons + ', ' + user.email!;
  }

  Provider.of<ItemList>(context, listen: false).create(type, name, str);
}

String whichType(type) {
  if (type == 'folder') {
    return 'Projekt';
  } else if (type == 'beebusy') {
    return 'Beebusy';
  } else if (type == 'brainwriter') {
    return 'Brainwriter';
  } else if (type == 'whitebird') {
    return 'Whitebird';
  }
  return 'Error';
}

String whichTypePath(type) {
  if (type == 'folder') {
    return 'assets/images/folder_icon.png';
  } else if (type == 'beebusy') {
    return 'assets/images/beebusy.png';
  } else if (type == 'brainwriter') {
    return 'assets/images/brainwriter.png';
  } else if (type == 'whitebird') {
    return 'assets/images/whitebird.png';
  }
  return 'Error';
}

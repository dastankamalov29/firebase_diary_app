import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasecrudtute/design/demension.dart';
import 'package:firebasecrudtute/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //firestore
  final FirestoreService firestoreService = FirestoreService();
  //text controller

  final TextEditingController textController = TextEditingController();
  //open a dialog box to add note
  void openNoteBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //button to save
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              shadowColor: Colors.grey[600],
              elevation: 20,
            ),
            onPressed: () {
              //add a nnew note
              if (docID == null) {
                firestoreService.addNote(textController.text);
              }

              //update excisting note
              else {
                firestoreService.updateNote(docID, textController.text);
              }

              //clear the text controller
              textController.clear();

              //close the box
              Navigator.pop(context);
            },
            child: Text('Save',style: buttonStyle),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: openNoteBox,
        child: const Icon(
          Icons.add,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotesStream(),
        builder: (context, snapshot) {
          //if we have a data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  //get individual docs
                  DocumentSnapshot document = notesList[index];
                  String docID = document.id;

                  //get note from each docs
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String noteText = data['note'];

                  //display as a list tile
                  return Container(
                    alignment: Alignment.center,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      // iconColor: Colors.white,
                      // textColor: Colors.white,
                      title: Text(noteText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //update button
                          IconButton(
                            onPressed: () => openNoteBox(docID: docID),
                            icon: const Icon(Icons.settings),
                          ),
                          //delete button
                          IconButton(
                            onPressed: () => firestoreService.deleteNote(docID),
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          //if there is no data return nothing
          else {
            return const Text('No notes...');
          }
        },
      ),
    );
  }
}

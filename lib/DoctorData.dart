import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorData extends StatefulWidget {
  const DoctorData({super.key});

  @override
  State<DoctorData> createState() => _DoctorDataState();
}

class _DoctorDataState extends State<DoctorData> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 600,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final docs = snapshot.data!.docs;

              if (docs.isEmpty) {
                return Text('No doctors available.');
              }

              return Container(
                width: 200,
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doctorData =
                        docs[index].data() as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        subtitle:
                            Text("Name :" + doctorData['Name'].toString()),
                        title: Text("Id :" + doctorData['Id'].toString()),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

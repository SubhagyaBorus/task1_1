import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DoctorCategory.dart';
import 'DoctorData.dart';
import 'DoctorService.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String doctorId; // Initialize doctorId with a value

  String searchText = ''; // To store the search text

  @override
  Widget build(BuildContext context) {
    // Replace with your data source
    final categoryProvider = Provider.of<DoctorService>(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Section 1",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                Container(
                  width: 200,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchText = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 200,
                    child: FutureBuilder<List<DoctorCategory>>(
                      future: DoctorService().fetchDoctorCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container(
                            width: 200,
                            height: 200,
                            child: const CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          final categories = snapshot.data;

                          final filteredCategories = categories!
                              .where((category) =>
                                  category.name
                                      .toLowerCase()
                                      .contains(searchText.toLowerCase()) ||
                                  category.id.toString().contains(searchText))
                              .toList();
                          return ListView.builder(
                            itemCount: filteredCategories.length,
                            itemBuilder: (context, index) {
                              final category = filteredCategories[index];
                              return ListTile(
                                subtitle: Text('Name: ' + category.name),
                                title: Text('Id: ' + category.id.toString()),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    "Section 2",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                ),
                DoctorData(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    setState(() {
                      // Handle appointment booking here
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Appointment booked!'),
                      ));
                    });
                  },
                  child: Text('Book Appointment'),
                ),
                SizedBox(
                  height: 200,
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          categoryProvider.fetchDoctorCategories();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}

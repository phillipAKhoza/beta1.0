import 'package:flutter/material.dart';
import '../dto/branches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth.dart';
class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}
final BranchesData branchesData = BranchesData();
class _LocationScreenState extends State<LocationScreen> {
  // final List<int> colorCodes = <int>[600, 500, 100];
  late Future<QuerySnapshot> locationDbCall;
  @override
  void initState(){
    super.initState();
    locationDbCall = branchesData.ministriesDb.get(const GetOptions(source: Source.cache));
    locationDbCall.then((value) => {
      if(value.docs.isEmpty){
        locationDbCall = branchesData.ministriesDb.get(const GetOptions(source: Source.server))
      }
    });
  //   const GetOptions(source : Source.cache)
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Branches'),
          automaticallyImplyLeading: false,
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: locationDbCall,
          builder: (BuildContext context,  snapshot){
            if (snapshot.hasData) {

              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              if(documents.isEmpty){
                return const Center(child: Text("Branches not uploaded yet!!!",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),));
              }

              return ListView(
                  children: documents
                      .map((doc) =>

                      Card(
                        child: InkWell(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                            child: Text(
                              doc['church'],
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) {
                                  return Location(branch: doc);
                                }
                            )
                            );
                          },
                        ),
                      )).toList()
              );

            }else if (snapshot.hasError) {
              return const Center(child: Text("An Error Occurred!",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),));
            }

            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Loading...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            );


          },
        )
    );
  }
}

class Location extends StatefulWidget {
  const Location({super.key, required this.branch});
  final DocumentSnapshot branch;

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  bool? isAdmin = CurrentUser.getAdminStatus();

  @override
  void initState() {
    super.initState();
    isAdmin = CurrentUser.getAdminStatus();
  }
  @override
  Widget build(BuildContext context) {
    reset(){
      Navigator.pop(context);
    }

    deleteDoc(id) async{
      branchesData.ministriesDb.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feed removed")),
        ),
        reset()
      });
    }
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(widget.branch['church']),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                      '${widget.branch['church']}\'s Ministry',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Under the Leadership of ${widget.branch['leaders']} ',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    for (var item in widget.branch['paragraphs'] ?? [])
                      Text(
                        '\n $item',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                    Text(
                      'Contact ${widget.branch['church']} Ministry :',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    for (var item in widget.branch['contacts'])
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    // const Text('\n'),
                  ],
                ),
              ),
              if(isAdmin == true)...[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed:() => deleteDoc(widget.branch.id),
                    child: const Text('Delete'),
                  ),
                ),
              ]

            ],
          ),
        ));
  }
}

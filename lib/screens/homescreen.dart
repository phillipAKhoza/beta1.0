import 'package:flutter/material.dart';
import './screens.dart';
import 'package:flutter/services.dart';
import '../components/custom_card.dart';
import '../dto/dtobarrel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WESTSIDE",
          style: TextStyle(fontSize: 10),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_pin),
            tooltip: 'location Icon',
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return const LocationScreen();
              }))
            },
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'nitifications Icon',
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return const NoticationScreen();
              }))
            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: Transform.scale(
          scale: 1,
          child: IconButton(
            icon: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              bottom: const TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'My Feed',
                  ),
                  Tab(
                    text: 'My Journey',
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              Myfeed(),
              MyJourney(),
            ],
          ),
        ),
      ),
    );
  }
}

class Myfeed extends StatefulWidget {
  const Myfeed({super.key});

  @override
  State<Myfeed> createState() => _MyfeedState();
}

class _MyfeedState extends State<Myfeed> {
  final FeedData feedData = FeedData();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: InkWell(
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text(
                    'Church Events',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const EventsScreen();
                }));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: InkWell(
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.book_sharp),
                  title: Text(
                    'Our Church',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const Ministryscreen();
                }));
              },
            ),
          ),
          const Text(
            'YOUR FEED',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
      FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('feed_db').get(),
        builder: (BuildContext context,  snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            return Container(
              height: 550,
              child: ListView(
                  children: documents
                      .map((doc) => Card(
                      child: InkWell(
                        child: CustomCard(
                          thumbnail: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage( doc['image'] ?? 'assets/images/logo1.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: doc['title'],
                          paragraphs: [], //doc['paragraphs'] ??
                          links:  [], //doc['links'] ??
                          author:   '',
                          publishDate: '',
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute<dynamic>(
                              builder: (BuildContext context) {
                            return Feed(feed: doc);
                          }));
                        },
                      ),
                    )).toList()),
            );
            //return ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   padding: const EdgeInsets.all(10.0),
            //   itemCount:documents.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Card(
            //       child: InkWell(
            //         child: CustomCard(
            //           thumbnail: Container(
            //             decoration: BoxDecoration(
            //               image: DecorationImage(
            //                 image: AssetImage(feedData.myfeeds[index].image ??
            //                     'assets/images/logo1.png'),
            //                 fit: BoxFit.fill,
            //               ),
            //             ),
            //           ),
            //           title: feedData.myfeeds[index].title,
            //           paragraphs: feedData.myfeeds[index].paragraphs,
            //           links: feedData.myfeeds[index].links ?? [],
            //           author: feedData.myfeeds[index].author ?? '',
            //           publishDate: feedData.myfeeds[index].date,
            //         ),
            //         onTap: () {
            //           Navigator.of(context).push(MaterialPageRoute<dynamic>(
            //               builder: (BuildContext context) {
            //             return Feed(feed: feedData.myfeeds[index]);
            //           }));
            //         },
            //       ),
            //     );
            //   },
            // )
          } else if (snapshot.hasError) {
            return const Text("It's Error!");
          }
          return const Text("loading");
        },
      )
          // StreamBuilder<QuerySnapshot>(
          //     stream: FirebaseFirestore.instance.collection('feed_db').snapshots(),
          //     builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){
          //       if(snapshot.hasData) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         }
          //       }else if (snapshot.hasError){
          //         const Text('no data');
          //       }
          //       // final feedSnapshot = snapshot.data?.docs;
          //       //https://stackoverflow.com/questions/74189457/failed-to-load-providerinstaller-module-no-acceptable-module-found-local-versi
          //       return SizedBox(
          //         height: MediaQuery.of(context).size.height,
          //         child: ListView(
          //           children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //             Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          //             return Center(
          //               child: Container(
          //                 width: MediaQuery.of(context).size.width / 1.2,
          //                 height: MediaQuery.of(context).size.height / 6,
          //                 child: Text("Title: ${data['title']}"),
          //               ),
          //             );
          //           }).toList(),
          //         ),
          //       );
          // })
          // StreamBuilder<QuerySnapshot>(
          //     stream: _usersStream,
          //     builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot){
          //       if(snapshot.hasData) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const Center(
          //             child: Text('Loading'),
          //           );
          //         }
          //       }else if (snapshot.hasError){
          //         const Text('no data');
          //       }
          //       final feedSnapshot = snapshot.data?.docs;
          //       return ListView.builder(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         padding: const EdgeInsets.all(10.0),
          //         itemCount:feedSnapshot?.length,
          //         itemBuilder: (BuildContext context, int index) {
          //           return Card(
          //             child: InkWell(
          //               child: CustomCard(
          //                 thumbnail: Container(
          //                   decoration: BoxDecoration(
          //                     image: DecorationImage(
          //                       image: AssetImage(feedData.myfeeds[0].image ??
          //                           'assets/images/logo1.png'),
          //                       fit: BoxFit.fill,
          //                     ),
          //                   ),
          //                 ),
          //                 title: feedData.myfeeds[0].title ?? '',
          //                 // title: feedSnapshot?[index]['title'] ?? '',
          //                 // paragraphs: feedSnapshot?[index]['paragraphs'] ?? [],
          //                 // links: feedSnapshot?[index]['links'] ?? [],
          //                 // author: feedSnapshot?[index]['author'] ?? '',
          //                 // publishDate: feedSnapshot?[index]['date'] ?? '',
          //                 paragraphs: feedData.myfeeds[0].paragraphs,
          //                 links: feedData.myfeeds[0].links ?? [],
          //                 author: feedData.myfeeds[0].author ?? '',
          //                 publishDate: feedData.myfeeds[0].date,
          //               ),
          //               onTap: () {
          //                 Navigator.of(context).push(MaterialPageRoute<dynamic>(
          //                     builder: (BuildContext context) {
          //                   return Feed(feed: feedData.myfeeds[index]);
          //                 }));
          //               },
          //             ),
          //           );
          //         },
          //       );
          // })
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   padding: const EdgeInsets.all(10.0),
          //   itemCount:feedData.myfeeds.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Card(
          //       child: InkWell(
          //         child: CustomCard(
          //           thumbnail: Container(
          //             decoration: BoxDecoration(
          //               image: DecorationImage(
          //                 image: AssetImage(feedData.myfeeds[index].image ??
          //                     'assets/images/logo1.png'),
          //                 fit: BoxFit.fill,
          //               ),
          //             ),
          //           ),
          //           title: feedData.myfeeds[index].title,
          //           paragraphs: feedData.myfeeds[index].paragraphs,
          //           links: feedData.myfeeds[index].links ?? [],
          //           author: feedData.myfeeds[index].author ?? '',
          //           publishDate: feedData.myfeeds[index].date,
          //         ),
          //         onTap: () {
          //           Navigator.of(context).push(MaterialPageRoute<dynamic>(
          //               builder: (BuildContext context) {
          //             return Feed(feed: feedData.myfeeds[index]);
          //           }));
          //         },
          //       ),
          //     );
          //   },
          // )

        ],
      ),
    ));
  }
}

class Feed extends StatelessWidget {
  const Feed({super.key, required this.feed});
  final DocumentSnapshot feed;
  @override
  Widget build(BuildContext context) {
    final List stringParagraph = feed['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(",           ");
    final List stringLinks = feed['links'];
    final List<String> links = stringLinks[0].split(',           ');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            feed['title'] ?? "Title",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (feed['image'] != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage(feed['image'] ?? 'assets/images/logo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                      feed['title'] ?? "Title",
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
                    for (var item in paragraphs ?? [])
                      Text(
                        '\n $item',
                        maxLines: 10,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    // if (Feed.links.isNotEmpty) const Text('\n'),
                    for (var item in links ?? [])
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class MyJourney extends StatefulWidget {
  const MyJourney({super.key});

  @override
  State<MyJourney> createState() => _MyJourneyState();
}

class _MyJourneyState extends State<MyJourney> {
  final JourneyData journeyData = JourneyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        itemCount: journeyData.journey.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              child: ListTile(
                title: Text(
                  journeyData.journey[index].title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(Icons.keyboard_arrow_right),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return JourneyScreen(
                    journeyTopic: journeyData.journey[index].journeyTopic,
                    title: journeyData.journey[index].title);
              }));
            },
          );
        },
      ),
    );
  }
}

//MyJourney

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
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

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
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: feedData.myfeeds.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: CustomCard(
                    thumbnail: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(feedData.myfeeds[index].image ??
                              'assets/images/logo1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: feedData.myfeeds[index].title,
                    paragraphs: feedData.myfeeds[index].paragraphs,
                    links: feedData.myfeeds[index].links ?? [],
                    author: feedData.myfeeds[index].author ?? '',
                    publishDate: feedData.myfeeds[index].date,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) {
                      return Feed(feed: feedData.myfeeds[index]);
                    }));
                  },
                ),
              );
            },
          )
      // StreamBuilder<QuerySnapshot>(
      //   stream: _usersStream,
      //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //     // if (snapshot.hasError) {
      //     //   return Text('Something went wrong');
      //     // }
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Text("Loading");
      //     }
      //     return ListView.builder(
      //       shrinkWrap: true,
      //       physics: const NeverScrollableScrollPhysics(),
      //       padding: const EdgeInsets.all(10.0),
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return Card(
      //           child: InkWell(
      //             child: CustomCard(
      //               thumbnail: Container(
      //                 decoration: BoxDecoration(
      //                   image: DecorationImage(
      //                     image: AssetImage(feedData.myfeeds[index].image ??
      //                         'assets/images/logo1.png'),
      //                     fit: BoxFit.fill,
      //                   ),
      //                 ),
      //               ),
      //               title: feedData.myfeeds[index].title,
      //               paragraphs: feedData.myfeeds[index].paragraphs,
      //               links: feedData.myfeeds[index].links ?? [],
      //               author: feedData.myfeeds[index].author ?? '',
      //               publishDate: feedData.myfeeds[index].date,
      //             ),
      //             onTap: () {
      //               Navigator.of(context).push(MaterialPageRoute<dynamic>(
      //                   builder: (BuildContext context) {
      //                     return Feed(feed: feedData.myfeeds[index]);
      //                   }));
      //             },
      //           ),
      //         );
      //       },
      //     );
      //     //   ListView(
      //     //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
      //     //     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      //     //     return ListTile(
      //     //       title: Text(data['title']),
      //     //       subtitle: Text(data['author']),
      //     //     );
      //     //   }).toList(),
      //     // );
      //   },
      // )
        ],
      ),
    ));
  }
}

class Feed extends StatelessWidget {
  const Feed({super.key, required this.feed});
  final FeedDto feed;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            feed.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (feed.image != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage(feed.image ?? 'assets/images/logo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  feed.title,
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
                    for (var item in feed.paragraphs)
                      Text(
                        '\n $item',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    // if (Feed.links.isNotEmpty) const Text('\n'),
                    for (var item in feed.links ?? [])
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

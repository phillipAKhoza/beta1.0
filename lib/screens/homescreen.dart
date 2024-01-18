import 'package:flutter/material.dart';
import './screens.dart';
import 'package:flutter/services.dart';
import '../components/custom_card.dart';
import '../dto/dto-barrel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/auth.dart';

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
            tooltip: 'notifications Icon',
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return const NotificationScreen();
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
final FeedData feedData = FeedData();
class _MyfeedState extends State<Myfeed> {
   late Future<QuerySnapshot> feedDbCall;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    feedDbCall = feedData.feedsDb.get(const GetOptions(source : Source.cache));
  }
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
                  return const MinistryScreen();
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
        future: feedDbCall,
        builder: (BuildContext context,  snapshot) {
          if (snapshot.hasData) {
            // <3> Retrieve `List<DocumentSnapshot>` from snapshot
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            if(documents.isEmpty){
              return const Center(child: Text("No Feeds",style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
              ),));
            }
            return SizedBox(
              height: 550,
              child: ListView(
                  children: documents
                      .map((doc) => Card(
                      child: InkWell(
                        child: CustomCard(
                          thumbnail:
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: doc['image'].contains("http") ? NetworkImage(doc['image']) : AssetImage( doc['image'] ?? 'assets/images/logo1.png') as ImageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          title: doc['title'],
                          paragraphs: const [], //doc['paragraphs'] ??
                          links:  const [], //doc['links'] ??
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
          } else if (snapshot.hasError) {
            return const Center(child: Text("It's Error!",style: TextStyle(
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

        ],
      ),
    ));
  }
}
final AdminData adminData = AdminData();
class Feed extends StatefulWidget {
  const Feed({super.key, required this.feed});
  final DocumentSnapshot feed;
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
      feedData.feedsDb.doc(id).delete().then((value) => {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Feed removed")),
        ),
        reset()
      });
    }
    final List stringParagraph = widget.feed['paragraphs'];
    final List<String> paragraphs = stringParagraph[0].split(".,");
    final List stringLinks = widget.feed['links'];
    final List<String> links = stringLinks[0].split('.,');
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            widget.feed['title'] ?? "Title",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.feed['image'] != null) ...[
                if(widget.feed['image'].contains("http"))...[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.feed['image']),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ]else ...[
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage(widget.feed['image'] ?? 'assets/images/logo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                ],
              ],
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                      widget.feed['title'] ?? "Title",
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
                    for (var item in paragraphs)
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
                    for (var item in links)
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
              ),
              if(isAdmin == true)...[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    onPressed:() => deleteDoc(widget.feed.id),
                    child: const Text('Delete'),
                  ),
                ),
              ]

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

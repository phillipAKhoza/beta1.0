import 'package:flutter/material.dart';
import './screens.dart';
import 'package:flutter/services.dart';
import '../dto/journeydto.dart';
import '../components/custom_card.dart';
import '../dto/visual_dto.dart';

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
  final FoundatioData foundationData = FoundatioData();

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
                    'Ministries',
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
            itemCount: foundationData.foundations.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: InkWell(
                  child: CustomCard(
                    thumbnail: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              foundationData.foundations[index].image ??
                                  'assets/images/logo1.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    title: foundationData.foundations[index].title,
                    paragraphs: foundationData.foundations[index].paragraphs,
                    links: foundationData.foundations[index].links ?? [],
                    author: foundationData.foundations[index].author ?? '',
                    publishDate: foundationData.foundations[index].date,
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute<dynamic>(
                        builder: (BuildContext context) {
                      return Foundation(
                          foundation: foundationData.foundations[index]);
                    }));
                  },
                ),
              );
            },
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

import 'package:flutter/material.dart';
import '../dto/journeydto.dart';

class JourneyScreen extends StatelessWidget {
  const JourneyScreen(
      {super.key, required this.journeyTopic, required this.title});
  final List<JourneyTopicDto> journeyTopic;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(title),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        itemCount: journeyTopic.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            child: Card(
              child: ListTile(
                title: Text(
                  journeyTopic[index].topic,
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
                return JourneyTopicScreen(journeyTopic: journeyTopic[index]);
              }));
            },
          );
        },
      ),
    );
  }
}

class JourneyTopicScreen extends StatelessWidget {
  const JourneyTopicScreen({super.key, required this.journeyTopic});
  final JourneyTopicDto journeyTopic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(journeyTopic.topic),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      journeyTopic.topic,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      '\n ${journeyTopic.scripture}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var item in journeyTopic.verses)
                          Text(
                            '\n $item',
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const Text(
                          '\n DAILY THOUGHT',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // if (journeyTopic.dailyThoughts.isNotEmpty) const Text('\n'),
                        for (var item in journeyTopic.dailyThoughts)
                          Text(
                            '\n $item',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        const Text(
                          '\n REFLECT',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (var item in journeyTopic.reflect)
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 0.0),
                            child: Text(
                              '\n $item',
                              style: const TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        const Text(
                          '\n PRAYER',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (var item in journeyTopic.prayer)
                          Text(
                            '\n $item',
                            style: const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

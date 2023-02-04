import 'package:flutter/material.dart';
import '../components/normal_list.dart';
import '../dto/visual_dto.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventData eventData = EventData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Church Events'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(2.0),
          itemCount: eventData.events.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                child: NormalList(
                  title: eventData.events[index].title,
                  paragraphs: eventData.events[index].paragraphs,
                  links: eventData.events[index].links ?? [],
                  author: eventData.events[index].author ?? '',
                  publishDate: eventData.events[index].date,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return Event(event: eventData.events[index]);
                  }));
                },
              ),
            );
          },
        ));
  }
}

class Event extends StatelessWidget {
  const Event({super.key, required this.event});
  final VisualDto event;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Event'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (event.image != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage(event.image ?? 'assets/images/logo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  event.title,
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
                    for (var item in event.paragraphs)
                      Text(
                        '\n $item',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    if (event.links != null) const Text('\n'),
                    for (var item in event.links ?? [])
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                    if (event.author != null)
                      Text(
                        event.author ?? '',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      'Event Date: ${event.date}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
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

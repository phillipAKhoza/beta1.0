import 'package:flutter/material.dart';
import '../components/normal_list.dart';
import '../dto/visual_dto.dart';

class NoticationScreen extends StatefulWidget {
  const NoticationScreen({super.key});

  @override
  State<NoticationScreen> createState() => _NoticationScreenState();
}

class _NoticationScreenState extends State<NoticationScreen> {
  final NotificationData notificationData = NotificationData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notifications'),
          automaticallyImplyLeading: false,
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(2.0),
          itemCount: notificationData.notifications.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: InkWell(
                child: NormalList(
                  title: notificationData.notifications[index].title,
                  paragraphs: notificationData.notifications[index].paragraphs,
                  links: notificationData.notifications[index].links ?? [],
                  author: notificationData.notifications[index].author ?? '',
                  publishDate: notificationData.notifications[index].date,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return Notification(
                        notification: notificationData.notifications[index]);
                  }));
                },
              ),
            );
          },
        ));
  }
}

class Notification extends StatelessWidget {
  const Notification({super.key, required this.notification});
  final VisualDto notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Notification'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (notification.image != null)
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          notification.image ?? 'assets/images/logo1.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  notification.title,
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
                    for (var item in notification.paragraphs)
                      Text(
                        '\n $item',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                        ),
                      ),
                    // if (notification.links.isNotEmpty) const Text('\n'),
                    for (var item in notification.links ?? [])
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                    if (notification.author != null)
                      Text(
                        notification.author ?? '',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Text(
                      notification.date,
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

import 'package:flutter/material.dart';
import '../components/formBarell.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: AdminItems(),
    );
  }
}
class AdminItems extends StatefulWidget {
  const AdminItems({super.key});

  @override
  State<AdminItems> createState() => _AdminItemsState();
}

class _AdminItemsState extends State<AdminItems> {
  final List<String> item = <String>[
    'Feed',
    'Event',
    'Notification',
    'Stream',
    'Salvation Journey',
    'Foundation',
    'Location',
    'Ministries',
  ];
  final List<String> path = <String>[
    '/admin_Feeds',
    '/admin_Events',
    '/admin_Notifications',
    '/admin_Stream',
    '/admin_Salvation_Journey',
    '/admin_Foundations',
    '/admin_Location',
    '/admin_Kids',
    '/admin_Men',
    '/admin_Women',
    '/admin_Youth',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
        ),
        body: ListView.builder(
          shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          // padding: const EdgeInsets.all(10.0),
          itemCount: item.length,
          itemBuilder: (BuildContext context, int index) {
            return
              Card(
                  child: ListTile(
                    // leading: Icon(Icons.${icon[index]}),
                    title: Text(item[index]),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                            return AdminFormScreen(section: item[index],);
                          }));
                    },
                  ));
          }));
  }
}

class AdminFormScreen extends StatelessWidget {
  const AdminFormScreen({super.key, required this.section});
  final String section;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$section screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if(section == "Feed" || section == "Foundation" || section == "Notification" || section == "Event")...[
               SizedBox(
                height: 850,
                  child:  FoundationFeed(screen:section)
              ),
              ] else if(section =="Location"|| section =="Ministries")...[
                 SizedBox(
                    height: 850,
                    child: BranchesForm(screen:section)
                ),
              ]else if(section == "Salvation Journey")...[
                const SizedBox(
                    height: 850,
                    child: JourneyForm()
                ),
              ]else if(section == "Stream")...[
                 SizedBox(
                  height: 850,
                  child: StreamForm(screen:section)
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}


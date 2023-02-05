import 'package:flutter/material.dart';
import '../dto/ministrydto.dart';

class Ministryscreen extends StatefulWidget {
  const Ministryscreen({super.key});

  @override
  State<Ministryscreen> createState() => _MinistryscreenState();
}

class _MinistryscreenState extends State<Ministryscreen> {
  final MinistriesData ministriesData = MinistriesData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Our Church'),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '\n Church Ministries \n',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                child: const Card(
                  child: ListTile(
                    title: Text(
                      'KIDS',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) {
                    return const KidsMinistry();
                  }));
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(1),
                itemCount: ministriesData.ministries.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Card(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        child: Text(
                          ministriesData.ministries[index].church,
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<dynamic>(
                          builder: (BuildContext context) {
                        return Minitry(
                            ministry: ministriesData.ministries[index]);
                      }));
                    },
                  );
                },
              ),
            ],
          ),
        ));
  }
}

class Minitry extends StatelessWidget {
  const Minitry({super.key, required this.ministry});
  final Ministries ministry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(ministry.church),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Center(
                    child: Text(
                  '${ministry.church}\'s Ministry',
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
                        'Under the Leadership of ${ministry.leaders} ',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    for (var item in ministry.paragraphs ?? [])
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
                    // Text(
                    //   '${ministry.church} is located at:',
                    //   style: const TextStyle(
                    //     fontSize: 12.0,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black54,
                    //   ),
                    // ),
                    // for (var item in ministry.address)
                    //   Text(
                    //     item,
                    //     style: const TextStyle(
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.bold,
                    //       color: Colors.black54,
                    //     ),
                    //   ),
                    Text(
                      'Contact ${ministry.church} Ministry :',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    for (var item in ministry.contacts)
                      Text(
                        item,
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    const Text('\n'),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class KidsMinistry extends StatelessWidget {
  const KidsMinistry({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('KIDS MINISTRY'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text("kids Screen"),
      ),
    );
  }
}

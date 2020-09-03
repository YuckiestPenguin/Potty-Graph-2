import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pottygraph2/models/activity.dart';
import 'package:pottygraph2/screens/new_activity.dart';
import 'package:provider/provider.dart';
import '../models/activity.dart';
import '../providers/activity_provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Activities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final activities = Provider.of<List<Activity>>(context);
    final activityProvider = Provider.of<ActivityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewActivity(),
                ),
              );
            },
          )
        ],
      ),
      body: (activities != null && activities.length > 0)
          ? ListView.builder(
              itemCount: activities.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        if (activities[index].pee)
                          FaIcon(
                            FontAwesomeIcons.tint,
                            color: Colors.yellow[600],
                          ),
                        if (activities[index].poo)
                          FaIcon(FontAwesomeIcons.poo,
                              color: Colors.brown[400]),
                      ],
                    ),
                    title: activities[index].name != null
                        ? Text(activities[index].name)
                        : Text('Description not available',
                            style: TextStyle(fontStyle: FontStyle.italic)),
                    subtitle: Text(timeago
                        .format(DateTime.tryParse(activities[index]
                            .activityTimestamp
                            .toDate()
                            .toString()))
                        .toString()),
                    trailing: IconButton(
                      color: Colors.red[300],
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        activityProvider
                            .deleteActivity(activities[index].activityId);
                      },
                    ),
                  ),
                );
              })
          : Center(child: Text('Nothing Here!')),
    );
  }
}

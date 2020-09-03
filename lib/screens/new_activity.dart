import 'package:flutter/material.dart';
import 'package:pottygraph2/providers/activity_provider.dart';
import 'package:provider/provider.dart';

class NewActivity extends StatefulWidget {
  @override
  _NewActivityState createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  bool pee = false;
  bool poo = false;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    nameController.text = '';

    // Gives the ability to access the provider without context and resets values at the state level. Delayed future is needed so it can run right after build and not throw errors
    new Future.delayed(Duration.zero, () {
      final activityProvider =
          Provider.of<ActivityProvider>(context, listen: false);
      activityProvider.changePee(false);
      activityProvider.changePoo(false);
    });
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

// Method to calculate the greeting message based on time of day
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning Walk';
    }
    if (hour < 17) {
      return 'Afternoon Walk';
    }
    return 'Evening Walk';
  }

  @override
  Widget build(BuildContext context) {
    final activityProvider = Provider.of<ActivityProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('New Activity')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Activity Name'),
              onChanged: (value) {
                activityProvider.changeName(value);
              },
            ),
            CheckboxListTile(
              title: Text('Pee?'),
              value: pee,
              onChanged: (value) {
                pee = value;
                activityProvider.changePee(value);
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text('Poo?'),
              value: poo,
              onChanged: (value) {
                poo = value;
                activityProvider.changePoo(value);
                setState(() {});
              },
            ),
            SizedBox(
              height: 10,
            ),
            if (nameController.text != '' && nameController.text != null)
              RaisedButton(
                onPressed: () {
                  activityProvider.saveActivity();
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              )
          ],
        ),
      ),
    );
  }
}

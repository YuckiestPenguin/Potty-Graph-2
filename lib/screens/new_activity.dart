import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pottygraph2/providers/activity_provider.dart';
import 'package:provider/provider.dart';

class NewActivity extends StatefulWidget {
  @override
  _NewActivityState createState() => _NewActivityState();
}

class _NewActivityState extends State<NewActivity> {
  bool pee = false;
  bool poo = false;
  bool treat = false;
  bool meal = false;
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
      activityProvider.changeTreat(false);
      activityProvider.changeMeal(false);
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
              secondary:
                  FaIcon(FontAwesomeIcons.tint, color: Colors.yellow[600]),
              value: pee,
              onChanged: (value) {
                pee = value;
                activityProvider.changePee(value);
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text('Poo?'),
              secondary: FaIcon(FontAwesomeIcons.poo, color: Colors.brown[400]),
              value: poo,
              onChanged: (value) {
                poo = value;
                activityProvider.changePoo(value);
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text('Treat?'),
              secondary:
                  FaIcon(FontAwesomeIcons.cookieBite, color: Colors.pink[200]),
              value: treat,
              onChanged: (value) {
                treat = value;
                activityProvider.changeTreat(value);
                setState(() {});
              },
            ),
            CheckboxListTile(
              title: Text('Meal?'),
              secondary:
                  FaIcon(FontAwesomeIcons.utensils, color: Colors.green[400]),
              value: meal,
              onChanged: (value) {
                meal = value;
                activityProvider.changeMeal(value);
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

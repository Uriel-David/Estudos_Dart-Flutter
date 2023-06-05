import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var settings = Settings();

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile.adaptive(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuration'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Configuration',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _createSwitch(
                  'No Gluten',
                  'Show only gluten-free foods.',
                  settings.isGlutenFree,
                  (value) => setState((() => settings.isGlutenFree = value)),
                ),
                _createSwitch(
                  'No Lactose',
                  'Show only lactose-free foods.',
                  settings.isLactoseFree,
                  (value) => setState((() => settings.isLactoseFree = value)),
                ),
                _createSwitch(
                  'Vegan',
                  'Show only vegan foods.',
                  settings.isVegan,
                  (value) => setState((() => settings.isVegan = value)),
                ),
                _createSwitch(
                  'Vegetarian',
                  'Show only vegetarian foods.',
                  settings.isVegetarian,
                  (value) => setState((() => settings.isVegetarian = value)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

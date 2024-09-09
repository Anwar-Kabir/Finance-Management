import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesView extends StatefulWidget {
  const SharedPreferencesView({super.key});

  @override
  SharedPreferencesViewState createState() => SharedPreferencesViewState();
}

class SharedPreferencesViewState extends State<SharedPreferencesView> {
  Map<String, Object> _sharedPrefsData = {};

  @override
  void initState() {
    super.initState();
    _loadAllSharedPrefsData();
  }

  Future<void> _loadAllSharedPrefsData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    Map<String, Object> data = {};
    for (String key in keys) {
      final value = prefs.get(key);
      if (value != null) {
        data[key] = value;
      }
    }

    setState(() {
      _sharedPrefsData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences Data'),
      ),
      body: _sharedPrefsData.isEmpty
          ? const Center(child: Text('No data in SharedPreferences'))
          : ListView.builder(
              itemCount: _sharedPrefsData.length,
              itemBuilder: (context, index) {
                String key = _sharedPrefsData.keys.elementAt(index);
                Object value = _sharedPrefsData[key]!;
                return ListTile(
                  title: Text(key),
                  subtitle: Text(value.toString()),
                );
              },
            ),
    );
  }
}

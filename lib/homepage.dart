import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _nameController = TextEditingController();
  late String _nameValue = "";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _nameValue = "No value";
    _getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preference"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 200,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _saveValue();
              },
              child: Text("Save"),
            ),
            SizedBox(height: 20),
            Text(_nameValue),
          ],
        ),
      ),
    );
  }

  void _saveValue() async {
    var name = _nameController.text;
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString("name", name);
    setState(() {
      _nameValue = name;
    });
  }

  void _getValue() async {
    var prefs = await SharedPreferences.getInstance();
    var getName = prefs.getString("name");
    setState(() {
      _nameValue = getName != null ? getName : "No value";
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}

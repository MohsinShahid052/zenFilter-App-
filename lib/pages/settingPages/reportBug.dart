import 'package:flutter/material.dart';
import '../settings.dart';

class ReportBug extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Report a Bug',
      theme: ThemeData(
        fontFamily: "Montserrat",
        scaffoldBackgroundColor: Colors.black, // Set background color to black
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white), // Set text color to white
        ),
      ),
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.orange, // Set app bar background color to orange
        title: const Text('Report a bug'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Add back arrow icon
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SettingPage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Your Logo
              Container(
                alignment: Alignment.center,
                child: Image.asset(
                  'images/icon.png', // Replace with your logo asset path
                  height: 100.0, // Adjust the height as needed
                ),
              ),
              const SizedBox(height: 46),
              // Your Form
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTextField('Name', nameController),
                    const SizedBox(height: 16),
                    buildTextField('Email', emailController),
                    const SizedBox(height: 16),
                    buildMultilineTextField('Message', messageController),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight, // Align to the right
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process the form data
                            // You can access the form fields using:
                            // nameController.text
                            // emailController.text
                            // messageController.text
                            print('Form submitted');
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.black), // Set text color to black
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white), // Set text color to white
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Colors.orange), // Set label color to orange
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.orange), // Set border color to orange
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget buildMultilineTextField(
      String label, TextEditingController controller) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white), // Set text color to white
        maxLines: 4,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
              color: Colors.orange), // Set label color to orange
          focusedBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.orange), // Set border color to orange
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }
}

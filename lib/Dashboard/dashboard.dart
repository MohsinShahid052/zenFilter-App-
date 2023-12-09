import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatelessWidget {
  final List<String> imgSrc = [
    "images/p3.png",
    "images/history.png",
    "images/web.png",
    "images/phone.png",
    "images/help.png",
    "images/about.png",
  ];

  final List<String> imgNames = [
    "Preferences",
    "History",
    "Block Web",
    "Block App",
    "Help",
    "About Us",
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        color: const Color(0xFFF79817),
        height: height,
        width: width,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.03,
                right: width * 0.03,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.sort,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    size: width * 0.1,
                  ),
                  Container(
                    height: height * 0.07,
                    width: height * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.04),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      image: const DecorationImage(
                        image: AssetImage("images/woman.png"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: height * 0.03,
                left: width * 0.05,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: width * 0.08,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    "Recent Open Time: " +
                        DateFormat.jm().format(DateTime.now()),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            LimitedBox(
              maxHeight: height * 0.020,
              child: Container(
                width: width,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(height * 0.05),
                    topRight: Radius.circular(height * 0.05),
                  ),
                ),
                height: height * 0.8,
                width: width,
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.1,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(15),
                      itemCount: imgSrc.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemDetailsPage(
                                  imagePath: imgSrc[index],
                                  itemName: imgNames[index],
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 255, 255, 255),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 1,
                                  blurRadius: 6,
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: Image.asset(imgSrc[index]),
                                ),
                                Text(
                                  imgNames[index],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        color: Color(0xFFF79817),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Copyright by Zenfilter',
                style: TextStyle(color: Colors.black),
              ),
              Text(
                '  |  Developed by HMS',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemDetailsPage extends StatelessWidget {
  final String imagePath;
  final String itemName;

  const ItemDetailsPage({
    Key? key,
    required this.imagePath,
    required this.itemName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imagePath),
          const SizedBox(height: 20),
          Text(
            itemName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

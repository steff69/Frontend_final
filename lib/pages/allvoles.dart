import 'package:flutter/material.dart';
import 'package:travel_app/Models%202/voleModel.dart';
import 'package:travel_app/pages/MainScreen.dart';

class AllVolesPage extends StatelessWidget {
  AllVolesPage({super.key, required this.alldataList});
  List<FlightData> alldataList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ));
            },
            child: Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 700,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) => Carrd(item: alldataList[index]),
            separatorBuilder: (context, index) =>
                const Padding(padding: EdgeInsets.only(right: 10)),
            itemCount: alldataList.length,
          ),
        ),
      ),
    );
  }
}

class Carrd extends StatelessWidget {
  Carrd({super.key, required this.item});
  FlightData item;
  @override
  Widget build(BuildContext context) {
    void _showReserveDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Reserve Vole'),
            content: Text('Do you want to reserve this vole?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text('Reserve'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Perform reservation action and close the dialog
                  // Add reservation logic here if needed
                },
              ),
            ],
          );
        },
      );
    }

    return Container(
      margin: EdgeInsets.all(15),
      child: GestureDetector(
        onTap: () {
          _showReserveDialog(context);
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          shadowColor: Colors.black54,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Travel Itinerary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From: ${item.from}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              '${item.from}',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '---------->',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '${item.from}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(' ${item.date}')
                      ],
                    ),
                    Icon(
                      Icons.airplanemode_active,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Duration: ${item.time}',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

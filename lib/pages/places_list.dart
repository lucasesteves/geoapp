import 'package:flutter/material.dart';
import 'package:geo_app/pages/add_place.dart';
import 'package:provider/provider.dart';
import '../provider/great_places.dart';

class PlaceListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addplace');
              //Navigator.push(context,MaterialPageRoute(builder: (context) => AddPlacePage()));
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('There´s nothing to show'),
                ),
                builder: (context, greatPlaces, ch) =>
                    greatPlaces.items.length <= 0
                        ? ch
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              subtitle: Text('Lat: ${greatPlaces.items[index].location.latitude} & Long:${greatPlaces.items[index].location.longitude}'),
                              onTap: () {},
                            ),
                          ),
              ),
      ),
    );
  }
}

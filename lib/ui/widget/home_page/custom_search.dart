import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sneaker_app/service/firestore_service/firestore_product.dart';
import 'package:sneaker_app/ui/view/search_page.dart';

class CustomSearch extends SearchDelegate {
  List<String> allData = ['Adidas', 'Nike', 'Vans', 'Baleciaga'];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.immersive,
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   

    return Container();
  }

  @override
  void showResults(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(suggestion: query),
      ),
    );
    super.showResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("products").get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<String> _brands =
              FirestoreProduct().getBrand(snapshot.data!.docs);
          List<String> _matchQuery = [];
          for (var item in _brands) {
            if (item.toLowerCase().contains(query.toLowerCase())) {
              _matchQuery.add(item);
            }
          }
          return ListView.builder(
            itemCount: _matchQuery.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  String result = _matchQuery[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(suggestion: result),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(_matchQuery[index]),
                ),
              );
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

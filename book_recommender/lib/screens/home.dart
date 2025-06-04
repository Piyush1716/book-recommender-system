
import 'package:book_recommender/services/api_services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Book> books = [];
  @override
  void initState() {
    super.initState();
    books = ApiServices().fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300], 
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[850],
              ),
              // height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "My Book Recommender",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Home    ",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "Recommend",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Text("Top 50 Books", style: TextStyle(color : Colors.black,fontSize: 30, fontWeight: FontWeight.bold),),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              books[index].imageUrl,
                              height: 160,
                            ),
                          ),
                          Text(
                            books[index].title,
                            style: TextStyle(
                              fontSize: 14,
                              color : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center
                            ),
                          Text('by ${books[index].author}'),
                          Text(
                            '⭐ ${(books[index].avgRating).toStringAsFixed(3)}',
                          ),
                          Text('(${books[index].numRatings} ratings)'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

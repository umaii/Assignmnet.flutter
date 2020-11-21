import 'package:Assignment/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RootPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Posts(),
    );
  }
}

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<Post> postList = new List<Post>();
  bool loaded = true;

  Future<List<Post>> getPostList() async {
    String URL = 'https://jsonplaceholder.typicode.com/posts';

    http.Response response = await http.get(URL);

    final String responseString = response.body;
    //  print(responseString);
    postList = postFromJson(responseString);
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() async {
    await getPostList();
    setState(() {
      loaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () {}),
              Text(
                "Explore",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(icon: Icon(Icons.search), onPressed: () {})
            ],
          ),
          loaded
              ? Center(child: Text('Loading'))
              : Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: postList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Kristin Jones",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.more_horiz),
                                onPressed: () {},
                              ),
                              subtitle: Text('20 Minutes Ago'),
                              leading: CircleAvatar(
                                backgroundImage: AssetImage('images/1.jpg'),
                                radius: 20,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: Column(
                                      children: [
                                        IconButton(
                                            icon: Icon(
                                              Icons.messenger_outline,
                                              color: Colors.blue[300],
                                            ),
                                            onPressed: () {}),
                                        Text(
                                          '2253',
                                          style: TextStyle(
                                              color: Colors.grey[300]),
                                        ),
                                        IconButton(
                                            icon: Icon(
                                              Icons.favorite_border_outlined,
                                              color: Colors.pink[300],
                                            ),
                                            onPressed: () {}),
                                        Text(
                                          '4522',
                                          style: TextStyle(
                                              color: Colors.grey[300]),
                                        )
                                      ],
                                    )),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          postList.elementAt(index).body,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.asset(
                                          "images/1.jpg",
                                          width: double.infinity,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      }),
                )
        ],
      ),
    ));
  }
}

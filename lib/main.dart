import 'package:Assignment/posts.dart';
import 'package:Assignment/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

const kLargeTextStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);
const kTitleTextStyle = TextStyle(
  fontSize: 16,
  color: Color.fromRGBO(129, 165, 168, 1),
);
const kSmallTextStyle = TextStyle(
  fontSize: 16,
);
void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.white,
    ),
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sen',
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String firstName = '', lastName = '', imageURL = '', text = '';

  Future<User> getUserProfile() async {
    final String URL = 'https://reqres.in/api/users/2';
    http.Response response = await http.get(URL);

    final String responseString = response.body;
    return userFromJson(responseString);
  }

  @override
  void initState() {
    setData();
  }

  void setData() async {
    User userResponse = await getUserProfile();

    setState(() {
      firstName = userResponse.data.firstName;
      lastName = userResponse.data.lastName;
      imageURL = userResponse.data.avatar;
      text = userResponse.support.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 35, 15, 15),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('images/6.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  firstName + ' ' + lastName,
                  style: kLargeTextStyle,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  text,
                  style: kTitleTextStyle,
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    PostFollower(
                      number: 80,
                      title: 'Posts',
                    ),
                    PostFollower(
                      number: 110,
                      title: 'Followers',
                    ),
                    PostFollower(
                      number: 152,
                      title: 'Following',
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Posts()));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Color.fromRGBO(30, 65, 255, 1),
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              'Message',
                              style: TextStyle(
                                color: Color.fromRGBO(30, 65, 255, 1),
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(30, 65, 255, 1),
                              border: Border.all(
                                width: 2,
                                color: Color.fromRGBO(30, 65, 255, 1),
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: Text(
                                'Follow',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: <Widget>[
                    GalleryImage(
                      imagePath: 'images/1.jpg',
                    ),
                    GalleryImage(
                      imagePath: 'images/2.jpg',
                    ),
                    GalleryImage(
                      imagePath: 'images/3.jpg',
                    ),
                    GalleryImage(
                      imagePath: 'images/4.jpg',
                    ),
                    GalleryImage(
                      imagePath: 'images/5.jpg',
                    ),
                    GalleryImage(
                      imagePath: 'images/6.jpg',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GalleryImage extends StatelessWidget {
  final String imagePath;

  GalleryImage({@required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class PostFollower extends StatelessWidget {
  final int number;
  final String title;

  PostFollower({@required this.number, @required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          number.toString(),
          style: kLargeTextStyle,
        ),
        Text(
          title,
          style: kSmallTextStyle,
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color containerColor;

  SocialButton(
      {@required this.icon,
      @required this.iconColor,
      @required this.containerColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 7,
      ),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: containerColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
    );
  }
}
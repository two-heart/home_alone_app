import 'package:flutter/material.dart';
import 'package:home_alone/view/widgets/themed_button.dart';
import 'package:package_info/package_info.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(context),
                ..._buildBulletPoints(context),
                Expanded(
                  child: Container(),
                ),
                ..._buildButtons(context)
              ],
            )));
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Willkommen bei home_alone!', // TODO get app name from package info
      style: Theme.of(context).textTheme.display2,
    );
  }

  List<Widget> _buildBulletPoints(BuildContext context) {
    return [
      Text(
        'hier erwartet dich',
        style: Theme.of(context).textTheme.display1,
      ),
      ListTile(
        leading: new MyBullet(),
        title: new Text('bla'),
      ),
      ListTile(
        leading: new MyBullet(),
        title: new Text('blub'),
      ),
      ListTile(
        leading: new MyBullet(),
        title: new Text('123'),
      )
    ];
  }

  List<Widget> _buildButtons(context) {
    return [
      SizedBox(
          width: double.infinity,
          child: ThemedButton(
            onPressed: () => {},
            child: Text('Registieren'),
          )),
      SizedBox(
          width: double.infinity,
          child: FlatButton(
            child: Text("Login"),
            onPressed: () => {Navigator.pushNamed(context, '/login')},
          ))
    ];
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('App Logo'),
    );
  }
}


// just as a placeholder... to make it look like the mock
class MyBullet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}

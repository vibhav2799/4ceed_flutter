import 'package:flutter/material.dart';
import '../pages/create_new.dart';
import './user_info.dart';

class MenuButton extends StatefulWidget {
  final VoidCallback onPressedFunction;
  String type;
  final String id;

  // Here I am receiving the function in constructor as params
  MenuButton(this.onPressedFunction, type, id);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton>
    with SingleTickerProviderStateMixin {

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    widget.onPressedFunction();
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    print(isOpened);
  }

  Widget getOpenActionContainer(type, icon) {

      return Container(
        child: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => Navigator.push(
                        context, 
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new CreateForm(type)
                          )),
        tooltip: 'Create '+type,
        icon: Icon(icon),
        label: Text('Create '+type.toString().toUpperCase())
      ),
    );
  }

  Widget getClosedActionContainer(type, icon) {
      return Container(
      child: FloatingActionButton(
        heroTag: null,
        onPressed: () => Navigator.push(
                        context, 
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new CreateForm(type, )
                          )),
        tooltip: 'Create '+type,
        child: Icon(icon),
      ),
    );
  }



  Widget space() {
    return isOpened ? getOpenActionContainer("space", Icons.home) : getClosedActionContainer("space", Icons.home);
  }

  Widget collection() {
    return isOpened ? getOpenActionContainer("collection", Icons.book) : getClosedActionContainer("collection", Icons.book);
  }

  Widget dataset() {
    return isOpened ? getOpenActionContainer("dataset", Icons.folder) : getClosedActionContainer("dataset", Icons.folder);
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: null,        
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Menu Options',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Opacity(
      opacity: 1.0,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: space(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: collection(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value,
            0.0,
          ),
          child: dataset(),
        ),
        toggle(),
      ],
    )
    );
  }
}
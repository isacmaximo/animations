import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Animations",
      debugShowCheckedModeBanner: false,
      home: LogoApp(),
    );
  }
}

//Widget statefull
class LogoApp extends StatefulWidget {
  @override
  _LogoAppState createState() => _LogoAppState();
}

//SingleTickerProviderStateMixin informa toda vez que a tela é renderizada
class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  //controlador da animação
  AnimationController controller;

  //declarando a animação
  Animation<double> animation;

  //init state que vai iniciar com o controlador da animação
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    //inicializando a animação
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    //notifica a mudança do estado
    animation.addStatusListener((status) {
      //se a animação tiver sido completada
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }

      //se a animação tiver sido de tras pra frente
      else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });

    //o forward  quer dizer animar pára frente, quaso queira animar atrás usar o reverse
    controller.forward();
  }

  //para não ficar consumindo recursos damos um dispose no controller
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //layout
  @override
  Widget build(BuildContext context) {
    return AnimatedLogo(animation);
  }
}

//Widget animated
class AnimatedLogo extends AnimatedWidget {
  //O construtor do AnimatedLogo recebe uma animação e é passada para o construtor do AnimatedWidget
  AnimatedLogo(Animation<double> animation) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;

    return Center(
      child: Container(
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }
}

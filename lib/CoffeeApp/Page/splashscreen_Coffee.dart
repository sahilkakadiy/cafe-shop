import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Login_Coffee.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Navigate to the next screen after the animation
    Future.delayed(const Duration(seconds: 5), () {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomeScreen(),
      //     ));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Login(),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ));
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Image.network(
              'https://png.pngtree.com/thumb_back/fw800/background/20201226/pngtree-black-coffee-texture-background-image_515859.jpg',
              fit: BoxFit.cover,
            ),
            // Animated widget
            Positioned(
              child: Center(
                child: FadeTransition(
                  opacity: _animation,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(
                        'https://image.winudf.com/v2/image1/Y29tLmNvZmZlZWxvZ29pZGVhcy5oZnppbmNfc2NyZWVuXzBfMTU4NDc5MDMzNl8wMzU/screen-0.webp?fakeurl=1&type=.webp'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
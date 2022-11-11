import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '410638067_image',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Sample images from Wikimedia Commons:
  static const List<String> _imgs = [
    'http://5b0988e595225.cdn.sohucs.com/images/20171102/eb38a50d458c4c1d97d2da06e09c63bf.jpeg',
    'https://i.epochtimes.com/assets/uploads/2020/03/7efbabad6589f9b5dd1198aeef684f56.png',
    'https://p1-bk.byteimg.com/tos-cn-i-mlhdmxsy5m/4b9b8d0ce3ad46f3a97792c68d5ccbf3~tplv-mlhdmxsy5m-q75:0:0.image',
    'https://tevrapet.com/wp-content/uploads/2020/12/AdobeStock_219316170-1024x683.jpeg',
  ];

  int _counter = 0;
  bool _clear = true;
  bool _error = false;

  void _incrementCounter() {
    setState(() {
      if (_clear || _error) {
        _clear = _error = false;
      } else {
        _counter = (_counter + 1) % _imgs.length;
      }
    });
  }

  void _clearImage() {
    setState(() {
      _clear = true;
      _error = false;
    });
  }

  void _testError() {
    setState(() => _error = true);
  }

  @override
  Widget build(BuildContext context) {
    String? url;
    if (_error) {
      url = 'error.jpg';
    } else if (!_clear) {
      url = _imgs[_counter];
    }



    return Scaffold(
      appBar: AppBar(title: Text('410638067_image')),
      body: Stack(children: <Widget>[
        Positioned.fill(
            child: ImageFade(
              // whenever the image changes, it will be loaded, and then faded in:
              image: url == null ? null : NetworkImage(url),

              // slow-ish fade for loaded images:
              duration: const Duration(milliseconds: 900),

              // if the image is loaded synchronously (ex. from memory), fade in faster:
              syncDuration: const Duration(milliseconds: 150),

              // supports most properties of Image:
              alignment: Alignment.center,





              // shown behind everything:
              placeholder: Container(
                color: const Color(0xFFCFCDCA),
                alignment: Alignment.center,
                child: const Icon(Icons.photo, color: Colors.white30, size: 128.0),
              ),

              // shows progress while loading an image:
              loadingBuilder: (context, progress, chunkEvent) =>
                  Center(child: CircularProgressIndicator(value: progress)),

              // displayed when an error occurs:
              errorBuilder: (context, error) => Container(
                color: const Color(0xFF6F6D6A),
                alignment: Alignment.center,
                child:
                const Icon(Icons.warning, color: Colors.black26, size: 128.0),

              ),
            ))
      ]),
      floatingActionButton:
      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Next',
          child: const Icon(Icons.navigate_next),
        ),
        const SizedBox(width: 10.0),
        FloatingActionButton(
          onPressed: _clearImage,
          tooltip: 'Clear',
          child: const Icon(Icons.clear),
        ),
        const SizedBox(width: 10.0),
        FloatingActionButton(
          onPressed: _testError,
          tooltip: 'Error',
          child: const Icon(Icons.warning),
        ),
      ]),
    );
  }
}
class SnackBarPage extends StatelessWidget {
  const SnackBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: const Text('柯基!'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
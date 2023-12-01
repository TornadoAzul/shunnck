import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shunnck/screens/firma.dart';
import 'package:shunnck/screens/genesis.dart';

class ImagenScreen extends StatefulWidget {
  const ImagenScreen({Key? key}) : super(key: key);

  @override
  State<ImagenScreen> createState() => _ImagenScreenState();
}

class _ImagenScreenState extends State<ImagenScreen> {
  final Color _appBarTextColor = Colors.white;
  String _appVersion = '1.0.0';
  String _currentHour = '';
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), _updateHour);
  }

  void _stopTimer() {
    _timer.cancel();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  void _updateHour(Timer timer) {
    final now = DateTime.now().toUtc().subtract(const Duration(hours: 4));
    final formattedHour = DateFormat('hh:mm').format(now);

    setState(() {
      _currentHour = formattedHour;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const GenesisView(),
        ));
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
        body: Stack(
          children: [
            Image.asset(
              'assets/images/img.estado.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(10, 40, 40, 40),
                    Color.fromARGB(255, 30, 30, 30),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GenesisView()),
                        );
                      },
                      child: SvgPicture.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? "assets/images/shunnck-cla.svg"
                            : "assets/images/shunnck-cla.svg",
                        height: 18,
                      ),
                    ),
                  ),
                  iconTheme: IconThemeData(
                    color: _appBarTextColor,
                  ),
                  actionsIconTheme: IconThemeData(
                    color: _appBarTextColor,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 220),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onDoubleTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const FirmaView()),
                              );
                            },
                            child: const Text(
                              "CIDRA",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFFF8F8F8),
                                  fontSize: 160,
                                  fontFamily: "CAG",
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            _currentHour,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Color(0xFFF8F8F8),
                              fontSize: 25,
                              letterSpacing: 5,
                              fontFamily: "PON",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Text(
                _appVersion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFF8F8F8),
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "MAY",
                ),
              ),
            ),
            Positioned(
              bottom: 35,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 50,
                child: Image.asset(
                  'assets/images/ceresfera-b.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

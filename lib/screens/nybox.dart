import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shunnck/screens/genesis.dart';
import 'package:shunnck/screens/home.dart';
import '../generated/l10n.dart';

class NyboxView extends StatefulWidget {
  final String? initialText;

  const NyboxView({Key? key, this.initialText}) : super(key: key);

  @override
  State<NyboxView> createState() => _NyboxViewState();
}

class _NyboxViewState extends State<NyboxView> {
  late TextEditingController _textEditingController;
  late FocusNode _textFocusNode;
  double _opacityLevel = 1.0;
  late Timer _opacityTimer;

  @override
  void initState() {
    super.initState();
    _startOpacityTimer();
    _textEditingController =
        TextEditingController(text: widget.initialText ?? '');
    _textFocusNode = FocusNode();
    _openKeyboard();
  }

  void _startOpacityTimer() {
    _opacityTimer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      setState(() {
        _opacityLevel = _opacityLevel == 1 ? 0.6 : 1;
      });
    });
  }

  @override
  void dispose() {
    _opacityTimer.cancel();
    _textEditingController.dispose();
    _textFocusNode.dispose();
    super.dispose();
  }

  void _handleSubmitted(String userInput) {
    final isLink = Uri.tryParse(userInput)?.hasScheme ?? false;

    if (isLink) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(url: userInput),
        ),
      );
    } else {
      final homeScreenUrl = 'https://duckduckgo.com/?q=$userInput';
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(url: homeScreenUrl),
        ),
      );
    }

    _textEditingController.clear();
  }

  void _openKeyboard() {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_textFocusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const GenesisView()),
          (route) => false,
        );
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Ionicons.chevron_back_outline,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Center(
            child: SvgPicture.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? "assets/images/shunnck-cla.svg"
                  : "assets/images/shunnck-osc.svg",
              height: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Ionicons.shield_checkmark,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).colorScheme.onBackground
                    : Theme.of(context).primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: AnimatedOpacity(
          opacity: _opacityLevel,
          duration: const Duration(seconds: 1),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: TextField(
              controller: _textEditingController,
              focusNode: _textFocusNode,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).scaffoldBackgroundColor,
                hintText: S.current.buscar,
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 50,
                  height: 1.3,
                  fontFamily: 'PON',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 50,
                height: 1.3,
                fontFamily: "PON",
              ),
              maxLines: null,
              textInputAction: TextInputAction.go,
              onSubmitted: _handleSubmitted,
            ),
          ),
        ),
      ),
    );
  }
}

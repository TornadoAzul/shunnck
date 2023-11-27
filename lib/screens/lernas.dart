import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shunnck/generated/l10n.dart';
import 'dart:convert';

import 'package:shunnck/screens/nybox.dart';

class LernasView extends StatefulWidget {
  @override
  _LernasViewState createState() => _LernasViewState();
}

class _LernasViewState extends State<LernasView> {
  List<Map<String, dynamic>> _searchResults = [];
  final PageController _pageController = PageController(initialPage: 0);
  bool _isLoading = true;
  bool _isSpanish = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    _isSpanish = locale.languageCode == 'es';

    // Llamar a _fetchWikipediaResults aquí después de obtener el idioma
    _fetchWikipediaResults();
  }

  Future<void> _fetchWikipediaResults() async {
    final apiUrl = Uri.parse(_isSpanish
        ? "https://es.wikipedia.org/w/api.php?format=json&action=query&generator=random&grnnamespace=0&prop=revisions|images&rvprop=content&grnlimit=5"
        : "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=random&grnnamespace=0&prop=revisions|images&rvprop=content&grnlimit=5");

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final pages = body['query']['pages'] as Map<String, dynamic>;
        final List<Map<String, dynamic>> results = [];

        for (var pageId in pages.keys) {
          final description = await _fetchDescription(int.parse(pageId));
          final title = pages[pageId]['title'] ?? '';

          results.add({
            'title': title,
            'description': description,
            'pageId': pageId,
          });
        }

        // Verificar si el widget todavía está montado antes de llamar a setState
        if (mounted) {
          setState(() {
            _searchResults = results;
            _isLoading = false;
          });
        }
      } else {
        // Verificar si el widget todavía está montado antes de llamar a setState
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      // Verificar si el widget todavía está montado antes de llamar a setState
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String> _fetchDescription(int pageId) async {
    final descriptionApiUrl = Uri.parse(_isSpanish
        ? "https://es.wikipedia.org/w/api.php?action=query&format=json&prop=extracts|info&pageids=$pageId&explaintext=true"
        : "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=extracts|info&pageids=$pageId&explaintext=true");

    try {
      final response = await http.get(descriptionApiUrl);

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final page = body['query']['pages'][pageId.toString()];
        final description = page['extract'] ?? '';

        return description;
      }
    } catch (e) {}

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        _isLoading
            ? Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  size: 57,
                ),
              )
            : _buildPageContent(),
      ]),
    );
  }

  Widget _buildPageContent() {
    if (_searchResults.isEmpty) {
      return Padding(
        padding: EdgeInsets.only(left: 19.0, right: 19.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Ionicons.alert_circle,
                size: 45,
              ),
              const SizedBox(height: 10),
              Text(
                S.current.sanjuannoalavista,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                S.current.sinconexion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final title = _searchResults[index]['title'] ?? 'Título no disponible';
        final description =
            _searchResults[index]['description'] ?? 'Descripción no disponible';

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NyboxView(initialText: title),
              ),
            );
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    Theme.of(context).brightness == Brightness.dark
                        ? "assets/images/shunnck-cla.svg"
                        : "assets/images/shunnck-osc.svg",
                    height: 18,
                  ),
                  const SizedBox(height: 17),
                  Text(
                    title,
                    maxLines: 7,
                    style: const TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Wikipedia",
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: "SJ",
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class CustomAnimatedGradient extends StatefulWidget {
  @override
  _CustomAnimatedGradientState createState() => _CustomAnimatedGradientState();
}

class _CustomAnimatedGradientState extends State<CustomAnimatedGradient>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    _colorAnimation = ColorTween(
      begin: isDarkMode ? const Color(0xFF282828) : const Color(0xFFFFFFFF),
      end: isDarkMode ? const Color(0xFF777777) : const Color(0xFFFF7791),
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final color = _colorAnimation.value;

        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1.2,
              colors: [
                color!,
                Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF282828)
                    : const Color(0xFFFFFFFF),
              ],
            ),
          ),
          child: child,
        );
      },
      child: SizedBox.expand(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

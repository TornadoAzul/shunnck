import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shunnck/data/chi.dart';
import 'package:shunnck/screens/genesis.dart';
import 'package:shunnck/screens/lernas.dart';
import 'package:shunnck/screens/nfc.dart';
import 'package:shunnck/screens/nybox.dart';
import 'package:shunnck/views/imagen.dart';
import '../generated/l10n.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.url}) : super(key: key);

  final String? url;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AfterLayoutMixin<HomeScreen> {
  late FocusNode _searchFieldFocus;
  late InAppWebViewController _webViewController;
  late String _currentUrl = "https://intsplay.com/shunnck";
  bool _isLoading = false;
  late TextEditingController _searchController;
  String? scannedUrl;
  bool _isDesktopMode = false;
  List<String> _webLinks = [];
  bool _isSecure = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.url);
    if (widget.url != null) {
      _currentUrl = widget.url!;
    }
    _loadWebLinks();
    _searchFieldFocus = FocusNode();
  }

  Future<void> _checkIfSecure(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      setState(() {
        _isSecure = response.statusCode < 400;
      });
    } catch (e) {
      setState(() {
        _isSecure = false;
      });
    }
  }

  Future<void> _loadWebLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _webLinks = prefs.getStringList('web_links') ?? [];
    });
  }

  void _openSearchBar() {
    _searchFieldFocus.requestFocus(); // Enfoca el TextField

    Future.delayed(const Duration(milliseconds: 50), () {
      _searchController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _searchController.text.length,
      );
    });
  }

  void _saveWebLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Add the current URL to the list of web links if it's not already present
    if (!_webLinks.contains(_currentUrl)) {
      _webLinks.add(_currentUrl);
    }
    await prefs.setStringList('web_links', _webLinks);
  }

  Future<List<String>> _getGuardasList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final guardas = prefs.getStringList('guardas') ?? [];
    return guardas;
  }

  IconData _getGuardaIcon(String addedCodes) {
    final int parsedIdentifier = int.tryParse(addedCodes) ?? -1;
    return chi.contains(parsedIdentifier)
        ? Ionicons.prism_outline
        : Ionicons.medical_outline;
  }

  void _eliminarGuarda(int index) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final guardas = prefs.getStringList('guardas') ?? [];

    if (index >= 0 && index < guardas.length) {
      guardas.removeAt(index);
      await prefs.setStringList('guardas', guardas);
      setState(() {});
    }
  }

  void _ajustes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<String>>(
          future: _getGuardasList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final guardasList = snapshot.data!;
              return Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 15,
                          right: 15,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Ionicons.medical,
                            color: Theme.of(context).colorScheme.onBackground,
                            size: 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 15,
                          bottom: 10,
                          right: 15,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.current.todosguardas,
                            style: TextStyle(
                              fontSize: 22,
                              height: 1.2,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ),
                      for (int index = 0; index < guardasList.length; index++)
                        Dismissible(
                          key: Key(guardasList[index]),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Theme.of(context).primaryColor,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Ionicons.trash_bin_outline,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                          ),
                          onDismissed: (direction) {
                            _eliminarGuarda(index);
                          },
                          child: ListTile(
                            leading: Icon(
                              _getGuardaIcon(guardasList[index]),
                              size: 28,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                            title: Text(
                              guardasList[index],
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                                fontSize: 22,
                              ),
                            ),
                            onTap: () {},
                          ),
                        ),
                      ListTile(
                        leading: Icon(
                          Ionicons.add_circle_outline,
                          color: Theme.of(context).colorScheme.onBackground,
                          size: 28,
                        ),
                        title: Text(
                          S.current.agregarguarda,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onBackground,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NFCView()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Text(S.current.nohaydatos);
            }
          },
        );
      },
    );
  }

  void _red(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(left: 23, right: 23),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Ionicons.heart,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 70,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    S.current.modocorazon,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.2,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _mostrarVentanas(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 15,
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Ionicons.bookmarks,
                        color: Theme.of(context).colorScheme.onBackground,
                        size: 40,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 15,
                      bottom: 10,
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        S.current.mispestanas,
                        style: TextStyle(
                          fontSize: 25,
                          height: 1.2,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      _saveWebLinks();
                      Navigator.pop(context);
                    },
                    leading: const Icon(
                      Ionicons.add,
                      size: 26,
                    ),
                    title: Text(
                      S.current.guardar,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _webLinks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(_webLinks[index]),
                          onDismissed: (direction) {
                            _removeWebLink(_webLinks[index]);
                          },
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Theme.of(context).primaryColor,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Ionicons.trash_bin_outline,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                          child: ListTile(
                            title: Text(
                              _webLinks[index],
                              style: const TextStyle(fontSize: 22),
                            ),
                            leading: const Icon(
                              Ionicons.planet_outline,
                              size: 25,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _selectAllText() {
    Future.delayed(Duration.zero, () {
      _searchController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _searchController.text.length,
      );
    });
  }

  void _addWebLink(String link) {
    if (!_webLinks.contains(link)) {
      setState(() {
        _webLinks.add(link);
        _saveWebLinks();
      });
    }
  }

  void _goBack() {
    _webViewController.goBack();
  }

  void _goForward() {
    _webViewController.goForward();
  }

  void _refresh() {
    _webViewController.reload();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    _isSecure ? Ionicons.shield_checkmark : Ionicons.warning,
                    color: _isSecure
                        ? Theme.of(context).colorScheme.secondary
                        : Theme.of(context).primaryColor,
                    size: 25,
                  ),
                  title: Text(
                    _isSecure ? S.current.estasseguro : S.current.noestasseguro,
                    style: TextStyle(
                        color: _isSecure
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context).primaryColor,
                        fontSize: 22),
                  ),
                  onTap: () {
                    _goBack();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Ionicons.laptop_outline,
                    color: _isDesktopMode
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                  title: Text(
                    S.current.modoescritorio,
                    style: TextStyle(
                      color: _isDesktopMode
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                      fontSize: 22,
                      fontWeight:
                          _isDesktopMode ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isDesktopMode = !_isDesktopMode;
                    });
                    _webViewController.setOptions(
                      options: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                          preferredContentMode: _isDesktopMode
                              ? UserPreferredContentMode.DESKTOP
                              : UserPreferredContentMode.MOBILE,
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Ionicons.arrow_back_outline,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                  title: Text(
                    S.current.atras,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22),
                  ),
                  onTap: () {
                    _goBack();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Ionicons.arrow_forward_outline,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                  title: Text(
                    S.current.siguientepagina,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22),
                  ),
                  onTap: () {
                    _goForward();
                    Navigator.pop(
                        context); // Cierra el BottomSheet después de la acción
                  },
                ),
                ListTile(
                  leading: Icon(
                    Ionicons.reload_outline,
                    color: Theme.of(context).colorScheme.onBackground,
                    size: 25,
                  ),
                  title: Text(
                    S.current.recargar,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22),
                  ),
                  onTap: () {
                    _refresh();
                    Navigator.pop(
                        context); // Cierra el BottomSheet después de la acción
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _removeWebLink(String link) {
    setState(() {
      _webLinks.remove(link);
      _saveWebLinks();
    });
  }

  void _openNyboxView(BuildContext context) async {
    final userInput = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const NyboxView()),
    );

    if (userInput != null) {
      handleSubmitted(userInput);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadUrl(String url) async {
    await _webViewController.loadUrl(
        urlRequest: URLRequest(url: Uri.parse(url)));
  }

  void handleSubmitted(String userInput) {
    final uri = Uri.tryParse(userInput);
    if (uri != null && uri.scheme.isNotEmpty) {
      loadUrl(userInput);
    } else {
      final searchQuery = Uri.encodeComponent(userInput);
      loadUrl('https://duckduckgo.com/?q=$searchQuery');
    }
    _searchController.clear();
  }

  Future<bool> onWillPop() async {
    if (await _webViewController.canGoBack()) {
      _webViewController.goBack();
      return true;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GenesisView(),
        ),
      );
      return false;
    }
  }

  void _showNoConnectionPage() {
    final String noConnectionHtml = 'assets/no_connection.html';

    _webViewController.loadFile(
      assetFilePath: noConnectionHtml,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget nybox;

    if (_currentUrl.isEmpty) {
      nybox = LernasView();
    } else {
      nybox = Stack(children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(_currentUrl)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                preferredContentMode: UserPreferredContentMode.MOBILE,
                javaScriptEnabled: true,
                cacheEnabled: false,
                clearCache: false,
                useOnDownloadStart: true),
          ),
          onDownloadStartRequest: (controller, url) async {},
          onWebViewCreated: (controller) async {
            _webViewController = controller;
            _webViewController.addJavaScriptHandler(
              handlerName: 'alert',
              callback: (args) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Alerta'),
                    content: Text(args[0]),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(S.current.lotengo),
                      ),
                    ],
                  ),
                );
              },
            );
            final String? link =
                ModalRoute.of(context)?.settings.arguments as String?;
            if (link != null) {
              loadUrl(link);
            }
            final options = await _webViewController.getOptions();
            if (options != null) {
              setState(() {
                _isDesktopMode = options.crossPlatform.preferredContentMode ==
                    UserPreferredContentMode.DESKTOP;
              });
            }
            _refresh();
          },
          onLoadStart: (controller, url) {
            setState(() {
              _isLoading = true;
              _currentUrl = url.toString();
            });
            _checkIfSecure(url.toString());
          },
          onLoadStop: (controller, url) async {
            setState(() {
              _isLoading = false;
              _currentUrl = url.toString();
            });
            controller.getTitle().then((title) {
              setState(() {});
            });
          },
        ),
      ]);
    }

    if (scannedUrl != null) {
      loadUrl(scannedUrl!);
      scannedUrl = null;
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              _red(context);
            },
            onLongPress: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ImagenScreen(),
                ),
              );
            },
            child: Icon(
              Ionicons.heart_outline,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: GestureDetector(
              child: TextField(
                onTap: () {
                  _selectAllText();
                },
                controller: TextEditingController(text: _currentUrl),
                focusNode: _searchFieldFocus,
                onChanged: (newUrl) {
                  _currentUrl = newUrl;
                },
                onSubmitted: handleSubmitted,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 21,
                ),
                decoration: InputDecoration(
                  hintText: S.current.url,
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onBackground,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Ionicons.bookmarks_outline,
                color: Theme.of(context).colorScheme.secondary,
              ),
              onPressed: () {
                _mostrarVentanas(context);
              },
            ),
          ],
        ),
        body: nybox,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Ionicons.menu_outline,
                        color: Theme.of(context).colorScheme.secondary),
                    onPressed: () {
                      _showBottomSheet(context);
                    },
                  ),
                  GestureDetector(
                    onLongPress: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GenesisView()),
                      );
                    },
                    child: IconButton(
                      icon: Icon(
                        Ionicons.search_outline,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () {
                        _openSearchBar();
                      },
                    ),
                  ),
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: _currentUrl));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          content: Text(
                            S.current.copiado,
                            style: TextStyle(
                              fontFamily: "PON",
                              fontSize: 20,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                    child: IconButton(
                      icon: Icon(
                        Ionicons.arrow_undo_outline,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      onPressed: () async {
                        await Share.share(_currentUrl);
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: _isLoading ? null : 0.0,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _selectAllText();
  }
}

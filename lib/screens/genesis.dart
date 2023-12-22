import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shunnck/generated/l10n.dart';
import 'package:shunnck/screens/home.dart';
import 'package:shunnck/screens/lernas.dart';
import 'package:shunnck/screens/nybox.dart';
import 'package:shunnck/screens/qrcode.dart';
import 'package:shunnck/views/imagen.dart';

class GenesisView extends StatefulWidget {
  const GenesisView({Key? key}) : super(key: key);

  @override
  State<GenesisView> createState() => _GenesisViewState();
}

class _GenesisViewState extends State<GenesisView> {
  late BuildContext _context;
  List<String> _webLinks = [];
  String _appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadWebLinks();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  Future<void> _loadWebLinks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _webLinks = prefs.getStringList('web_links') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
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
              cursorColor: Theme.of(context).primaryColor,
              cursorRadius: const Radius.circular(20),
              onSubmitted: _handleSubmitted,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                hintText: S.current.buscar,
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
      body: LernasView(),
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
                  icon: Icon(Ionicons.arrow_back_outline,
                      color: Theme.of(context).colorScheme.onTertiary),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        content: Text(
                          S.current.nohaynadaatras,
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
                ),
                IconButton(
                  icon: Icon(
                    Ionicons.menu_outline,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onPressed: () {
                    _mostrarAcciones(context);
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
                      Ionicons.sparkles_outline,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NyboxView()),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Ionicons.reload_outline,
                      color: Theme.of(context).colorScheme.onTertiary),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        content: Text(
                          S.current.nohaynadaquerecargar,
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
                ),
                IconButton(
                  icon: Icon(
                    Ionicons.arrow_undo_outline,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        content: Text(
                          S.current.nopuedescompartir,
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
                ),
              ],
            ),
          ],
        ),
      ),
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

  void _handleSubmitted(String userInput) {
    String url;

    if (Uri.tryParse(userInput)?.isAbsolute ?? false) {
      url = userInput;
    } else {
      url = 'https://duckduckgo.com/?q=$userInput';
    }

    Navigator.pushReplacement(
      _context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(url: url),
      ),
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
                    leading: Icon(
                      Ionicons.add,
                      size: 26,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    title: Text(
                      S.current.guardar,
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _webLinks.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(_webLinks[index]),
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
                            onTap: () {
                              _handleSubmitted(_webLinks[index]);
                            },
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

  void _mostrarAcciones(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      top: 15,
                      bottom: 10,
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(
                        Theme.of(context).brightness == Brightness.dark
                            ? "assets/images/shunnck-cla.svg"
                            : "assets/images/shunnck-osc.svg",
                        height: 23,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      bottom: 10,
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _appVersion,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.2,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _codRecup(context);
                    },
                    leading: Icon(
                      Ionicons.shield_outline,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 26,
                    ),
                    title: const Text(
                      "CodRecup",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => QRCodeScreen()),
                      );
                    },
                    leading: Icon(
                      Ionicons.qr_code_outline,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 26,
                    ),
                    title: const Text(
                      "OjoQR",
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen(
                                  url:
                                      "https://intsplay.com/holowide/politicas/",
                                )),
                      );
                    },
                    leading: Icon(
                      Ionicons.document_lock_outline,
                      color: Theme.of(context).colorScheme.onBackground,
                      size: 26,
                    ),
                    title: Text(
                      S.current.aceptar,
                      style: const TextStyle(fontSize: 22),
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

  void _codRecup(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      bottom: 10,
                      right: 15,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "CodRecup",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Ionicons.power_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 26,
                    ),
                    title: Text(
                      S.current.bloqueoiniciado,
                      style: TextStyle(
                          fontSize: 22,
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: Text(
                      S.current.bloqueocr,
                      style: TextStyle(fontSize: 22),
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
}

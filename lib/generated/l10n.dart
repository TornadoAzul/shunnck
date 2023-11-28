// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Search here`
  String get buscar {
    return Intl.message(
      'Search here',
      name: 'buscar',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to the Internet!`
  String get buscareninternet {
    return Intl.message(
      'Welcome to the Internet!',
      name: 'buscareninternet',
      desc: '',
      args: [],
    );
  }

  /// `By using Shunnck, you accept our policies.`
  String get politicas {
    return Intl.message(
      'By using Shunnck, you accept our policies.',
      name: 'politicas',
      desc: '',
      args: [],
    );
  }

  /// `Read policies`
  String get aceptar {
    return Intl.message(
      'Read policies',
      name: 'aceptar',
      desc: '',
      args: [],
    );
  }

  /// `Everything is ready!`
  String get todolisto {
    return Intl.message(
      'Everything is ready!',
      name: 'todolisto',
      desc: '',
      args: [],
    );
  }

  /// `Let's explore!`
  String get aexplorar {
    return Intl.message(
      'Let\'s explore!',
      name: 'aexplorar',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get siguiente {
    return Intl.message(
      'Next',
      name: 'siguiente',
      desc: '',
      args: [],
    );
  }

  /// `Hello, this link is copied.`
  String get copiado {
    return Intl.message(
      'Hello, this link is copied.',
      name: 'copiado',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this moment?`
  String get confirmacioneliminar {
    return Intl.message(
      'Are you sure you want to delete this moment?',
      name: 'confirmacioneliminar',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get confirmar {
    return Intl.message(
      'Yes',
      name: 'confirmar',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get cancelar {
    return Intl.message(
      'No',
      name: 'cancelar',
      desc: '',
      args: [],
    );
  }

  /// `Saved`
  String get guardado {
    return Intl.message(
      'Saved',
      name: 'guardado',
      desc: '',
      args: [],
    );
  }

  /// `Add a title to the tab`
  String get agregarnombre {
    return Intl.message(
      'Add a title to the tab',
      name: 'agregarnombre',
      desc: '',
      args: [],
    );
  }

  /// `Save site`
  String get guardar {
    return Intl.message(
      'Save site',
      name: 'guardar',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelarpelao {
    return Intl.message(
      'Cancel',
      name: 'cancelarpelao',
      desc: '',
      args: [],
    );
  }

  /// `My sites`
  String get mispestanas {
    return Intl.message(
      'My sites',
      name: 'mispestanas',
      desc: '',
      args: [],
    );
  }

  /// `No tabs saved yet!`
  String get nohaypestanas {
    return Intl.message(
      'No tabs saved yet!',
      name: 'nohaypestanas',
      desc: '',
      args: [],
    );
  }

  /// `Secure!`
  String get estasseguro {
    return Intl.message(
      'Secure!',
      name: 'estasseguro',
      desc: '',
      args: [],
    );
  }

  /// `This website is not secure!`
  String get noestasseguro {
    return Intl.message(
      'This website is not secure!',
      name: 'noestasseguro',
      desc: '',
      args: [],
    );
  }

  /// `Desktop mode`
  String get modoescritorio {
    return Intl.message(
      'Desktop mode',
      name: 'modoescritorio',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get atras {
    return Intl.message(
      'Back',
      name: 'atras',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get siguientepagina {
    return Intl.message(
      'Next',
      name: 'siguientepagina',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get recargar {
    return Intl.message(
      'Reload',
      name: 'recargar',
      desc: '',
      args: [],
    );
  }

  /// `URL`
  String get url {
    return Intl.message(
      'URL',
      name: 'url',
      desc: '',
      args: [],
    );
  }

  /// `I got it!`
  String get lotengo {
    return Intl.message(
      'I got it!',
      name: 'lotengo',
      desc: '',
      args: [],
    );
  }

  /// `Here you will find all the guardas you have saved in this Holowide.`
  String get todosguardas {
    return Intl.message(
      'Here you will find all the guardas you have saved in this Holowide.',
      name: 'todosguardas',
      desc: '',
      args: [],
    );
  }

  /// `Add guarda`
  String get agregarguarda {
    return Intl.message(
      'Add guarda',
      name: 'agregarguarda',
      desc: '',
      args: [],
    );
  }

  /// `No data available!`
  String get nohaydatos {
    return Intl.message(
      'No data available!',
      name: 'nohaydatos',
      desc: '',
      args: [],
    );
  }

  /// `Your guarda will accompany you from now on.`
  String get tuguardateacompanara {
    return Intl.message(
      'Your guarda will accompany you from now on.',
      name: 'tuguardateacompanara',
      desc: '',
      args: [],
    );
  }

  /// `The guarda has been saved in the Holowide!`
  String get guardaguardado {
    return Intl.message(
      'The guarda has been saved in the Holowide!',
      name: 'guardaguardado',
      desc: '',
      args: [],
    );
  }

  /// `Incorrect guarda code.`
  String get codigoincorrecto {
    return Intl.message(
      'Incorrect guarda code.',
      name: 'codigoincorrecto',
      desc: '',
      args: [],
    );
  }

  /// `Guarda code`
  String get codigoguarda {
    return Intl.message(
      'Guarda code',
      name: 'codigoguarda',
      desc: '',
      args: [],
    );
  }

  /// `Phantom mode activated.`
  String get modofantasmaon {
    return Intl.message(
      'Phantom mode activated.',
      name: 'modofantasmaon',
      desc: '',
      args: [],
    );
  }

  /// `Phantom mode deactivated.`
  String get modofantasmaoff {
    return Intl.message(
      'Phantom mode deactivated.',
      name: 'modofantasmaoff',
      desc: '',
      args: [],
    );
  }

  /// `shunnck`
  String get holowide {
    return Intl.message(
      'shunnck',
      name: 'holowide',
      desc: '',
      args: [],
    );
  }

  /// `Your connection to the Shunnck network has been established. This way you stay anonymous on the web and help others stay anonymous.`
  String get modocorazon {
    return Intl.message(
      'Your connection to the Shunnck network has been established. This way you stay anonymous on the web and help others stay anonymous.',
      name: 'modocorazon',
      desc: '',
      args: [],
    );
  }

  /// `San Juan is not in sight!`
  String get sanjuannoalavista {
    return Intl.message(
      'San Juan is not in sight!',
      name: 'sanjuannoalavista',
      desc: '',
      args: [],
    );
  }

  /// `There are internet connection problems that prevent you from connecting to the Shunnck network.`
  String get sinconexion {
    return Intl.message(
      'There are internet connection problems that prevent you from connecting to the Shunnck network.',
      name: 'sinconexion',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'eo'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'tl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

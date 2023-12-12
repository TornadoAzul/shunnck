import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shunnck/screens/genesis.dart';
import 'package:shunnck/screens/home.dart';

class FirmaView extends StatefulWidget {
  const FirmaView({super.key});

  @override
  State<FirmaView> createState() => _FirmaViewState();
}

class _FirmaViewState extends State<FirmaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const GenesisView()),
              );
            },
            child: SvgPicture.asset(
              Theme.of(context).brightness == Brightness.dark
                  ? "assets/images/shunnck-cla.svg"
                  : "assets/images/shunnck-osc.svg",
              height: 18,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 26,
            ),
            Text(
              "SAN JUAN",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Cuando era un niño, un día mamá me llevó a Hato Rey para una cita médica. Creo que hablo poco cuando digo que mi vida cambió por completo. Cuando por allí caminé, vi un hermoso tren. Nunca había visto uno y me sorprendió tanto que me quedé mirando por minutos aquél riel desde la ventana del aquél consultorio.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Ahí empezé a comprender el valor que me generaba aquella ciudad. Más allá del Tren Urbano de San Juan, era la armonía.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 22,
                    height: 1.5,
                    fontFamily: "SJ",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Text(
              "Comenzé a tener más cariño a los mapas. Dibujaba cientos en el día, hasta de lugares que no existían, como un lugar llamado Nebula, una ciudad en una luna que nunca existió. Empezé a programar unos años más tarde, y noté algo.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Text(
              "En el mundo tecnológico, el diseño es un caos. Era hora de darle armonía. Como aquella ciudad llamada San Juan. Pero necesitaba un aliado.",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                  fontFamily: "PON",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "HONG KONG",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Tenía un amigo llamado Yin que vivía en aquella ciudad en el continente asiatico. Una ciudad tan estética como HK era clave para buscar ideas para este nuevo proyecto.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                "Pero Él notó que tenían el mismo problema. La web sobre todo, no era uniforme. Era un caos. En parte, ese era su encanto, pero provocaba confusión y más problemas de los que solucionaba.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontSize: 22,
                    height: 1.5,
                    fontFamily: "SJ",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Text(
              "Había mucho que hacer. Pero necesitabamos a alguien para poder llevar y conectar el mundo en inglés. Buscamos en todos sitios una manera de conectar todo lo que hacemos a cualquier persona del globo. Por ello trabajamos en cientos de ideas, sientos de maneras de ver un mundo diferente. ¿Quién nos ayudaría?",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            Text(
              "VARSOVIA",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Creo que ya estabamos listos. Empezamos con multiples ideas. Cada una más loca que la anterior. Desde aquella ciudad polaca, buscamos todo lo posible por crear algo increible y poner todo al día. Esa era la misión. Pero paresía cada vez más lejos. Creo que tuve que buscar más cerca de mí la respuesta.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 27,
            ),
            Text(
              "Me enfoqué en todo lo que me rodeaba. Me enfoqué en otros proyectos. Me enfoqué en quien somos. Eso cambió todo. No teniamos en cuenta lo que vendría luego.",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 22,
                  fontFamily: "PON",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 27,
            ),
            Text(
              "Creo que toda historia tiene su final, pero esta recién comenzó.",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            Text(
              "MANATÍ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Una nueva forma de ver internet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            const SizedBox(
              height: 200,
            ),
            Text(
              "CABO ROJO",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Un diseño innovador.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            const SizedBox(
              height: 200,
            ),
            Text(
              "CIDRA",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Un cambio de paradigma.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            const SizedBox(
              height: 200,
            ),
            Text(
              "LAS PIEDRAS",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Algo nuevo para todos.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 300,
            ),
            const SizedBox(
              height: 200,
            ),
            Text(
              "?",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).colorScheme.onBackground
                      : Theme.of(context).primaryColor,
                  fontSize: 140,
                  fontFamily: "CAG",
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Pronto.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 22,
                fontFamily: "PON",
              ),
            ),
            const SizedBox(
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}

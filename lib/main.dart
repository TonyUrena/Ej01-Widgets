import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_icons/weather_icons.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Comarques de la Comunitat',
      home: LogIn(),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comarques de la Comunitat'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            opacity: 0.3,
            fit: BoxFit.cover,
          )),
          child: Column(
            //TODO falta el scroll para evitar el overlap
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/logo.png"),
              const Text(
                "Les comarques de la comunitat",
                style: TextStyle(
                    fontSize: 60,
                    fontFamily: "Milenia",
                    color: Color(0xff627e8c)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                  width: 250,
                  child: Column(children: [
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Usuari",
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        )),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Contrasenya",
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ])),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => Provincias()));
                      },
                      child: const Text("Login")))
            ],
          )),
    );
  }
}

class ComarcaTiempo extends StatefulWidget {
  Map infoComarca;

  ComarcaTiempo({Key? key, required this.infoComarca}) : super(key: key);

  @override
  _ComarcaTiempo createState() => _ComarcaTiempo();
}

class _ComarcaTiempo extends State<ComarcaTiempo> {
  Map infoComarca = {};

  @override
  void initState() {
    super.initState();
    infoComarca = widget.infoComarca;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("El Temps"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.black,
        ),
        body: Container(
            child: Padding(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 300,
                          child: BoxedIcon(
                            WeatherIcons.day_rain,
                            size: 150,
                            color: Colors.blue,
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BoxedIcon(WeatherIcons.thermometer, size: 30),
                            Text(
                              "5.4º",
                              style: TextStyle(fontSize: 40),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoxedIcon(
                            WeatherIcons.strong_wind,
                            size: 30,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(children: [
                                Text(
                                  "9.4km/h ",
                                  style: TextStyle(fontSize: 25),
                                ),
                                Text(" Ponent", style: TextStyle(fontSize: 25))
                              ])),
                          BoxedIcon(WeatherIcons.wind_deg_270, size: 30)
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Text(
                                "Població: " + infoComarca["poblacio"] ,
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Latitud: " + infoComarca["latitud"].toString(),
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "Longitud: " + infoComarca["longitud"].toString(),
                                style: TextStyle(fontSize: 20),
                              )
                            ],
                          ))
                    ],
                  ),
                ))));
  }
}

class ComarcaDetail extends StatefulWidget {
  Map infoComarca;

  ComarcaDetail({Key? key, required this.infoComarca}) : super(key: key);

  @override
  _ComarcaDetail createState() => _ComarcaDetail();
}

class _ComarcaDetail extends State<ComarcaDetail> {
  Map infoComarca = {};

  @override
  void initState() {
    super.initState();
    infoComarca = widget.infoComarca;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(infoComarca["comarca"]),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(infoComarca["img"]),
                    fit: BoxFit.cover,
                  ))),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    infoComarca["comarca"],
                    style: TextStyle(
                        fontSize: 60,
                        fontFamily: "Milenia",
                        color: Colors.black87),
                  )),
              Text(
                infoComarca["capital"],
                style: TextStyle(fontSize: 30),
              ),
              Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    infoComarca["desc"],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  )),
              Text(
                "Població: " + infoComarca["poblacio"],
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Latitud: " + infoComarca["latitud"].toString(),
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "Longitud: " + infoComarca["longitud"].toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ComarcaTiempo(infoComarca: infoComarca,)));
          },
          child: BoxedIcon(
            WeatherIcons.day_sleet,
          ),
        ));
  }
}

class ProvinciaDetail extends StatefulWidget {
  String nombreProvincia;

  ProvinciaDetail({Key? key, required this.nombreProvincia}) : super(key: key);

  @override
  _ProvinciaDetail createState() => _ProvinciaDetail();
}

class _ProvinciaDetail extends State<ProvinciaDetail> {
  late String nombreProvincia;
  late List listaComarcas;
  List listaInfoComarcas = [];

  @override
  void initState() {
    super.initState();
    nombreProvincia = widget.nombreProvincia;
    fetchDataProvinciaDetail();
  }

  Future<void> fetchDataProvinciaDetail() async {
    var baseUrl =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques/$nombreProvincia';
    var infoComarcaUrl;

    var responseComarcas = http.get(Uri.parse(baseUrl));

    await responseComarcas.then((data) {
      if (data.statusCode == 200) {
        String bodyComarcas = utf8.decode(data.bodyBytes);
        listaComarcas = jsonDecode(bodyComarcas) as List;
      } else {
        print('Error en la solicitud');
      }
    });

    List<Future<void>> futures = [];

    for (var comarca in listaComarcas) {
      infoComarcaUrl =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infocomarca/$comarca";

      var responseFotos = http.get(Uri.parse(infoComarcaUrl));

      futures.add(responseFotos.then((value) {
        String bodyFotos = utf8.decode(value.bodyBytes);
        Map infoComarca = jsonDecode(bodyFotos) as Map;
        listaInfoComarcas.add(infoComarca);
      }));
    }
    ;

    await Future.wait(futures);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(nombreProvincia),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              opacity: 0.3,
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                for (var comarca in listaInfoComarcas)
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              fixedSize: const Size(double.infinity, 200),
                              shape: const ContinuousRectangleBorder()),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ComarcaDetail(infoComarca: comarca)));
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(comarca["img"]),
// Ruta de la imagen de fondo
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10),
                                  child: Text(
                                    comarca["comarca"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontFamily: "Milenia",
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 15.0,
                                            color: Colors.black,
                                          )
                                        ]),
                                  ),
                                ),
                              )))),
              ],
            ),
          ),
        ));
  }
}

class Provincias extends StatefulWidget {
  const Provincias({Key? key}) : super(key: key);

  @override
  _ProvinciasState createState() => _ProvinciasState();
}

class _ProvinciasState extends State<Provincias> {
  late Map mapProvincias = {};

  @override
  void initState() {
    super.initState();
    fetchDataProvincias();
  }

  Future<void> fetchDataProvincias() async {
    var baseUrl =
        'https://node-comarques-rest-server-production.up.railway.app/api/comarques/';

    try {
      var response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        var listaProvincias = jsonDecode(body) as List;

        listaProvincias.forEach((p) {
          mapProvincias[p["provincia"]] = p["img"];
        });

        setState(() {});
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (error) {
      print('Error en la solicitud: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comarques de la Comunitat'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.black,
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/background.jpg"),
          opacity: 0.3,
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            children: [
              for (var clave in mapProvincias.keys)
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                ProvinciaDetail(nombreProvincia: clave)));
                      },
                      style:
                          ElevatedButton.styleFrom(shape: const CircleBorder()),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(mapProvincias[clave]),
                        child: Text(
                          clave,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Milenia",
                              fontSize: 55,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 30.0,
                                  color: Colors.black,
                                )
                              ]),
                        ),
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}

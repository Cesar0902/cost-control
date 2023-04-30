import 'package:flutter/material.dart';
import 'Movimientos.dart';
import 'Registros.dart';

class Opciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Opciones'),
          backgroundColor: Color.fromARGB(255, 30, 31, 49),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://c0.wallpaperflare.com/preview/241/384/859/analysis-analytics-analyzing-annual.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), 
                    primary:
                        Color.fromARGB(255, 223, 122, 29), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ), // borde redondeado
                  ),
                  child: Text('Resumen', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Movimientos()),
                    );
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50), 
                    primary: Colors.blue, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ), 
                  ),
                  child: Text('Movimiento de Activos',
                      style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Registros()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

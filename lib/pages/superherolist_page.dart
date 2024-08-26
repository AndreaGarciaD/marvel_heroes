import 'package:flutter/material.dart';
import 'package:marvel_heroes/bll/personaje_bll.dart';
import 'package:marvel_heroes/models/personaje_model.dart';

class SuperheroListPage extends StatefulWidget {
  const SuperheroListPage({super.key});

  @override
  State<SuperheroListPage> createState() => _SuperheroListPageState();
}

class _SuperheroListPageState extends State<SuperheroListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personaje List'),
      ),
      body: getBody(),
      floatingActionButton: FloatingActionButton( 
        onPressed: () {
          /*Personaje superhero = Personaje( 
            name: 'Tony Stark', 
            heroName: 'Ironman', 
            description: 'Iron man'
          
          );
          SuperheroBLL.insert(superhero);*/
          setState(() {});
        },
        child: const Icon(Icons.add),
      )
    );
  }

  FutureBuilder<List<Personaje>> getBody() {
    return FutureBuilder( 
      future: SuperheroBLL.selectAll(),
      builder: (BuildContext context, AsyncSnapshot<List<Personaje>> snapshot) {
        if(snapshot.hasError){
          print(snapshot.error);
          return const Center(child: Text('Error al cargar los datos'));
        }
        if(snapshot.hasData){
          return getPersonajeList(snapshot);
        } else {
          return const Center( 
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  ListView getPersonajeList(AsyncSnapshot<List<Personaje>> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (BuildContext context, int index) {
        Personaje superhero = snapshot.data![index];
        return ListTile(
          title: Text(superhero.heroName),
          subtitle: Text(
              'Nombre: ${superhero.name} - Descripcion: ${superhero.description}'),
        );
      },
    );
  }
}
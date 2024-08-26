import 'package:flutter/material.dart';
import 'package:marvel_heroes/bll/personaje_bll.dart';
import 'package:marvel_heroes/models/personaje_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Personaje> personajes = [];
  String selectedCategory = ''; 

  @override
  void initState() {
    super.initState();
    _fetchPersonajes();
  }

  Future<void> _fetchPersonajes() async {
    List<Personaje> fetchedPersonajes = await SuperheroBLL.selectAll();
    setState(() {
      personajes = fetchedPersonajes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, '/personajeform').then((_) => _fetchPersonajes());
                },
              ),
              Image.asset(
                'assets/images/marvel_logo.png',
                width: 100,
                height: 50,
                fit: BoxFit.contain,
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Acción para la búsqueda
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Marvel Heroes',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Gilroy'),
              ),
              const Text(
                'Choose your character',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Gilroy'),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildButton(
                      'assets/images/heroIcon.png',
                      const Color.fromRGBO(0, 91, 234, 1),
                      const Color.fromRGBO(0, 198, 251, 1), 'Heroes'),
                  buildButton(
                      'assets/images/villiainIcon.png',
                      const Color.fromRGBO(237, 29, 36, 1),
                      const Color.fromRGBO(237, 31, 105, 1), 'Villains'),
                  buildButton(
                      'assets/images/antiheroIcon.png',
                      const Color.fromRGBO(178, 36, 239, 1),
                      const Color.fromRGBO(117, 121, 255, 1), 'AntiHeroes'),
                  buildButton(
                      'assets/images/alienIcon.png',
                      const Color.fromRGBO(11, 163, 96, 1),
                      const Color.fromRGBO(60, 186, 146, 1), 'Aliens'),
                  buildButton(
                      'assets/images/humanIcon.png',
                      const Color.fromRGBO(255, 126, 179, 1),
                      const Color.fromRGBO(255, 117, 140, 1), 'Humans'),
                ],
              ),
              const SizedBox(height: 32),
              buildCategoryList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(String imagePath, Color startColor, Color endColor, String category) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: IconButton(
        icon: Image.asset(imagePath, fit: BoxFit.cover),
        onPressed: () {
          setState(() {
            if (selectedCategory == category) {
              selectedCategory = ''; // Si el botón ya está seleccionado, deselecciona
            } else {
              selectedCategory = category; // Actualiza la categoría seleccionada
            }
          });
        },
      ),
    );
  }

  Widget buildCategoryList() {
    List<Personaje> filteredPersonajes = selectedCategory.isEmpty
        ? personajes
        : personajes.where((personaje) => personaje.category == selectedCategory).toList();

    return Column(
      children: [
        buildCategorySection('Heroes'),
        buildCategoryItems(filteredPersonajes.where((personaje) => personaje.category == 'Heroes').toList()),
        const SizedBox(height: 32),
        buildCategorySection('Villains'),
        buildCategoryItems(filteredPersonajes.where((personaje) => personaje.category == 'Villains').toList()),
        const SizedBox(height: 32),
        buildCategorySection('AntiHeroes'),
        buildCategoryItems(filteredPersonajes.where((personaje) => personaje.category == 'AntiHeroes').toList()),
        const SizedBox(height: 32),
        buildCategorySection('Aliens'),
        buildCategoryItems(filteredPersonajes.where((personaje) => personaje.category == 'Aliens').toList()),
        const SizedBox(height: 32),
        buildCategorySection('Humans'),
        buildCategoryItems(filteredPersonajes.where((personaje) => personaje.category == 'Humans').toList()),
      ],
    );
  }

  Widget buildCategorySection(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Color.fromRGBO(242, 38, 75, 1),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildCategoryItems(List<Personaje> personajes) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: personajes.length,
        itemBuilder: (BuildContext context, int index) {
          Personaje superhero = personajes[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/personajedetail',
                arguments: superhero,
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: SizedBox(
                  width: 140,
                  height: 230,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(superhero.image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.cancel_outlined, color: Colors.white),
                          onPressed: () async {
                            bool? confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Eliminar Personaje'),
                                content: const Text(
                                    '¿Estás seguro de que deseas eliminar este personaje?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await SuperheroBLL.delete(superhero.id!);
                                      _fetchPersonajes(); // Refresca la lista
                                      Navigator.of(context).pop(true);
                                    },
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              _fetchPersonajes(); // Refresca la lista
                            }
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        left: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              superhero.name,
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              superhero.heroName,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:marvel_heroes/models/personaje_model.dart';
import 'package:marvel_heroes/pages/personaje_form.dart';

class PersonajeDetailPage extends StatelessWidget {
  final Personaje personaje;

  const PersonajeDetailPage({Key? key, required this.personaje}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonajeFormPage(personaje: personaje),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(personaje.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.93),
                          Colors.black.withOpacity(0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            personaje.name,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            personaje.heroName,
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 48),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildInfoItem('assets/images/ageIcon.png', '${personaje.age} years'),
                                _buildInfoItem('assets/images/weightIcon.png', '${personaje.weight} kg'),
                                _buildInfoItem('assets/images/heightIcon.png', '${personaje.height} m'),
                                _buildInfoItem('assets/images/planetIcon.png', personaje.planet),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          personaje.description,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildHabilitiesSection(personaje),
                        const SizedBox(height: 32),
                        _buildMoviesSection(personaje),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String iconPath, String text) {
    return Column(
      children: [
        Image.asset(iconPath, width: 24, height: 24),
        const SizedBox(height: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildHabilitiesSection(Personaje personaje) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Habilities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildHabilityRow('Strength', personaje.strength),
        _buildHabilityRow('Intelligence', personaje.intelligence),
        _buildHabilityRow('Agility', personaje.agility),
        _buildHabilityRow('Resistance', personaje.resistance),
        _buildHabilityRow('Speed', personaje.speed),
      ],
    );
  }

  Widget _buildHabilityRow(String hability, int level) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              hability,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: LinearProgressIndicator(
              value: level / 100.0,
              backgroundColor: Colors.grey,
              valueColor: const AlwaysStoppedAnimation<Color>(Color.fromRGBO(242, 38, 75, 1)),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '$level',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoviesSection(Personaje personaje) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Movies',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: personaje.movieList.length,
            itemBuilder: (context, index) {
              return _buildMovieCard(personaje.movieList[index]);
            },
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildMovieCard(String movieImageUrl) {
    return Card(
      color: Colors.transparent,
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(movieImageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

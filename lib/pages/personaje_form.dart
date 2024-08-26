import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel_heroes/bll/personaje_bll.dart';
import 'package:marvel_heroes/models/personaje_model.dart';

class PersonajeFormPage extends StatefulWidget {
  final Personaje? personaje;
  final Function()? onSave;

  const PersonajeFormPage({Key? key, this.personaje, this.onSave})
      : super(key: key);

  @override
  _PersonajeFormPageState createState() => _PersonajeFormPageState();
}

class _PersonajeFormPageState extends State<PersonajeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final Color primaryColor = const Color.fromRGBO(242, 38, 75, 1);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heroNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _planetController = TextEditingController();
  final TextEditingController _strengthController = TextEditingController();
  final TextEditingController _intelligenceController = TextEditingController();
  final TextEditingController _agilityController = TextEditingController();
  final TextEditingController _resistanceController = TextEditingController();
  final TextEditingController _speedController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _movieListController = TextEditingController();

  final List<String> _categories = [
    'Heroes',
    'Villains',
    'AntiHeroes',
    'Aliens',
    'Humans'
  ];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.personaje != null) {
      _nameController.text = widget.personaje!.name;
      _heroNameController.text = widget.personaje!.heroName;
      _descriptionController.text = widget.personaje!.description;
      _ageController.text = widget.personaje!.age.toString();
      _heightController.text = widget.personaje!.height.toString();
      _weightController.text = widget.personaje!.weight.toString();
      _planetController.text = widget.personaje!.planet;
      _strengthController.text = widget.personaje!.strength.toString();
      _intelligenceController.text = widget.personaje!.intelligence.toString();
      _agilityController.text = widget.personaje!.agility.toString();
      _resistanceController.text = widget.personaje!.resistance.toString();
      _speedController.text = widget.personaje!.speed.toString();
      _imageController.text = widget.personaje!.image;
      _selectedCategory = widget.personaje!.category;
      _movieListController.text = widget.personaje!.movieList.join(', ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: primaryColor,
          title: const Text('New Character'),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: getForm(context),
      ),
    );
  }

  Widget getForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTextInput('Name', _nameController),
          buildTextInput('Hero Name', _heroNameController),
          buildTextInput('Description', _descriptionController),
          buildTextInput('Age', _ageController),
          buildTextInput('Image url', _imageController),

          Row(
            children: [
              Expanded(child: buildTextInput('Height', _heightController)),
              const SizedBox(width: 16),
              Expanded(child: buildTextInput('Weight', _weightController)),
            ],
          ),
          buildTextInput('Planet', _planetController),
          const SizedBox(height: 20),
          buildCategoryDropdown(),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skills',
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                buildTextInput('Strength Level', _strengthController),
                buildTextInput('Intelligence Level', _intelligenceController),
                buildTextInput('Agility Level', _agilityController),
                buildTextInput('Resistance Level', _resistanceController),
                buildTextInput('Speed Level', _speedController),
              ],
            ),
          ),
          const SizedBox(height: 20),
          buildMovieListInput(), // Campo para URLs de películas
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  List<String> movieUrls = _movieListController.text
                      .split('\n')
                      .map((url) => url.trim())
                      .toList();
                  Personaje personaje = Personaje(
                    id: widget.personaje?.id,
                    name: _nameController.text,
                    heroName: _heroNameController.text,
                    description: _descriptionController.text,
                    age: int.parse(_ageController.text),
                    height: double.parse(_heightController.text),
                    weight: double.parse(_weightController.text),
                    planet: _planetController.text,
                    strength: int.parse(_strengthController.text),
                    intelligence: int.parse(_intelligenceController.text),
                    agility: int.parse(_agilityController.text),
                    resistance: int.parse(_resistanceController.text),
                    speed: int.parse(_speedController.text),
                    image: _imageController.text,
                    category: _selectedCategory!,
                    movieList:
                        movieUrls, 
                  );
                  if (widget.personaje == null) {
                    SuperheroBLL.insert(personaje);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Character added successfully')),
                    );
                  } else {
                    SuperheroBLL.insert(personaje);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Character updated successfully')),
                    );
                  }
                  if (widget.onSave != null) {
                    widget.onSave!();
                  }
                  Navigator.pop(context);
                }
              },
              child: Text(widget.personaje == null ? 'Create' : 'Update',
                  style: const TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: DropdownButtonFormField<String>(
        value: _selectedCategory,
        decoration: InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        items: _categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _selectedCategory = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a category';
          }
          return null;
        },
      ),
    );
  }

  Widget buildMovieListInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Movie URLs',
          style: TextStyle(
            color: primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _movieListController,
          decoration: InputDecoration(
            hintText: 'Enter movie URL',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          maxLines: null,
          keyboardType: TextInputType.url,
          validator: (value) {
            if (value != null && value.isNotEmpty) {
              List<String> urls = value.split(',');
              for (String url in urls) {
                if (url.isNotEmpty && !Uri.parse(url).isAbsolute) {
                  return 'Please enter valid URLs';
                }
              }
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget buildTextInput(String labelText, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'You can\'t leave this field empty';
          }
          return null;
        },
      ),
    );
  }
}

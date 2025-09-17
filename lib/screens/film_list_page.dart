import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_1_flutter/widgets/scaffold.dart';

const String _apiKey = '30c670f';
const String _baseUrl = 'http://www.omdbapi.com/?apikey=30c670f&s=furious';

class Movie {
  final String imdbID;
  final String Title;
  final String? Poster;

  Movie({required this.imdbID, required this.Title, this.Poster});

  factory Movie.fromJson(Map<String, dynamic> j) => Movie(
    imdbID: j['imdbID'] as String,
    Title: j['Title'] as String,
    Poster: (j['Poster'] == 'N/A') ? null : j['Poster'] as String?,
  );
}

class FilmListPage extends StatefulWidget {
  const FilmListPage({Key? key}) : super(key: key);

  @override
  _FilmListPageState createState() => _FilmListPageState();
}

/// Page affichant une liste de films récupérés depuis une API.
/// Permet de sélectionner/désélectionner des films en cliquant dessus.
/// Les films sélectionnés sont mis en évidence par une bordure colorée et une ombre.
class _FilmListPageState extends State<FilmListPage> {
  late Future<List<Movie>> _futureMovies;
  final Set<String> _selectedIds = {};
  final title = "Films";

  @override
  void initState() {
    super.initState();
    _futureMovies = _fetchNowPlaying();
  }

  /// Récupère la liste des films depuis l'API OMDb.
  Future<List<Movie>> _fetchNowPlaying() async {
    final uri = Uri.parse(_baseUrl);
    final res = await http.get(uri);
    if (res.statusCode != 200) throw Exception('Erreur API: ${res.statusCode}');

    final Map<String, dynamic> data =
        json.decode(res.body) as Map<String, dynamic>;
    final List<dynamic>? results = data['Search'] as List<dynamic>?;
    if (results == null) return [];

    return results
        .map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Bascule l'état de sélection d'un film par son ID.
  void _toggleSelected(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: this.title,
      likedCount: _selectedIds.length,
      showLikedCount: true,
      body: FutureBuilder<List<Movie>>(
        future: _futureMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          final movies = snapshot.data ?? [];
          if (movies.isEmpty) {
            return const Center(child: Text('Aucun film trouvé.'));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.63,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final m = movies[index];
              final selected = _selectedIds.contains(m.imdbID);
              return GestureDetector(
                onTap: () => _toggleSelected(m.imdbID),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: selected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 3,
                          )
                        : Border.all(color: Colors.transparent, width: 0),
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: m.Poster != null
                              ? Image.network(
                                  '${m.Poster}',
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                  errorBuilder: (c, e, s) => const Center(
                                    child: Icon(Icons.broken_image),
                                  ),
                                )
                              : const Center(
                                  child: Icon(Icons.image_not_supported),
                                ),
                        ),
                        Container(
                          color: Theme.of(context).colorScheme.surface,
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            m.Title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/model.dart';
import 'package:movie/services/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> nowShowing;
  late Future<List<Movie>> upComming;

  late Future<List<Movie>> popularMovies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nowShowing = apiService().getNowShowing();
    upComming = apiService().getUpComming();
    popularMovies = apiService().getPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Movie App"),
        leading: Icon(Icons.menu),
        actions: const [
          Icon(Icons.search_off_rounded),
          SizedBox(width: 20),
          Icon(Icons.notification_add_outlined),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "  Now Showing",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder(
                  future: nowShowing,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final movies = snapshot.data!;
                    return CarouselSlider.builder(
                        itemCount: movies.length,
                        itemBuilder: (context, index, movieIndex) {
                          final movie = movies[index];
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            enlargeCenterPage: true,
                            aspectRatio: 1.7,
                            autoPlayInterval: const Duration(seconds: 3)));
                  }),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Up Comming Movies",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder(
                    future: upComming,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final movies = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Stack(
                            children: [
                              Container(
                                width: 180,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Popular Movies",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Colors.black),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 250,
                child: FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final movies = snapshot.data!;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return Stack(
                            children: [
                              Container(
                                width: 180,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}"),
                                        fit: BoxFit.cover)),
                              ),
                              Positioned(
                                bottom: 15,
                                left: 0,
                                right: 0,
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

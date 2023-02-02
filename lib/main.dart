// Copyright 2020, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:try_firebase_store/models/models.dart';
import 'package:try_firebase_store/models/userModels/usersModel.dart';

import 'firebase_options.dart';

/// Requires that a Firestore emulator is running locally.
/// See https://firebase.flutter.dev/docs/firestore/usage#emulator-usage
bool shouldUseFirestoreEmulator = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (shouldUseFirestoreEmulator) {
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  }
  runApp(FirestoreExampleApp());
}

/// A reference to the list of movies.
/// We are using `withConverter` to ensure that interactions with the collection
/// are type-safe.
final moviesRef = FirebaseFirestore.instance
    .collection('try-firebase-store')
    .withConverter<Movie>(
      fromFirestore: (snapshots, _) => Movie.fromJson(snapshots.data()!),
      toFirestore: (movie, _) => movie.toJson(),
    );

 var usersRef= FirebaseFirestore.instance.collection("users")
 .withConverter(fromFirestore: ((snapshot, options) => User.fromJson(snapshot.data()!))
 , toFirestore: (user,_)=>user.toJson()
 );
//  usersRef.

/// The different ways that we can filter/sort movies.
enum MovieQuery {
  year,
  likesAsc,
  likesDesc,
  rated,
  sciFi,
  fantasy,
}

extension on Query<Movie> {
  /// Create a firebase query from a [MovieQuery]
  Query<Movie> queryBy(MovieQuery query) {
    switch (query) {
      case MovieQuery.fantasy:
        return where('genre', arrayContainsAny: ['Fantasy']);

      case MovieQuery.sciFi:
        return where('genre', arrayContainsAny: ['Sci-Fi']);

      case MovieQuery.likesAsc:
      case MovieQuery.likesDesc:
        return orderBy('likes', descending: query == MovieQuery.likesDesc);

      case MovieQuery.year:
        return orderBy('year', descending: true);

      case MovieQuery.rated:
        return orderBy('rated', descending: true);
    }
  }
}

enum UserEnum{
  name,
  age,
  mail,
  pets,
  address,
}
extension on Query<User> {
  Query<User>  queryBy(UserEnum userEnum){
    switch (userEnum) {
      
      case UserEnum.name:
        // TODO: Handle this case.
         return orderBy("name",descending:true);
         return where("name",isEqualTo:"john");
        break;
      case UserEnum.age:
        // TODO: Handle this case.
        return where("age",isEqualTo:15);
        break;
      case UserEnum.mail:
        // TODO: Handle this case.
        return where("email",isEqualTo:"example@example.com");
        //return orderBy('likes', descending: query == MovieQuery.likesDesc);
        break;
      case UserEnum.pets:
        // TODO: Handle this case.
        return orderBy("pets",descending:true);
        // return where('genre', arrayContainsAny: ['Sci-Fi']);
        break;
      case UserEnum.address:
        // TODO: Handle this case.
        return orderBy("address",descending:true);

        break;
    }
  }
}

/// The entry point of the application.
///
/// Returns a [MaterialApp].
class FirestoreExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Example App',
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: Center(child: FilmList()),
      ),
    );
  }
}

/// Holds all example app films
class FilmList extends StatefulWidget {
  const FilmList({Key? key}) : super(key: key);

  @override
  _FilmListState createState() => _FilmListState();
}

class _FilmListState extends State<FilmList> {
  MovieQuery query = MovieQuery.year;
  UserEnum queryUserEnum = UserEnum.age;
  var firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async { 

      //  await firestoreInstance.collection("users").doc("aaa").set({
      //     "veri":"aaa",
      //     "veri2":"aaa",
      //     "veri4":"aaa",
      //   });
        // await firestoreInstance.collection("model").doc("id1").set({
        //   "veri":"aaa",
        //   "veri2":"aaa",
        //   "veri4":"aaa",
        //   "veri4":"aaa",
        // });

        //   firestoreInstance.collection("deneme_sinifi").doc("deneme").update({
        //     "characteristics" : FieldValue.arrayUnion(["generous","loving","loyal"])//array olarak verir
        //   }).then((_) {
        //     print("success!");
        //   });

           firestoreInstance.collection("users").add({
    "name": "john",
    "age": 50,
    "email": "example@example.com",
    "address": {"street": "street 24", "city": "new york"}
  }).then((value) {
    print(value.id);
    firestoreInstance
        .collection("users")
        .doc(value.id)
        .collection("pets")
        .add({"petName": "blacky", "petType": "dog", "petAge": 1});
  });

  // firestoreInstance.collection("users").doc("aa").set({
  //   "name": "john",
  //   "age": 50,
  //   "email": "example@example.com",
  //   "address": {"street": "street 24", "city": "new york"}
  // }).then((value) {
  //   firestoreInstance
  //       .collection("users")
  //       .doc("deneme")
  //       .collection("pets")
  //       .add({"petName": "blacky", "petType": "dog", "petAge": 1});
  // });
        
        // print(aa.toString());
       },),
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Firestore Example: Movies'),

            // This is a example use for 'snapshots in sync'.
            // The view reflects the time of the last Firestore sync; which happens any time a field is updated.
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").get().asStream(),
              builder: (context, snapshots) {
                
                    // print(snapshots.data!.docs.first.get("address.city"));

                switch (snapshots.connectionState) {
                  
                  case ConnectionState.none:
                    // TODO: Handle this case.
                    print("object");
                    break;
                  case ConnectionState.waiting:
                    // TODO: Handle this case.
                    print("waiting");
                    break;
                  case ConnectionState.active:
                    // TODO: Handle this case.
                    print("active");
                    return Text(
                      // 'Latest Snapshot: ${DateTime.now()}' + snapshots.data!.docs.first.get("address.city"),
                     snapshots.data!.docs.first.get("address.city"),
                      style: Theme.of(context).textTheme.caption,
                    );
                    break;
                  case ConnectionState.done:
                    // TODO: Handle this case.
                    break;
                }
                // return 
                return Text(
                  // 'Latest Snapshot: ${DateTime.now()}',
                  snapshots.data!.docs.first.get("address.city"),
                  style: Theme.of(context).textTheme.caption,
                );
              },
            )
          ],
        ),
        actions: <Widget>[
          PopupMenuButton<UserEnum>(
            onSelected: (value) => setState(() => queryUserEnum = value),
            icon: const Icon(Icons.sort),
            itemBuilder: (BuildContext context) {
              return [
                // const PopupMenuItem(
                //   value: MovieQuery.year,
                //   child: Text('Sort by Year'),
                // ),
                // const PopupMenuItem(
                //   value: MovieQuery.rated,
                //   child: Text('Sort by Rated'),
                // ),
                // const PopupMenuItem(
                //   value: MovieQuery.likesAsc,
                //   child: Text('Sort by Likes ascending'),
                // ),
                // const PopupMenuItem(
                //   value: MovieQuery.likesDesc,
                //   child: Text('Sort by Likes descending'),
                // ),
                // const PopupMenuItem(
                //   value: MovieQuery.fantasy,
                //   child: Text('Filter genre Fantasy'),
                // ),
                // const PopupMenuItem(
                //   value: MovieQuery.sciFi,
                //   child: Text('Filter genre Sci-Fi'),
                // ),
                const PopupMenuItem(
                  value: UserEnum.age,
                  child: Text('Age'),
                ),const PopupMenuItem(
                  value: UserEnum.mail,
                  child: Text('Mail'),
                ),
              ];
            },
          ),
          PopupMenuButton<String>(
            onSelected: (_) => _resetLikes(),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'reset_likes',
                  child: Text('Reset like counts (WriteBatch)'),
                ),
              ];
            },
          ),
        ],
      ),
      // body: StreamBuilder<QuerySnapshot<Movie>>(
      body: StreamBuilder<QuerySnapshot<User>>(
        stream: usersRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;
          
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return ListTile(
                  title : Text(data.docs[index].data().adress!.city!),
                  onTap: ()async {
                    // print(data.docs[index].reference.toString() +"    aaa");
                    int newLikes = await FirebaseFirestore.instance
                                .runTransaction<int>((transaction) async {
                              DocumentSnapshot<User> user =
                                  await transaction.get<User>(data.docs[index].reference);

                              if (!user.exists) {
                                throw Exception('Document does not exist!');
                              }

                              int updatedLikes = user.data()!.age! + 1;
                              transaction.update(data.docs[index].reference, {'age': updatedLikes});
                              return updatedLikes;
                            });

    /////
    ///
    print("aaaaaaaaaaaaaaaaa");
    // FirebaseFirestore.instance.collection("users").doc("${data.docs[index].reference.id}").collection("pets")
  final val =FirebaseFirestore.instance.collection("users").doc("${data.docs[index].reference.id}").collection("pets").firestore.runTransaction((transaction) async {
 print("aaaaaaaaaaaaaaaaa");
//  print(transaction.)
    // print(transaction.get("""XclR9wS6WmYnM8ooOjbj""").toString() +"             ------------------------------------");
    // transaction.set(documentReference, data)
    // transaction.set(documentReference, data)
    // transaction.update(documentReference, data)
      print(data.docs[2].reference.id.toString() + "              -------------asa--------- ");
      print(data.docs[2].data().toString() + "              -------------asa--------- ");
      return "aaa";
                              // DocumentSnapshot<Pets> user =
                              //     await transaction.get<Pets>(data.docs[index].get("pets"));

                              // if (!user.exists) {
                              //   throw Exception('Document does not exist!');
                              // }

                              // int updatedLikes = user.data()!.petAge! + 1;
                              // transaction.update(data.docs[index].reference, {'petAge': updatedLikes});
                              // return updatedLikes;

  });
    // val.then((value) => print(value.data().toString() + "         --------------"));
//   FirebaseFirestore.instance.collection("users").doc("${data.docs[index].reference}.pets").path;
//   FirebaseFirestore.instance.collection("users").doc("${data.docs[index].reference}.pets").snapshots().listen((pets)  {

//                     //     for (var pet in pets) {
//                     //       print(pet.data().toString());
//                     //     }
//                     //  });

                    
//                       print(pets.reference.toString() +"             ------------------------------------");
//                       //  DocumentSnapshot<Pets> user =
//                       //             await ;
//                             //     .runTransaction<int>((transaction) async {
//                             //   DocumentSnapshot<Pets> user =
//                             //       await transaction.get<Pets>(data.docs[index].get("pets"));

//                             //   if (!user.exists) {
//                             //     throw Exception('Document does not exist!');
//                             //   }

//                             //   int updatedLikes = user.data()!.petAge! + 1;
//                             //   transaction.update(data.docs[index].reference, {'petAge': updatedLikes});
//                             //   return updatedLikes;
//                             // });

//                   },
//  );

              //////
                  }
              );
              // return _MovieItem(
              //   data.docs[index].data(),
              //   data.docs[index].reference,
              // );
            },
          );
        },
      ),
    );
  }

  Future<void> _resetLikes() async {
    final movies = await moviesRef.get(
      const GetOptions(
        serverTimestampBehavior: ServerTimestampBehavior.previous,
      ),
    );

    WriteBatch batch = FirebaseFirestore.instance.batch();

    for (final movie in movies.docs) {
      batch.update(movie.reference, {'likes': 0});
    }
    await batch.commit();
  }
}




/// A single movie row.
class _MovieItem extends StatelessWidget {
  _MovieItem(this.movie, this.reference);

  final Movie movie;
  final DocumentReference<Movie> reference;

  /// Returns the movie poster.
  Widget get poster {
    return SizedBox(
      width: 100,
      child: Image.network(movie.poster),
    );
  }

  /// Returns movie details.
  Widget get details {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          metadata,
          genres,
          Likes(
            reference: reference,
            currentLikes: movie.likes,
          )
        ],
      ),
    );
  }

  /// Return the movie title.
  Widget get title {
    return Text(
      '${movie.title} (${movie.year})',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  /// Returns metadata about the movie.
  Widget get metadata {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text('Rated: ${movie.rated}'),
          ),
          Text('Runtime: ${movie.runtime}'),
        ],
      ),
    );
  }

  /// Returns a list of genre movie tags.
  List<Widget> get genreItems {
    return [
      for (final genre in movie.genre)
        Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Chip(
            backgroundColor: Colors.lightBlue,
            label: Text(
              genre,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        )
    ];
  }

  /// Returns all genres.
  Widget get genres {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        children: genreItems,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          poster,
          Flexible(child: details),
        ],
      ),
    );
  }
}

/// Displays and manages the movie 'like' count.
class Likes extends StatefulWidget {
  /// Constructs a new [Likes] instance with a given [DocumentReference] and
  /// current like count.
  Likes({
    Key? key,
    required this.reference,
    required this.currentLikes,
  }) : super(key: key);

  /// The reference relating to the counter.
  final DocumentReference<Movie> reference;

  /// The number of current likes (before manipulation).
  final int currentLikes;

  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  /// A local cache of the current likes, used to immediately render the updated
  /// likes count after an update, even while the request isn't completed yet.
  late int _likes = widget.currentLikes;

  Future<void> _onLike() async {
    final currentLikes = _likes;

    // Increment the 'like' count straight away to show feedback to the user.
    setState(() {
      _likes = currentLikes + 1;
    });

    try {
      // Update the likes using a transaction.
      // We use a transaction because multiple users could update the likes count
      // simultaneously. As such, our likes count may be different from the likes
      // count on the server.
      int newLikes = await FirebaseFirestore.instance
          .runTransaction<int>((transaction) async {
        DocumentSnapshot<Movie> movie =
            await transaction.get<Movie>(widget.reference);

        if (!movie.exists) {
          throw Exception('Document does not exist!');
        }

        int updatedLikes = movie.data()!.likes + 1;
        transaction.update(widget.reference, {'likes': updatedLikes});
        return updatedLikes;
      });

      // Update with the real count once the transaction has completed.
      setState(() => _likes = newLikes);
    } catch (e, s) {
      print(s);
      print('Failed to update likes for document! $e');

      // If the transaction fails, revert back to the old count
      setState(() => _likes = currentLikes);
    }
  }

  @override
  void didUpdateWidget(Likes oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The likes on the server changed, so we need to update our local cache to
    // keep things in sync. Otherwise if another user updates the likes,
    // we won't see the update.
    if (widget.currentLikes != oldWidget.currentLikes) {
      _likes = widget.currentLikes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: 20,
          onPressed: _onLike,
          icon: const Icon(Icons.favorite),
        ),
        Text('$_likes likes'),
      ],
    );
  }
}

@immutable
class Movie {
  Movie({
    required this.genre,
    required this.likes,
    required this.poster,
    required this.rated,
    required this.runtime,
    required this.title,
    required this.year,
  });

  Movie.fromJson(Map<String, Object?> json)
      : this(
          genre: (json['genre']! as List).cast<String>(),
          likes: json['likes']! as int,
          poster: json['poster']! as String,
          rated: json['rated']! as String,
          runtime: json['runtime']! as String,
          title: json['title']! as String,
          year: json['year']! as int,
        );

  final String poster;
  final int likes;
  final String title;
  final int year;
  final String runtime;
  final String rated;
  final List<String> genre;

  Map<String, Object?> toJson() {
    return {
      'genre': genre,
      'likes': likes,
      'poster': poster,
      'rated': rated,
      'runtime': runtime,
      'title': title,
      'year': year,
    };
  }
}
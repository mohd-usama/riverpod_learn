import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/Screens/Favourite/favourite_provider.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});

  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final postData = ref.watch(favouriteProvider);
    return Scaffold(
        appBar: AppBar(title: Text("Favourite Screen")),
        body: postData.when(
            data: (post) {
              return ListView.builder(
                  itemCount: post.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.white, border: Border.all(), boxShadow: [BoxShadow()]),
                      child: Column(
                        children: [Text(post[index].title.toString())],
                      ),
                    );
                  });
            },
            error: (e, _) => Center(),
            loading: () => CircularProgressIndicator()));
  }
}

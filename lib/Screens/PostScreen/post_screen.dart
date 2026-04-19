import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/DBHelper/db_helper.dart';
import 'package:riverpod_learn/Screens/Favourite/favourite_screen.dart';
import 'package:riverpod_learn/Screens/PostScreen/post_screen_provider.dart';

import '../Favourite/favourite_provider.dart';

class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key});

  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        ref.read(postProvider.notifier).getPostApi();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(postProvider);
    final notifier = ref.read(postProvider.notifier);
    return Scaffold(
        appBar: AppBar(
          title: Text("Post Screen"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => FavouriteScreen()));
                },
                icon: Icon(Icons.favorite_border))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Search posts...",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (notifier.debounce?.isActive ?? false) notifier.debounce?.cancel();
                  notifier.debounce = Timer(const Duration(milliseconds: 500), () {
                    ref.read(postProvider.notifier).search(value);
                  });
                },
              ),
            ),
            Expanded(
              child: data.when(
                  data: (posts) {
                    if (posts.isEmpty) {
                      Text("No Record Found");
                    }
                    return ListView.builder(
                        controller: scrollController,
                        itemCount: posts.length + 1,
                        itemBuilder: (BuildContext con, int index) {
                          if (index == posts.length) {
                            if (!notifier.hasMore) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                  child: Text(
                                    "No more data",
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              );
                            }
                            return const Padding(
                              padding: EdgeInsets.all(16),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(color: Colors.white, border: Border.all(), boxShadow: [BoxShadow()]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text("${index + 1} :  ${posts[index].title!}")),
                                    IconButton(
                                        onPressed: () async {
                                          final postNotifier = ref.read(postProvider.notifier);
                                          final favNotifier = ref.read(favouriteProvider.notifier);
                                          postNotifier.updateIsFav(index);
                                          if (posts[index].isFav) {
                                            await DBHelper.insert(posts[index]);
                                          } else {
                                            await DBHelper.delete(posts[index]);
                                          }
                                          await favNotifier.getDataFromDataBase();
                                        },
                                        icon: Icon(
                                          posts[index].isFav ? Icons.favorite : Icons.favorite_border,
                                        ))
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(posts[index].body!)
                              ],
                            ),
                          );
                        });
                  },
                  error: (e, _) => const Center(),
                  loading: () => const Center(
                        child: CircularProgressIndicator(),
                      )),
            ),
          ],
        ));
  }
}

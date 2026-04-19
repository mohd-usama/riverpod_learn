import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/DBHelper/db_helper.dart';
import 'package:riverpod_learn/Model/post_model.dart';

final favouriteProvider = StateNotifierProvider<FavouriteProvider, AsyncValue<List<PostModel>>>(
  (ref) => FavouriteProvider(),
);

class FavouriteProvider extends StateNotifier<AsyncValue<List<PostModel>>> {
  FavouriteProvider() : super(AsyncLoading()) {
    getDataFromDataBase();
  }

  final List<PostModel> posts = [];

  Future<void> getDataFromDataBase() async {
    try {
      state = const AsyncLoading();
      final dummyList = await DBHelper.query();
      posts.clear();
      for (var data in dummyList) {
        posts.add(PostModel.fromJson(data));
      }
      state = AsyncData(List.from(posts));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_learn/ApiRepo/api_repository.dart';

import '../../Model/post_model.dart';

final postProvider = StateNotifierProvider<PostScreenProvider, AsyncValue<List<PostModel>>>(
  (ref) => PostScreenProvider(),
);

class PostScreenProvider extends StateNotifier<AsyncValue<List<PostModel>>> {
  PostScreenProvider() : super(const AsyncLoading()) {
    getPostApi();
  }

  final ApiRepository _apiService = ApiRepository();

  final List<PostModel> posts = [];
  List<PostModel> filterList = [];
  int _page = 1;
  bool hasMore = true;
  Timer? debounce;
  bool isfav = false;

  Future<void> getPostApi() async {
    try {
      final response = await _apiService.getPostApi(page: _page);
      if (response.isEmpty || filterList.length >= 100) {
        hasMore = false;
      } else {
        _page++;
        posts.addAll(response);
        filterList = posts;
        print("API RESPONSE: $response");
      }
      state = AsyncData(filterList);
      print("STATE UPDATED: ${filterList.length}");
    } catch (e, st) {
      state = AsyncError(e, st);
      print("STATE UPDATED: ${e.toString()}");
    }
  }

  void search(String value) {
    if (value.isEmpty) {
      filterList = posts;
    } else {
      filterList = posts.where((item) {
        return item.title.toString().toLowerCase().contains(value.toLowerCase());
      }).toList();
    }

    state = AsyncData(filterList);
  }

  void updateIsFav(int index) {
    filterList[index].isFav = !filterList[index].isFav;
    state = AsyncData([...filterList]);
  }
}

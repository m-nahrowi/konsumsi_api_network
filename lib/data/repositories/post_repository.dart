import '../../core/network/network_service.dart';
import '../models/post_model.dart';

class PostRepository {
  final NetworkService _networkService = NetworkService();

  Future<List<Post>> fetchPosts() async {
    final response = await _networkService.get('posts');
    if (response != null && response.statusCode == 200) {
      List data = response.data;
      return data.map((json) => Post.fromJson(json)).toList();
    }
    return [];
  }
}

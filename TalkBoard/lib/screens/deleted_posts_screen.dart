import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:free_board/models/post.dart';
import 'package:free_board/providers/auth_provider.dart';
import 'package:free_board/providers/post_provider.dart';

class DeletedPostsScreen extends StatefulWidget {
  const DeletedPostsScreen({super.key});

  @override
  State<DeletedPostsScreen> createState() => _DeletedPostsScreenState();
}

class _DeletedPostsScreenState extends State<DeletedPostsScreen> {
  @override
  void initState() {
    super.initState();
    // 삭제된 게시글 목록 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      final userId = authProvider.currentUserId;
      if (userId != null) {
        postProvider.initDeletedPosts(userId);
      }
    });
  }

  Future<void> _restorePost(BuildContext context, Post post) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('게시글 복원'),
        content: Text('"${post.title}" 게시글을 복원하시겠습니까?\n댓글도 함께 복원됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
            child: const Text('복원'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      final postProvider = Provider.of<PostProvider>(context, listen: false);
      final success = await postProvider.restorePost(post.id);
      
      if (context.mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('게시글이 복원되었습니다.'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('게시글 복원에 실패했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내가 삭제한 게시글'),
        backgroundColor: Colors.grey[700],
        foregroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          tooltip: '뒤로가기',
        ),
      ),
      body: Consumer2<PostProvider, AuthProvider>(
        builder: (context, postProvider, authProvider, child) {
          // 현재 사용자 ID 확인
          final userId = authProvider.currentUserId;
          if (userId == null) {
            return const Center(
              child: Text('로그인이 필요합니다.'),
            );
          }

          // 삭제된 게시글이 초기화되지 않았으면 초기화
          final deletedPosts = postProvider.deletedPosts;
          
          // 삭제된 게시글이 없는 경우
          if (deletedPosts.isEmpty && !postProvider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.delete_outline,
                      size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    '삭제한 게시글이 없습니다',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          // 오류 발생
          if (postProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('오류 발생: ${postProvider.errorMessage}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      postProvider.clearError();
                      postProvider.initDeletedPosts(userId);
                    },
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
            );
          }

          // 로딩 중
          if (postProvider.isLoading && deletedPosts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // 삭제된 게시글 목록 표시
          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: deletedPosts.length,
            itemBuilder: (context, index) {
              final post = deletedPosts[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                elevation: 2,
                color: Colors.grey[100], // 삭제된 게시글은 회색 배경
                child: ListTile(
                  leading: Icon(
                    Icons.delete_outline,
                    color: Colors.red[600],
                    size: 24,
                  ),
                  title: Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough, // 취소선
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        post.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[600],
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            post.author,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            DateFormat('yyyy.MM.dd HH:mm').format(post.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.visibility,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                '${post.views}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.restore,
                      color: Colors.green[600],
                    ),
                    onPressed: () => _restorePost(context, post),
                    tooltip: '복원',
                  ),
                  onTap: null, // 삭제된 게시글은 상세보기 불가
                ),
              );
            },
          );
        },
      ),
    );
  }
}


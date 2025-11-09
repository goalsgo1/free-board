import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:free_board/models/comment.dart';
import 'package:free_board/models/post.dart';
import 'package:free_board/screens/post_edit_screen.dart';
import 'package:free_board/services/auth_service.dart';
import 'package:free_board/services/firestore_service.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _firestoreService = FirestoreService();
  final _authService = AuthService();
  bool _hasIncrementedViews = false; // 조회수 증가를 한 번만 수행하기 위한 플래그
  bool _isHistoryExpanded = false; // 게시글 수정 히스토리 확장 여부
  final Map<String, bool> _commentHistoryExpanded = {}; // 댓글별 수정 히스토리 확장 여부
  final Map<String, bool> _commentReplyExpanded = {}; // 댓글별 답글 작성 폼 확장 여부
  final Map<String, bool> _commentRepliesVisible = {}; // 댓글별 대댓글 표시 여부 (기본값: true)
  final TextEditingController _commentController = TextEditingController();
  final Map<String, TextEditingController> _replyControllers = {}; // 댓글별 답글 입력 필드
  bool _isCommentLoading = false;
  final ScrollController _scrollController = ScrollController(); // 스크롤 위치 유지용
  
  // 현재 사용자가 게시글 작성자인지 확인
  bool _isOwner(Post? post) {
    if (post == null) return false;
    final currentUserId = _authService.currentUserId ?? '';
    return post.userId == currentUserId;
  }

  // 현재 사용자가 댓글 작성자인지 확인
  bool _isCommentOwner(Comment comment) {
    final currentUserId = _authService.currentUserId ?? '';
    return comment.userId == currentUserId;
  }

  // 날짜를 간단한 형식으로 변환 (작성자/날짜가 잘리지 않도록)
  String _formatShortDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    // 오늘인 경우
    if (dateOnly == today) {
      return DateFormat('HH:mm').format(date);
    }
    
    // 어제인 경우
    final yesterday = today.subtract(const Duration(days: 1));
    if (dateOnly == yesterday) {
      return '어제 ${DateFormat('HH:mm').format(date)}';
    }
    
    // 올해인 경우
    if (date.year == now.year) {
      return DateFormat('MM.dd HH:mm').format(date);
    }
    
    // 작년 이전
    return DateFormat('yy.MM.dd').format(date);
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    // 모든 답글 컨트롤러 해제
    for (final controller in _replyControllers.values) {
      controller.dispose();
    }
    _replyControllers.clear();
    super.dispose();
  }

  // 대댓글 작성
  Future<void> _submitReply(String postId, String parentCommentId) async {
    final controller = _replyControllers[parentCommentId];
    if (controller == null) return;

    final content = controller.text.trim();
    if (content.isEmpty) return;

    final userId = _authService.currentUserId ?? '';
    final authorName = _authService.currentUserDisplayName;

    if (userId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인이 필요합니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // 현재 스크롤 위치 저장
    final currentScrollOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    setState(() {
      _isCommentLoading = true;
    });

    final now = DateTime.now();
    final reply = Comment(
      id: '',
      postId: postId,
      parentCommentId: parentCommentId,
      content: content,
      author: authorName,
      userId: userId,
      createdAt: now,
      updatedAt: now,
    );

    final replyId = await _firestoreService.createComment(reply);

    if (replyId != null && mounted) {
      controller.clear();
      setState(() {
        _commentReplyExpanded[parentCommentId] = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('답글이 작성되었습니다.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      
      // 스크롤 위치 복원 (StreamBuilder 업데이트 후)
      if (_scrollController.hasClients) {
        // 여러 프레임을 기다려서 StreamBuilder가 완전히 업데이트되도록 함
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted && _scrollController.hasClients) {
              _scrollController.jumpTo(currentScrollOffset);
            }
          });
        });
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('답글 작성에 실패했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (mounted) {
      setState(() {
        _isCommentLoading = false;
      });
    }
  }

  // 댓글 작성
  Future<void> _submitComment(String postId) async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    final userId = _authService.currentUserId ?? '';
    final authorName = _authService.currentUserDisplayName;

    if (userId.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('로그인이 필요합니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // 현재 스크롤 위치 저장
    final currentScrollOffset = _scrollController.hasClients
        ? _scrollController.offset
        : 0.0;

    setState(() {
      _isCommentLoading = true;
    });

    final now = DateTime.now();
    final comment = Comment(
      id: '',
      postId: postId,
      content: content,
      author: authorName,
      userId: userId,
      createdAt: now,
      updatedAt: now,
    );

    final commentId = await _firestoreService.createComment(comment);

    if (commentId != null && mounted) {
      _commentController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('댓글이 작성되었습니다.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      
      // 스크롤 위치 복원 (StreamBuilder 업데이트 후)
      if (_scrollController.hasClients) {
        // 여러 프레임을 기다려서 StreamBuilder가 완전히 업데이트되도록 함
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted && _scrollController.hasClients) {
              _scrollController.jumpTo(currentScrollOffset);
            }
          });
        });
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('댓글 작성에 실패했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    if (mounted) {
      setState(() {
        _isCommentLoading = false;
      });
    }
  }

  // 댓글 수정
  Future<void> _editComment(Comment comment) async {
    final commentController = TextEditingController(text: comment.content);
    final formKey = GlobalKey<FormState>();
    bool isUpdating = false;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('댓글 수정'),
          content: SizedBox(
            width: double.maxFinite,
            child: Form(
              key: formKey,
              child: TextFormField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: '댓글 내용',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return '댓글 내용을 입력해주세요';
                  }
                  return null;
                },
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: isUpdating
                  ? null
                  : () => Navigator.pop(context, false),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: isUpdating
                  ? null
                  : () async {
                    if (formKey.currentState!.validate()) {
                      setDialogState(() {
                        isUpdating = true;
                      });

                      final success = await _firestoreService.updateComment(
                        comment.id,
                        commentController.text.trim(),
                      );

                      if (success && mounted) {
                        Navigator.pop(context, true);
                      } else if (mounted) {
                        setDialogState(() {
                          isUpdating = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('댓글 수정에 실패했습니다.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
              child: isUpdating
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('수정'),
            ),
          ],
        ),
      ),
    );

    commentController.dispose();

    if (result == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('댓글이 수정되었습니다.'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  // 댓글 삭제
  Future<void> _deleteComment(Comment comment) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('댓글 삭제'),
        content: const Text('정말 이 댓글을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _firestoreService.deleteComment(comment.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('댓글이 삭제되었습니다.'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 1),
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('댓글 삭제에 실패했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // 조회수 증가 (한 번만)
    if (!_hasIncrementedViews) {
      _firestoreService.incrementViews(widget.postId);
      _hasIncrementedViews = true;
    }
  }

  Future<void> _editPost(Post post) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostEditScreen(post: post),
      ),
    );

    // 수정이 완료되면 자동으로 Stream이 업데이트됨
  }

  Future<void> _deletePost(Post post) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('삭제 확인'),
        content: const Text('정말 이 게시글을 삭제하시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('삭제'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final success = await _firestoreService.deletePost(post.id);
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('게시글이 삭제되었습니다.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('삭제에 실패했습니다.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
      return StreamBuilder<Post?>(
        key: ValueKey('post_${widget.postId}'), // 같은 인스턴스 유지
        stream: _firestoreService.getPostStream(widget.postId),
        builder: (context, snapshot) {
        // 로딩 중
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('게시글'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        // 오류 또는 게시글 없음
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('게시글'),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            body: const Center(
              child: Text('게시글을 찾을 수 없습니다.'),
            ),
          );
        }

        final post = snapshot.data!;
        final isOwner = _isOwner(post);

        return Scaffold(
          appBar: AppBar(
            title: const Text('게시글'),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              // 본인 게시글일 때만 수정/삭제 버튼 표시
              if (isOwner) ...[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _editPost(post),
                  tooltip: '수정',
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deletePost(post),
                  tooltip: '삭제',
                ),
              ],
            ],
          ),
          body: SingleChildScrollView(
            key: const ValueKey('scroll_view'), // 스크롤뷰 인스턴스 유지
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // 작성자, 작성 날짜, 조회수
                Row(
                  children: [
                    Icon(Icons.person, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      post.author,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.add_circle_outline, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '작성: ${DateFormat('yyyy.MM.dd HH:mm').format(post.createdAt)}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.visibility, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      '${post.views}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                // 수정 시간 표시 (수정된 경우만)
                if (post.isModified) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.edit, size: 16, color: Colors.orange[600]),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (post.updatedAtHistory.length == 1) ...[
                              // 수정 1번
                              Text(
                                '수정: ${DateFormat('yyyy.MM.dd HH:mm').format(post.updatedAt)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.orange[700],
                                ),
                              ),
                            ] else ...[
                              // 수정 여러 번 - 접을 수 있는 리스트
                              InkWell(
                                onTap: () {
                                  // 현재 스크롤 위치 저장
                                  final currentScrollOffset = _scrollController.hasClients
                                      ? _scrollController.offset
                                      : 0.0;
                                  
                                  setState(() {
                                    _isHistoryExpanded = !_isHistoryExpanded;
                                  });
                                  
                                  // 스크롤 위치 복원 (여러 프레임을 기다려서 완전히 렌더링 후)
                                  if (_scrollController.hasClients && currentScrollOffset > 0) {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      Future.delayed(const Duration(milliseconds: 50), () {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          if (mounted && _scrollController.hasClients) {
                                            _scrollController.jumpTo(currentScrollOffset);
                                          }
                                        });
                                      });
                                    });
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      '수정 (${post.updatedAtHistory.length}회)',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.orange[700],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      _isHistoryExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      size: 18,
                                      color: Colors.orange[700],
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      _isHistoryExpanded ? '접기' : '펼치기',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.orange[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_isHistoryExpanded) ...[
                                const SizedBox(height: 6),
                                Container(
                                  constraints: const BoxConstraints(maxHeight: 200),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: post.updatedAtHistory
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        final index = entry.key;
                                        final date = entry.value;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            left: 20,
                                            bottom: 4,
                                          ),
                                          child: Text(
                                            '${index + 1}차: ${DateFormat('yyyy.MM.dd HH:mm').format(date)}',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.orange[600],
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ] else ...[
                                // 접혀있을 때는 최근 수정 시간만 표시
                                Padding(
                                  padding: const EdgeInsets.only(left: 20, top: 4),
                                  child: Text(
                                    '최근 수정: ${DateFormat('yyyy.MM.dd HH:mm').format(post.updatedAt)}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.orange[600],
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                const Divider(height: 32),
                // 내용
                Text(
                  post.content,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.6,
                  ),
                ),
                const Divider(height: 32),
                // 댓글 섹션
                Row(
                  children: [
                    Icon(Icons.comment, size: 20, color: Colors.blue[600]),
                    const SizedBox(width: 8),
                    Text(
                      '댓글',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // 댓글 작성 폼
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: '댓글을 입력하세요...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        maxLines: null,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (value) => _submitComment(post.id),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _isCommentLoading
                          ? null
                          : () => _submitComment(post.id),
                      icon: _isCommentLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                      color: Colors.blue,
                      tooltip: '댓글 작성',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // 댓글 목록 (실시간)
                StreamBuilder<List<Comment>>(
                  key: ValueKey('comments_${post.id}'), // 같은 인스턴스 유지
                  stream: _firestoreService.getComments(post.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      final errorString = snapshot.error.toString();
                      final isIndexError = errorString.contains('index') ||
                          errorString.contains('failed-precondition');

                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  size: 48, color: Colors.red[600]),
                              const SizedBox(height: 16),
                              const Text(
                                '오류 발생',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 200,
                                ),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SingleChildScrollView(
                                  child: SelectableText(
                                    errorString,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              if (isIndexError) ...[
                                const Text(
                                  'Firestore 인덱스가 필요합니다.\n아래 버튼을 클릭하여 인덱스를 생성하세요.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // Firebase Console 인덱스 생성 안내
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                          'Firebase Console에서 인덱스를 생성해주세요.\n\n1. Firestore Database → 색인 탭\n2. 복합 색인 만들기\n3. 컬렉션: comments\n4. 필드: postId (Ascending), createdAt (Ascending)',
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        duration: const Duration(seconds: 10),
                                        action: SnackBarAction(
                                          label: '상세 가이드',
                                          onPressed: () {
                                            // 가이드 파일을 보여줄 수 있습니다
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.link),
                                  label: const Text('인덱스 생성 가이드'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ] else
                                ElevatedButton(
                                  onPressed: () {
                                    // StreamBuilder가 자동으로 다시 시도
                                    setState(() {});
                                  },
                                  child: const Text('다시 시도'),
                                ),
                            ],
                          ),
                        ),
                      );
                    }

                    final comments = snapshot.data ?? [];

                    if (comments.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            '아직 댓글이 없습니다.\n첫 댓글을 작성해보세요!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      );
                    }

                    // 일반 댓글과 대댓글을 분리
                    final rootComments = comments.where((c) => c.isRootComment).toList();
                    final replies = comments.where((c) => c.isReply).toList();

                    // 각 댓글의 대댓글 개수 계산
                    final replyCounts = <String, int>{};
                    for (final reply in replies) {
      replyCounts[reply.parentCommentId ?? ''] = (replyCounts[reply.parentCommentId ?? ''] ?? 0) + 1;
    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: rootComments.length,
                      itemBuilder: (context, rootIndex) {
                        final comment = rootComments[rootIndex];
                        final isCommentOwner = _isCommentOwner(comment);
                        final replyCount = replyCounts[comment.id] ?? 0;
                        final isRepliesVisible = _commentRepliesVisible[comment.id] ?? true;
                        final commentReplies = replies
                            .where((r) => r.parentCommentId == comment.id)
                            .toList()
                          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 일반 댓글 카드
                            Card(
                              margin: const EdgeInsets.only(bottom: 12),
                              elevation: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          size: 16,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            comment.author,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          _formatShortDate(comment.createdAt),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                        if (comment.isModified) ...[
                                          const SizedBox(width: 4),
                                          Text(
                                            '(수정됨)',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.orange[600],
                                            ),
                                          ),
                                        ],
                                        if (isCommentOwner) ...[
                                          const SizedBox(width: 4),
                                          IconButton(
                                            icon: const Icon(Icons.edit_outlined),
                                            iconSize: 18,
                                            color: Colors.blue,
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () => _editComment(comment),
                                            tooltip: '댓글 수정',
                                          ),
                                          const SizedBox(width: 4),
                                          IconButton(
                                            icon: const Icon(Icons.delete_outline),
                                            iconSize: 18,
                                            color: Colors.red,
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () => _deleteComment(comment),
                                            tooltip: '댓글 삭제',
                                          ),
                                        ],
                                      ],
                                    ),
                                const SizedBox(height: 8),
                                Text(
                                  comment.content,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                                // 수정 히스토리 표시 (수정된 경우만)
                                if (comment.isModified) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.edit, size: 14, color: Colors.orange[600]),
                                      const SizedBox(width: 4),
                                      if (comment.updatedAtHistory.length == 1) ...[
                                        // 수정 1번
                                        Text(
                                          '수정: ${DateFormat('yyyy.MM.dd HH:mm').format(comment.updatedAt)}',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.orange[600],
                                          ),
                                        ),
                                      ] else ...[
                                        // 수정 여러 번 - 접을 수 있는 리스트
                                        InkWell(
                                          onTap: () {
                                            // 현재 스크롤 위치 저장
                                            final currentScrollOffset = _scrollController.hasClients
                                                ? _scrollController.offset
                                                : 0.0;
                                            
                                            setState(() {
                                              _commentHistoryExpanded[comment.id] =
                                                  !(_commentHistoryExpanded[comment.id] ?? false);
                                            });
                                            
                                            // 스크롤 위치 복원 (여러 프레임을 기다려서 완전히 렌더링 후)
                                            if (_scrollController.hasClients && currentScrollOffset > 0) {
                                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                                Future.delayed(const Duration(milliseconds: 50), () {
                                                  WidgetsBinding.instance.addPostFrameCallback((_) {
                                                    if (mounted && _scrollController.hasClients) {
                                                      _scrollController.jumpTo(currentScrollOffset);
                                                    }
                                                  });
                                                });
                                              });
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '수정 (${comment.updatedAtHistory.length}회)',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.orange[600],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Icon(
                                                (_commentHistoryExpanded[comment.id] ?? false)
                                                    ? Icons.expand_less
                                                    : Icons.expand_more,
                                                size: 16,
                                                color: Colors.orange[600],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  // 펼쳐있을 때 히스토리 리스트 표시
                                  if ((_commentHistoryExpanded[comment.id] ?? false) &&
                                      comment.updatedAtHistory.length > 1) ...[
                                    const SizedBox(height: 4),
                                    ...comment.updatedAtHistory.asMap().entries.map((entry) {
                                      final index = entry.key;
                                      final date = entry.value;
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 18, bottom: 2),
                                        child: Text(
                                          '${index + 1}차: ${DateFormat('yyyy.MM.dd HH:mm').format(date)}',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.orange[600],
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ],
                                // 대댓글 개수 표시 및 접기/펼치기 버튼
                                if (replyCount > 0) ...[
                                  const SizedBox(height: 8),
                                  InkWell(
                                    onTap: () {
                                      // 현재 스크롤 위치 저장
                                      final currentScrollOffset = _scrollController.hasClients
                                          ? _scrollController.offset
                                          : 0.0;
                                      
                                      setState(() {
                                        _commentRepliesVisible[comment.id] =
                                            !(_commentRepliesVisible[comment.id] ?? true);
                                      });
                                      
                                      // 스크롤 위치 복원 (여러 프레임을 기다려서 완전히 렌더링 후)
                                      if (_scrollController.hasClients && currentScrollOffset > 0) {
                                        WidgetsBinding.instance.addPostFrameCallback((_) {
                                          Future.delayed(const Duration(milliseconds: 50), () {
                                            WidgetsBinding.instance.addPostFrameCallback((_) {
                                              if (mounted && _scrollController.hasClients) {
                                                _scrollController.jumpTo(currentScrollOffset);
                                              }
                                            });
                                          });
                                        });
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isRepliesVisible ? Icons.expand_less : Icons.expand_more,
                                          size: 18,
                                          color: Colors.blue[600],
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '답글 ${replyCount}개 ${isRepliesVisible ? '접기' : '보기'}',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.blue[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                // 답글 버튼 및 작성 폼
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {
                                        // 현재 스크롤 위치 저장
                                        final currentScrollOffset = _scrollController.hasClients
                                            ? _scrollController.offset
                                            : 0.0;
                                        
                                        // 상태 업데이트 (스크롤 위치 복원을 위해 미리 저장)
                                        final newExpandedState = !(_commentReplyExpanded[comment.id] ?? false);
                                        
                                        setState(() {
                                          _commentReplyExpanded[comment.id] = newExpandedState;
                                          
                                          // 답글 입력 필드 생성/제거
                                          if (newExpandedState) {
                                            _replyControllers[comment.id] ??=
                                                TextEditingController();
                                          }
                                        });
                                        
                                        // 스크롤 위치 복원 (즉시 + 지연 복원)
                                        if (_scrollController.hasClients && currentScrollOffset > 0) {
                                          // 즉시 복원 시도
                                          Future.microtask(() {
                                            if (mounted && _scrollController.hasClients) {
                                              _scrollController.jumpTo(currentScrollOffset);
                                            }
                                          });
                                          
                                          // 지연 복원 (렌더링 완료 후)
                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                            Future.delayed(const Duration(milliseconds: 100), () {
                                              if (mounted && _scrollController.hasClients) {
                                                _scrollController.jumpTo(currentScrollOffset);
                                              }
                                            });
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.reply,
                                        size: 16,
                                        color: Colors.blue[600],
                                      ),
                                      label: Text(
                                        (_commentReplyExpanded[comment.id] ?? false)
                                            ? '답글 취소'
                                            : '답글',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue[600],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // 답글 작성 폼
                                if (_commentReplyExpanded[comment.id] ?? false) ...[
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: _replyControllers[comment.id],
                                          decoration: InputDecoration(
                                            hintText: '답글을 입력하세요...',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            contentPadding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                            filled: true,
                                            fillColor: Colors.grey[50],
                                            isDense: true,
                                          ),
                                          maxLines: null,
                                          textInputAction: TextInputAction.send,
                                          onSubmitted: (_) =>
                                              _submitReply(post.id, comment.id),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      IconButton(
                                        onPressed: _isCommentLoading
                                            ? null
                                            : () => _submitReply(post.id, comment.id),
                                        icon: _isCommentLoading
                                            ? const SizedBox(
                                                width: 16,
                                                height: 16,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : const Icon(Icons.send),
                                        color: Colors.blue,
                                        iconSize: 20,
                                        tooltip: '답글 작성',
                                      ),
                                    ],
                                  ),
                                ],
                                // 대댓글 목록 (펼쳐있을 때만)
                                if (isRepliesVisible && replyCount > 0)
                                  ...commentReplies.map<Widget>((reply) {
                                final isReplyOwner = _isCommentOwner(reply);
                                return Card(
                                  margin: const EdgeInsets.only(
                                    bottom: 12,
                                    left: 24, // 대댓글은 들여쓰기
                                  ),
                                  elevation: 1,
                                  color: Colors.grey[50], // 대댓글은 배경색 변경
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // 대댓글 표시
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.reply,
                                              size: 14,
                                              color: Colors.blue[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '답글',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.blue[600],
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 16,
                                              color: Colors.grey[600],
                                            ),
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                reply.author,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[800],
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              _formatShortDate(reply.createdAt),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            if (reply.isModified) ...[
                                              const SizedBox(width: 4),
                                              Text(
                                                '(수정됨)',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.orange[600],
                                                ),
                                              ),
                                            ],
                                            if (isReplyOwner) ...[
                                              const SizedBox(width: 4),
                                              IconButton(
                                                icon: const Icon(Icons.edit_outlined),
                                                iconSize: 18,
                                                color: Colors.blue,
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                onPressed: () => _editComment(reply),
                                                tooltip: '댓글 수정',
                                              ),
                                              const SizedBox(width: 4),
                                              IconButton(
                                                icon: const Icon(Icons.delete_outline),
                                                iconSize: 18,
                                                color: Colors.red,
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                onPressed: () => _deleteComment(reply),
                                                tooltip: '댓글 삭제',
                                              ),
                                            ],
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          reply.content,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            height: 1.4,
                                          ),
                                        ),
                                        // 수정 히스토리 표시 (수정된 경우만)
                                        if (reply.isModified) ...[
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Icon(Icons.edit, size: 14, color: Colors.orange[600]),
                                              const SizedBox(width: 4),
                                              if (reply.updatedAtHistory.length == 1) ...[
                                                Text(
                                                  '수정: ${DateFormat('yyyy.MM.dd HH:mm').format(reply.updatedAt)}',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.orange[600],
                                                  ),
                                                ),
                                              ] else ...[
                                                InkWell(
                                                  onTap: () {
                                                    // 현재 스크롤 위치 저장
                                                    final currentScrollOffset = _scrollController.hasClients
                                                        ? _scrollController.offset
                                                        : 0.0;
                                                    
                                                    setState(() {
                                                      _commentHistoryExpanded[reply.id] =
                                                          !(_commentHistoryExpanded[reply.id] ?? false);
                                                    });
                                                    
                                                    // 스크롤 위치 복원 (여러 프레임을 기다려서 완전히 렌더링 후)
                                                    if (_scrollController.hasClients && currentScrollOffset > 0) {
                                                      WidgetsBinding.instance.addPostFrameCallback((_) {
                                                        Future.delayed(const Duration(milliseconds: 50), () {
                                                          WidgetsBinding.instance.addPostFrameCallback((_) {
                                                            if (mounted && _scrollController.hasClients) {
                                                              _scrollController.jumpTo(currentScrollOffset);
                                                            }
                                                          });
                                                        });
                                                      });
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        '수정 (${reply.updatedAtHistory.length}회)',
                                                        style: TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.orange[600],
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Icon(
                                                        (_commentHistoryExpanded[reply.id] ?? false)
                                                            ? Icons.expand_less
                                                            : Icons.expand_more,
                                                        size: 16,
                                                        color: Colors.orange[600],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                          if ((_commentHistoryExpanded[reply.id] ?? false) &&
                                              reply.updatedAtHistory.length > 1) ...[
                                            const SizedBox(height: 4),
                                            ...reply.updatedAtHistory.asMap().entries.map((entry) {
                                              final index = entry.key;
                                              final date = entry.value;
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 18, bottom: 2),
                                                child: Text(
                                                  '${index + 1}차: ${DateFormat('yyyy.MM.dd HH:mm').format(date)}',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.orange[600],
                                                  ),
                                                ),
                                              );
                                            }),
                                          ],
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                                  }).toList(),
                              ],
                            ),
                            ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


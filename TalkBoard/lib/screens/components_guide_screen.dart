import 'package:flutter/material.dart';

class ComponentsGuideScreen extends StatelessWidget {
  const ComponentsGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공통 컴포넌트 가이드'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 개요
            _buildSection(
              context,
              title: '📋 개요',
              content: '앱 전반에서 재사용할 수 있는 공통 컴포넌트, 레이아웃, 유틸리티를 정의합니다.',
            ),
            const SizedBox(height: 24),
            
            // 버튼
            _buildSection(
              context,
              title: '1. 버튼 (Buttons)',
              content: '주요 액션 버튼, 보조 버튼, 위험 버튼, 아이콘 버튼 등',
              children: [
                _buildButtonExample(
                  context,
                  'PrimaryButton',
                  '주요 액션',
                  Colors.blue,
                  () {},
                ),
                const SizedBox(height: 8),
                _buildButtonExample(
                  context,
                  'SecondaryButton',
                  '보조 액션',
                  Colors.transparent,
                  () {},
                  isOutlined: true,
                ),
                const SizedBox(height: 8),
                _buildButtonExample(
                  context,
                  'DangerButton',
                  '위험한 액션',
                  Colors.red,
                  () {},
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {},
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text('IconButton'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 입력 폼
            _buildSection(
              context,
              title: '2. 입력 폼 (Input Forms)',
              content: '텍스트 입력, 날짜 선택, 이미지 선택, 오디오 녹음 등',
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'TextInputField',
                    hintText: '텍스트를 입력하세요',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  enabled: false,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'TextAreaField',
                    hintText: '여러 줄 텍스트를 입력하세요',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  enabled: false,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'DatePickerField',
                    hintText: '날짜를 선택하세요',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  enabled: false,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 카드
            _buildSection(
              context,
              title: '3. 카드 (Cards)',
              content: '추모관 카드, 댓글 카드, 기도 카드, 감정 카드 등',
              children: [
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue[100],
                      child: const Icon(Icons.person),
                    ),
                    title: const Text('MemorialCard'),
                    subtitle: const Text('추모관 카드 예시'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue[100],
                              child: const Icon(Icons.person, size: 16),
                            ),
                            const SizedBox(width: 8),
                            const Text('작성자'),
                            const Spacer(),
                            Text(
                              '방금 전',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('CommentCard - 댓글 카드 예시'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 레이아웃
            _buildSection(
              context,
              title: '4. 레이아웃 (Layouts)',
              content: '앱 스캐폴드, 단계 표시기, 로딩 오버레이, 빈 상태 등',
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue[200]!),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text('AppScaffold - 앱 기본 레이아웃'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStep(1, true),
                          _buildStep(2, true),
                          _buildStep(3, false),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('StepIndicator - 단계 표시기'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // 유틸리티
            _buildSection(
              context,
              title: '5. 유틸리티 (Utilities)',
              content: '유효성 검사, 포맷팅, 이미지 처리, 저장소 처리 등',
              children: [
                _buildUtilityItem('Validators', '입력 유효성 검사'),
                _buildUtilityItem('Formatters', '데이터 포맷팅'),
                _buildUtilityItem('ImageUtils', '이미지 처리'),
                _buildUtilityItem('StorageUtils', '파일 저장소 처리'),
                _buildUtilityItem('NavigationUtils', '네비게이션 유틸리티'),
                _buildUtilityItem('PermissionUtils', '권한 처리'),
              ],
            ),
            const SizedBox(height: 24),
            
            // 상수
            _buildSection(
              context,
              title: '6. 상수 (Constants)',
              content: '색상, 크기, 텍스트 스타일, 제한 값 등',
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildColorBox(Colors.blue, 'Primary'),
                    _buildColorBox(Colors.red, 'Danger'),
                    _buildColorBox(Colors.green, 'Success'),
                    _buildColorBox(Colors.orange, 'Warning'),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('AppColors - 앱 색상 상수'),
                const SizedBox(height: 8),
                const Text('AppSizes - 앱 크기 상수 (padding, margin, borderRadius)'),
                const SizedBox(height: 8),
                const Text('AppTextStyles - 앱 텍스트 스타일 (heading1, body, caption)'),
                const SizedBox(height: 8),
                const Text('AppLimits - 앱 제한 상수 (maxPhotos, maxPhotoSize)'),
              ],
            ),
            const SizedBox(height: 24),
            
            // 문서 링크
            _buildSection(
              context,
              title: '📚 상세 문서',
              content: '더 자세한 내용은 다음 문서를 참고하세요:',
              children: [
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('docs/planning/COMPONENTS.md'),
                  subtitle: const Text('공통 컴포넌트 상세 가이드'),
                  onTap: () {
                    // 문서 링크 (향후 구현)
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
    List<Widget>? children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        if (children != null) ...[
          const SizedBox(height: 16),
          ...children,
        ],
      ],
    );
  }

  Widget _buildButtonExample(
    BuildContext context,
    String label,
    String text,
    Color backgroundColor,
    VoidCallback onPressed, {
    bool isOutlined = false,
  }) {
    if (isOutlined) {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.blue,
          side: const BorderSide(color: Colors.blue),
        ),
        child: Text(text),
      );
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
      ),
      child: Text(text),
    );
  }

  Widget _buildUtilityItem(String name, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(Icons.code, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(width: 8),
          Text(
            '- $description',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildColorBox(Color color, String label) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step, bool isCompleted) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? Colors.blue : Colors.grey[300],
      ),
      child: Center(
        child: Text(
          '$step',
          style: TextStyle(
            color: isCompleted ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


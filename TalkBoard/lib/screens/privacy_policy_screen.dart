import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('개인정보처리방침'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '톡보드 개인정보처리방침',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '최종 수정일: ${DateTime.now().toString().split(' ')[0]}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '톡보드("회사" 또는 "당사"라 함)는 이용자의 개인정보를 보호하기 위하여 최선을 다하고 있습니다. 이에 「개인정보 보호법」 제30조에 따라 정보주체의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리방침을 수립·공개합니다.',
              style: TextStyle(fontSize: 14, height: 1.6),
            ),
            const SizedBox(height: 32),
            _buildSection(
              title: '1. 개인정보의 처리 목적',
              content: '''톡보드는 다음의 목적을 위하여 개인정보를 처리합니다. 처리하고 있는 개인정보는 다음의 목적 이외의 용도로는 이용되지 않으며, 이용 목적이 변경되는 경우에는 「개인정보 보호법」 제18조에 따라 별도의 동의를 받는 등 필요한 조치를 이행할 예정입니다.

1) 회원 가입 및 관리
- 회원 가입 의사 확인, 회원제 서비스 제공에 따른 본인 식별·인증
- 회원 자격 유지·관리, 서비스 부정이용 방지
- 각종 고지·통지, 고충처리

2) 서비스 제공
- 게시글 작성, 수정, 삭제
- 댓글 작성, 수정, 삭제
- 실시간 게시판 서비스 제공''',
            ),
            _buildSection(
              title: '2. 개인정보의 처리 및 보유기간',
              content: '''1) 톡보드는 법령에 따른 개인정보 보유·이용기간 또는 정보주체로부터 개인정보를 수집 시에 동의받은 개인정보 보유·이용기간 내에서 개인정보를 처리·보유합니다.

2) 각각의 개인정보 처리 및 보유 기간은 다음과 같습니다.
- 회원 가입 및 관리: 회원 탈퇴 시까지
- 게시글 및 댓글: 회원 탈퇴 시까지 또는 삭제 시까지

3) 단, 법령에 따라 일정기간 보관이 필요한 정보는 해당 기간 동안 보관합니다.
- 전자상거래 등에서의 소비자 보호에 관한 법률: 5년
- 통신비밀보호법: 3개월''',
            ),
            _buildSection(
              title: '3. 처리하는 개인정보의 항목',
              content: '''톡보드는 다음의 개인정보 항목을 처리하고 있습니다:

1) 회원 가입 시 수집 항목
- 필수: 이메일 주소, 비밀번호, 사용자 표시 이름
- 자동 수집: 사용자 고유 ID (Firebase Authentication UID)

2) 서비스 이용 시 생성되는 정보
- 작성한 게시글 및 댓글 내용
- 게시글 조회수
- 게시글/댓글 작성 및 수정 시간

3) Firebase 서비스 이용을 통한 자동 수집 정보
- Firebase Authentication을 통한 인증 정보
- Firebase Firestore를 통한 데이터 저장 정보''',
            ),
            _buildSection(
              title: '4. 개인정보의 제3자 제공',
              content: '''톡보드는 정보주체의 개인정보를 제1조(개인정보의 처리 목적)에서 명시한 범위 내에서만 처리하며, 정보주체의 동의, 법률의 특별한 규정 등 「개인정보 보호법」 제17조 및 제18조에 해당하는 경우에만 개인정보를 제3자에게 제공합니다.

톡보드는 Firebase 서비스를 이용하여 개인정보를 처리하고 있으며, Firebase는 Google의 개인정보처리방침을 따릅니다.''',
            ),
            _buildSection(
              title: '5. 개인정보처리의 위탁',
              content: '''톡보드는 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다:

1) Firebase (Google LLC)
- 위탁 업무 내용: 사용자 인증, 데이터 저장 및 관리
- 개인정보 보유 및 이용 기간: 회원 탈퇴 시까지 또는 위탁 계약 종료 시까지
- Google 개인정보처리방침: https://policies.google.com/privacy''',
            ),
            _buildSection(
              title: '6. 정보주체의 권리·의무 및 그 행사방법',
              content: '''1) 정보주체는 톡보드에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.
- 개인정보 열람 요구
- 오류 등이 있을 경우 정정 요구
- 삭제 요구
- 처리정지 요구

2) 제1항에 따른 권리 행사는 톡보드에 대해 서면, 전자우편 등을 통하여 하실 수 있으며, 톡보드는 이에 대해 지체 없이 조치하겠습니다.

3) 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 톡보드는 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.''',
            ),
            _buildSection(
              title: '7. 개인정보의 파기',
              content: '''톡보드는 개인정보 보유기간의 경과, 처리목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.

1) 파기 절차
- 이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다.

2) 파기 방법
- 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.''',
            ),
            _buildSection(
              title: '8. 개인정보 보호책임자',
              content: '''톡보드는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.

▶ 개인정보 보호책임자
- 연락처: [이메일 주소 또는 연락처를 입력하세요]
- 담당부서: [담당 부서명을 입력하세요]

정보주체께서는 톡보드의 서비스를 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자에게 문의하실 수 있습니다.''',
            ),
            _buildSection(
              title: '9. 개인정보의 안전성 확보 조치',
              content: '''톡보드는 「개인정보 보호법」 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.

1) 개인정보의 암호화
- 이용자의 개인정보는 비밀번호는 암호화되어 저장 및 관리되고 있습니다.

2) 해킹 등에 대비한 기술적 대책
- Firebase의 보안 기능을 활용하여 개인정보를 보호하고 있습니다.

3) 개인정보처리시스템 등의 접근권한 관리
- 개인정보를 처리하는 직원을 지정하고 담당자에 따른 접근권한을 부여하고 있습니다.''',
            ),
            _buildSection(
              title: '10. 개인정보처리방침 변경',
              content: '''이 개인정보처리방침은 법령·정책 또는 보안기술의 변경에 따라 내용의 추가·삭제 및 수정이 있을 시에는 변경사항의 시행 7일 전부터 홈페이지의 공지사항을 통하여 고지할 것입니다.

- 공고일자: ${DateTime.now().toString().split(' ')[0]}
- 시행일자: ${DateTime.now().toString().split(' ')[0]}''',
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '문의처',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '개인정보 보호와 관련하여 문의사항이 있으시면 위 개인정보 보호책임자에게 연락주시기 바랍니다.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'modal_previews/preview_delete_confirm_modal.dart';
import 'modal_previews/preview_logout_confirm_modal.dart';
import 'modal_previews/preview_donation_modal.dart';
import 'modal_previews/preview_withdrawal_modal.dart';
import 'modal_previews/preview_memorial_share_modal.dart';
import 'modal_previews/preview_image_viewer_modal.dart';
import 'modal_previews/preview_prayer_create_modal.dart';
import 'modal_previews/preview_password_change_modal.dart';
import 'modal_previews/preview_home_public_suggestion_modal.dart';
import 'modal_previews/preview_payment_confirm_modal.dart';
import 'modal_previews/preview_payment_complete_modal.dart';
import 'modal_previews/preview_comment_edit_modal.dart';
import 'modal_previews/preview_category_select_modal.dart';
import 'modal_previews/preview_bank_select_modal.dart';
import 'modal_previews/preview_memorial_select_modal.dart';
import 'modal_previews/preview_video_player_modal.dart';
import 'modal_previews/preview_audio_player_modal.dart';
import 'modal_previews/preview_item_purchase_confirm_modal.dart';
import 'modal_previews/preview_item_purchase_complete_modal.dart';
import 'modal_previews/preview_premium_subscribe_confirm_modal.dart';
import 'modal_previews/preview_premium_subscribe_complete_modal.dart';
import 'modal_previews/preview_history_detail_modal.dart';
import 'modal_previews/preview_stats_detail_modal.dart';
import 'modal_previews/preview_will_delete_confirm_modal.dart';
import 'modal_previews/preview_will_public_toggle_modal.dart';
import 'modal_previews/preview_will_share_modal.dart';
import 'modal_previews/preview_will_template_select_modal.dart';
import 'modal_previews/preview_matching_request_modal.dart';
import 'modal_previews/preview_matching_accept_reject_modal.dart';
import 'modal_previews/preview_matching_end_confirm_modal.dart';
import 'modal_previews/preview_matching_report_modal.dart';
import 'modal_previews/preview_matching_terms_modal.dart';
import 'modal_previews/preview_matching_profile_delete_modal.dart';
import 'modal_previews/preview_matching_request_cancel_modal.dart';
import 'modal_previews/preview_event_participate_modal.dart';
import 'modal_previews/preview_reward_received_modal.dart';
import 'modal_previews/preview_coupon_use_modal.dart';
import 'modal_previews/preview_event_condition_not_met_modal.dart';

class ModalsPreviewListScreen extends StatelessWidget {
  const ModalsPreviewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color softCream = Color(0xFFFFF8F0);

    return Container(
      color: softCream,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '팝업/모달 프리뷰',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
              color: Color(0xFF8B7355),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '각 팝업의 UI를 미리 확인할 수 있습니다.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF5C5C5C),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('확인/선택 팝업'),
          _buildModalCard(
            context,
            '삭제 확인 팝업',
            '추모관, 댓글 삭제 확인',
            Icons.delete_outline,
            () => _showModal(context, const PreviewDeleteConfirmModal()),
          ),
          _buildModalCard(
            context,
            '로그아웃 확인 팝업',
            '로그아웃 확인',
            Icons.exit_to_app,
            () => _showModal(context, const PreviewLogoutConfirmModal()),
          ),
          _buildModalCard(
            context,
            '카테고리 선택 팝업',
            '감정 공유 글 카테고리 선택',
            Icons.category,
            () => _showModal(context, const PreviewCategorySelectModal()),
          ),
          _buildModalCard(
            context,
            '은행 선택 팝업',
            '추모금 출금 은행 선택',
            Icons.account_balance,
            () => _showModal(context, const PreviewBankSelectModal()),
          ),
          _buildModalCard(
            context,
            '추모관 선택 팝업',
            '기도 요청 추모관 연결',
            Icons.book_outlined,
            () => _showModal(context, const PreviewMemorialSelectModal()),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('입력 팝업'),
          _buildModalCard(
            context,
            '추모금 전달 팝업',
            '추모금 금액 입력 및 결제',
            Icons.account_balance_wallet,
            () => _showModal(context, const PreviewDonationModal()),
          ),
          _buildModalCard(
            context,
            '추모금 출금 요청 팝업',
            '출금 금액 및 계좌 정보 입력',
            Icons.money_off,
            () => _showModal(context, const PreviewWithdrawalModal()),
          ),
          _buildModalCard(
            context,
            '기도 요청 작성 팝업',
            '기도 요청 제목 및 내용 작성',
            Icons.favorite_border,
            () => _showModal(context, const PreviewPrayerCreateModal()),
          ),
          _buildModalCard(
            context,
            '비밀번호 변경 팝업',
            '현재/새 비밀번호 입력',
            Icons.lock_outline,
            () => _showModal(context, const PreviewPasswordChangeModal()),
          ),
          _buildModalCard(
            context,
            '댓글 수정 팝업',
            '댓글 내용 수정',
            Icons.edit_outlined,
            () => _showModal(context, const PreviewCommentEditModal()),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('조회 팝업'),
          _buildModalCard(
            context,
            '추모관 공유 팝업',
            '링크, QR 코드, SNS 공유',
            Icons.share,
            () => _showModal(context, const PreviewMemorialShareModal()),
          ),
          _buildModalCard(
            context,
            '이미지 뷰어 팝업',
            '이미지 확대 보기',
            Icons.image,
            () => _showModal(context, const PreviewImageViewerModal()),
          ),
          _buildModalCard(
            context,
            '동영상 플레이어 팝업',
            '동영상 재생',
            Icons.play_circle_outline,
            () => _showModal(context, const PreviewVideoPlayerModal()),
          ),
          _buildModalCard(
            context,
            '오디오 플레이어 팝업',
            '음성 편지 재생',
            Icons.audiotrack,
            () => _showModal(context, const PreviewAudioPlayerModal()),
          ),
          _buildModalCard(
            context,
            '홈 화면 공개 제안 팝업',
            '공감을 많이 받은 편지 공개 제안',
            Icons.home,
            () => _showModal(context, const PreviewHomePublicSuggestionModal()),
          ),
          _buildModalCard(
            context,
            '내역 상세 보기 팝업',
            '추모금 내역 상세 정보',
            Icons.receipt_long,
            () => _showModal(context, const PreviewHistoryDetailModal()),
          ),
          _buildModalCard(
            context,
            '통계 상세 보기 팝업',
            '추모관 통계 상세 그래프',
            Icons.bar_chart,
            () => _showModal(context, const PreviewStatsDetailModal()),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('결제 팝업'),
          _buildModalCard(
            context,
            '결제 확인 팝업',
            '결제 정보 확인 및 동의',
            Icons.payment,
            () => _showModal(context, const PreviewPaymentConfirmModal()),
          ),
          _buildModalCard(
            context,
            '결제 완료 팝업',
            '결제 완료 알림',
            Icons.check_circle_outline,
            () => _showModal(context, const PreviewPaymentCompleteModal()),
          ),
          _buildModalCard(
            context,
            '아이템 구매 확인 팝업',
            '아이템 구매 정보 확인',
            Icons.shopping_cart_outlined,
            () => _showModal(context, const PreviewItemPurchaseConfirmModal()),
          ),
          _buildModalCard(
            context,
            '아이템 구매 완료 팝업',
            '아이템 구매 완료 알림',
            Icons.check_circle_outline,
            () => _showModal(context, const PreviewItemPurchaseCompleteModal()),
          ),
          _buildModalCard(
            context,
            '프리미엄 구독 확인 팝업',
            '프리미엄 구독 정보 확인',
            Icons.star_outline,
            () => _showModal(context, const PreviewPremiumSubscribeConfirmModal()),
          ),
          _buildModalCard(
            context,
            '프리미엄 구독 완료 팝업',
            '프리미엄 구독 완료 알림',
            Icons.star,
            () => _showModal(context, const PreviewPremiumSubscribeCompleteModal()),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('유언장 팝업'),
          _buildModalCard(
            context,
            '유언 삭제 확인 팝업',
            '유언 삭제 확인',
            Icons.delete_outline,
            () => _showModal(context, const PreviewWillDeleteConfirmModal()),
          ),
          _buildModalCard(
            context,
            '유언 공개 상태 변경 팝업',
            '공개/비공개 전환 확인',
            Icons.lock_outline,
            () => _showModal(context, const PreviewWillPublicToggleModal()),
          ),
          _buildModalCard(
            context,
            '유언 공유 팝업',
            '유언 링크 및 SNS 공유',
            Icons.share,
            () => _showModal(context, const PreviewWillShareModal()),
          ),
          _buildModalCard(
            context,
            '유언 템플릿 선택 팝업',
            '유언 작성 템플릿 선택',
            Icons.article,
            () => _showModal(context, const PreviewWillTemplateSelectModal()),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('상호 위로 매칭 팝업'),
          _buildModalCard(
            context,
            '매칭 신청 확인 팝업',
            '매칭 신청 메시지 작성',
            Icons.favorite_border,
            () => _showModal(context, const PreviewMatchingRequestModal()),
          ),
          _buildModalCard(
            context,
            '매칭 수락/거절 확인 팝업',
            '받은 신청 수락 또는 거절',
            Icons.handshake,
            () => _showModal(context, const PreviewMatchingAcceptRejectModal()),
          ),
          _buildModalCard(
            context,
            '매칭 종료 확인 팝업',
            '활성 매칭 종료 확인',
            Icons.close,
            () => _showModal(context, const PreviewMatchingEndConfirmModal()),
          ),
          _buildModalCard(
            context,
            '신고 사유 선택 팝업',
            '부적절한 프로필 또는 대화 신고',
            Icons.report,
            () => _showModal(context, const PreviewMatchingReportModal()),
          ),
          _buildModalCard(
            context,
            '이용 약관 동의 팝업',
            '매칭 서비스 이용 약관 동의',
            Icons.description,
            () => _showModal(context, const PreviewMatchingTermsModal()),
          ),
          _buildModalCard(
            context,
            '프로필 삭제 확인 팝업',
            '매칭 프로필 삭제 확인',
            Icons.delete_outline,
            () => _showModal(context, const PreviewMatchingProfileDeleteModal()),
          ),
          _buildModalCard(
            context,
            '신청 취소 확인 팝업',
            '보낸 매칭 신청 취소',
            Icons.cancel_outlined,
            () => _showModal(context, const PreviewMatchingRequestCancelModal()),
          ),
          const SizedBox(height: 16),
          _buildSectionTitle('감사 혜택 팝업'),
          _buildModalCard(
            context,
            '감사 혜택 참여 확인 팝업',
            '감사 혜택 참여 확인',
            Icons.card_giftcard,
            () => _showModal(context, const PreviewEventParticipateModal()),
          ),
          _buildModalCard(
            context,
            '혜택 지급 완료 팝업',
            '감사 혜택 지급 완료 알림',
            Icons.check_circle_outline,
            () => _showModal(context, const PreviewRewardReceivedModal()),
          ),
          _buildModalCard(
            context,
            '쿠폰 사용 확인 팝업',
            '쿠폰 사용 확인',
            Icons.local_offer,
            () => _showModal(context, const PreviewCouponUseModal()),
          ),
          _buildModalCard(
            context,
            '감사 혜택 조건 미충족 안내 팝업',
            '참여 조건 미충족 안내',
            Icons.info_outline,
            () => _showModal(context, const PreviewEventConditionNotMetModal()),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color(0xFF8B7355),
        ),
      ),
    );
  }

  Widget _buildModalCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    const Color warmBrown = Color(0xFF8B7355);
    const Color warmBeige = Color(0xFFF5F1E8);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Color(0xFF8B7355), width: 2),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [warmBeige, Colors.white],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: warmBrown.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: warmBrown, width: 2),
                ),
                child: Icon(
                  icon,
                  color: warmBrown,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF8B7355),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF5C5C5C),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF8B7355),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showModal(BuildContext context, Widget modal) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => modal,
    );
  }
}


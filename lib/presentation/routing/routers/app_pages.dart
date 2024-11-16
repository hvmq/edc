import 'package:get/get.dart';

import '../../features/all.dart';
import '../../features/auth/reset_password/all.dart';
import '../../features/call_gateway/add_contact/add_contact_binding.dart';
import '../../features/call_gateway/add_contact/add_contact_view.dart';
import '../../features/call_gateway/all.dart';
import '../../features/call_gateway/contact/all.dart';
import '../../features/course/lesson/lesson_binding.dart';
import '../../features/course/lesson/lesson_view.dart';
import '../../features/library/core/routes/app_routes.dart';
import '../../features/library/features/author/author_binding.dart';
import '../../features/library/features/author/author_screen.dart';
import '../../features/library/features/bookdetail/book_detail_binding.dart';
import '../../features/library/features/bookdetail/book_detail_screen.dart';
import '../../features/library/features/cart/cart_binding.dart';
import '../../features/library/features/cart/cart_screen.dart';
import '../../features/library/features/cart/payment_screen.dart';
import '../../features/library/features/cart/voucher_screen.dart';
import '../../features/library/features/history/history_binding.dart';
import '../../features/library/features/history/history_screen.dart';
import '../../features/library/features/library/see_more/my_favorite_screen.dart';
import '../../features/library/features/library/see_more/see_more_binding.dart';
import '../../features/library/features/library/see_more/see_more_screen.dart';
import '../../features/library/features/main/main_binding.dart';
import '../../features/library/features/main/main_screen.dart';
import '../../features/library/features/mybook/mybook_binding.dart';
import '../../features/library/features/mybook/mybook_screen.dart';
import '../../features/library/features/notification/notification_binding.dart';
import '../../features/library/features/notification/notification_screen.dart';
import '../../features/library/features/publicbook/public_book_binding.dart';
import '../../features/library/features/publicbook/public_book_screen.dart';
import '../../features/library/features/publicbook/register_public_book_screen.dart';
import '../../features/library/features/publicbook/terms_and_privacy_policy_screen.dart';
import '../../features/library/features/rating/rating_binding.dart';
import '../../features/library/features/rating/rating_screen.dart';
import '../../features/library/features/reading_book/reading_binding.dart';
import '../../features/library/features/reading_book/reading_screen.dart';
import '../../features/library/features/reading_pdf/reading_pdf_binding.dart';
import '../../features/library/features/reading_pdf/reading_pdf_screen.dart';
import '../../features/library/features/revenue_statistics/detail_order.dart';
import '../../features/library/features/revenue_statistics/detail_revenue_statistics.dart';
import '../../features/library/features/revenue_statistics/receipt_screen.dart';
import '../../features/library/features/revenue_statistics/revenueStatisticsBinding.dart';
import '../../features/library/features/revenue_statistics/revenueStatisticsScreen.dart';
import '../../features/library/features/revenue_statistics/revenue_by_book.dart';
import '../../features/library/features/search/searchDetail/search_detail_screen.dart';
import '../../features/library/features/search/search_binding.dart';
import '../../features/library/features/search/search_screen.dart';
import '../../features/library/features/splash/splash_binding.dart';
import '../../features/library/features/splash/splash_screen.dart';
import '../../features/premium/all.dart';
import '../../features/user/profile/views/profile_business_view.dart';
import '../../features/user/profile/views/profile_vip_view.dart';
import '../middlewares/auth_guard.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initialRoute = Routes.splash;
  static const afterAuthRoute = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.authOption,
      page: () => const AuthOptionView(),
      binding: AuthOptionBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: _Paths.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.profileVIP,
      page: () => const ProfileVIPView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.profileBusiness,
      page: () => const ProfileBusinessView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.resetPassword,
      binding: ResetPasswordBinding(),
      page: () => const ResetPasswordView(),
      transition: Transition.noTransition,
    ),

    GetPage(
      name: _Paths.chatHub,
      page: () => const ChatHubView(),
      binding: ChatHubBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.conversationDetails,
      page: () => const ConversationDetailsView(),
      binding: ConversationDetailsBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.conversationMembers,
      page: () => const ConversationMembersView(),
      binding: ConversationMembersBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.conversationResources,
      page: () => const ConversationResourcesView(),
      binding: ConversationResourcesBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.callGateway,
      page: () => const CallGatewayView(),
      binding: CallGatewayBinding(),
      middlewares: [AuthGuard()],
    ),

    GetPage(
      name: _Paths.search,
      page: () => const SearchInfoView(
        type: '',
      ),
      binding: SearchInfoBinding(),
      middlewares: [AuthGuard()],
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.report,
      page: () => const ReportView(),
      binding: ReportBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.notification,
      page: () => const NotificationView(),
      // binding: NotificationBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.profileInfomationInit,
      page: () => const ProfileInfomationPage(),
    ),
    GetPage(
      name: _Paths.callPage,
      page: () => const CallPage(),
    ),
    GetPage(
      name: _Paths.lesson,
      page: () => const LessonView(),
      binding: LessonBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.edcPremium,
      page: () => const EDCPremiumView(),
      binding: EDCPremiumBinding(),
      middlewares: [AuthGuard()],
    ),
    GetPage(
      name: _Paths.addContactNumber,
      page: () => const AddContactNumberView(),
      binding: AddContactNumberBinding(),
      middlewares: [AuthGuard()],
      transition: Transition.cupertino,
    ),
    GetPage(
      name: _Paths.setting,
      page: () => const SettingView(),
      binding: SettingBinding(),
      middlewares: [AuthGuard()],
    ),
    // Begin lib feat
    GetPage(
        name: AppRoutes.Splash,
        page: () => const SplashScreen(),
        binding: SplashBindings()),
    GetPage(
        name: AppRoutes.Main,
        page: () => const MainScreen(),
        binding: MainBindings()),
    GetPage(
        name: AppRoutes.Reading,
        page: () => const ReadingScreen(),
        binding: ReadingBinding()),
    GetPage(
        name: AppRoutes.ReadingPdf,
        page: () => const ReadingPdfScreen(),
        binding: ReadingPdfBinding()),
    GetPage(
        name: AppRoutes.BookDetail,
        page: () => BookDetailScreen(),
        binding: BookDetailBindings()),
    GetPage(
        name: AppRoutes.Notification,
        page: () => const NotificationScreen(),
        binding: NotificationBindings()),
    GetPage(
        name: AppRoutes.Rating,
        page: () => const RatingScreen(),
        binding: RatingBindings()),
    // GetPage(
    //     name: AppRoutes.BookOpen,
    //     page: () => const BookOpenScreen(),
    //     binding: BookOpenBindings()),
    // GetPage(
    //     name: AppRoutes.SpeakingBook,
    //     page: () => const SpeakingBookScreen(),
    //     binding: BookOpenBindings()),
    GetPage(
        name: AppRoutes.Cart,
        page: () => const CartScreen(),
        binding: CartBindings()),
    GetPage(
        name: AppRoutes.SearchModule,
        page: () => const SearchScreen(),
        binding: SearchBindings()),
    GetPage(
        name: AppRoutes.SearchDetailScreen,
        page: () => const SearchDetailScreen(),
        binding: SearchBindings()),
    GetPage(
        name: AppRoutes.Voucher,
        page: () => const VoucherScreen(),
        binding: CartBindings()),
    GetPage(
        name: AppRoutes.Payment,
        page: () => const PaymentScreen(),
        binding: CartBindings()),
    GetPage(
        name: AppRoutes.MyBook,
        page: () => const MyBookScreen(),
        binding: MyBookBinding()),
    GetPage(
        name: AppRoutes.PublicBook,
        page: () => PublicBookScreen(),
        binding: PublicBookBinding()),
    GetPage(
        name: AppRoutes.RegisterPublicBook,
        page: () => const RegisterPublicBookScreen(),
        binding: PublicBookBinding()),
    GetPage(
        name: AppRoutes.TermsAndPrivacyPolicy,
        page: () => const TermsAndPrivacyPolicyScreen(),
        binding: PublicBookBinding()),
    GetPage(
        name: AppRoutes.SeeMore,
        page: () => const SeeMoreScreen(),
        binding: SeeMoreBindings()),
    GetPage(
        name: AppRoutes.SeeMore,
        page: () => const SeeMoreScreen(),
        binding: SeeMoreBindings()),
    GetPage(
        name: AppRoutes.MyFavorite,
        page: () => const MyFavoriteScreen(),
        binding: SeeMoreBindings()),
    GetPage(
        name: AppRoutes.DetailAuthor,
        page: () => const DetailAuthorScreen(),
        binding: DetailAuthorBindings()),
    GetPage(
        name: AppRoutes.Revenuestatistics,
        page: () => const RevenueStatisticsScreen(),
        binding: Revenuestatisticsbinding()),
    GetPage(
        name: AppRoutes.RevenuesByBook,
        page: () => const RevenueByBookScreen(),
        binding: Revenuestatisticsbinding()),
    GetPage(
        name: AppRoutes.DetailRevenueStatistics,
        page: () => const DetailRevenueStatistics(),
        binding: Revenuestatisticsbinding()),
    GetPage(
        name: AppRoutes.OrderDetailStatistics,
        page: () => const OrderDetailStatistics(),
        binding: Revenuestatisticsbinding()),
    GetPage(
        name: AppRoutes.ReceiptScreen,
        page: () => const ReceiptScreen(),
        binding: Revenuestatisticsbinding()),
    GetPage(
        name: AppRoutes.History,
        page: () => const HistoryScreen(),
        binding: HistoryBindings()),
  ];
}

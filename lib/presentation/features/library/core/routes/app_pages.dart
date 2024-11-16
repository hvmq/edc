import 'package:get/get.dart';

import '../../core/routes/app_routes.dart';
import '../../features/author/author_binding.dart';
import '../../features/author/author_screen.dart';
import '../../features/bookdetail/book_detail_binding.dart';
import '../../features/bookdetail/book_detail_screen.dart';
import '../../features/bookopen/book_open_binding.dart';
import '../../features/bookopen/speaking_book_screen.dart';
import '../../features/cart/cart_binding.dart';
import '../../features/cart/cart_screen.dart';
import '../../features/cart/payment_screen.dart';
import '../../features/cart/voucher_screen.dart';
import '../../features/history/history_binding.dart';
import '../../features/history/history_screen.dart';
import '../../features/library/see_more/my_favorite_screen.dart';
import '../../features/library/see_more/see_more_binding.dart';
import '../../features/library/see_more/see_more_screen.dart';
import '../../features/main/main_binding.dart';
import '../../features/main/main_screen.dart';
import '../../features/mybook/mybook_binding.dart';
import '../../features/mybook/mybook_screen.dart';
import '../../features/notification/notification_binding.dart';
import '../../features/notification/notification_screen.dart';
import '../../features/publicbook/public_book_binding.dart';
import '../../features/publicbook/public_book_screen.dart';
import '../../features/publicbook/register_public_book_screen.dart';
import '../../features/publicbook/terms_and_privacy_policy_screen.dart';
import '../../features/rating/rating_binding.dart';
import '../../features/rating/rating_screen.dart';
import '../../features/reading_book/reading_binding.dart';
import '../../features/reading_book/reading_screen.dart';
import '../../features/reading_pdf/reading_pdf_binding.dart';
import '../../features/reading_pdf/reading_pdf_screen.dart';
import '../../features/revenue_statistics/detail_order.dart';
import '../../features/revenue_statistics/detail_revenue_statistics.dart';
import '../../features/revenue_statistics/receipt_screen.dart';
import '../../features/revenue_statistics/revenueStatisticsBinding.dart';
import '../../features/revenue_statistics/revenueStatisticsScreen.dart';
import '../../features/revenue_statistics/revenue_by_book.dart';
import '../../features/search/searchDetail/search_detail_screen.dart';
import '../../features/search/search_binding.dart';
import '../../features/search/search_screen.dart';
import '../../features/splash/splash_binding.dart';
import '../../features/splash/splash_screen.dart';

final pages = [
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
  GetPage(
      name: AppRoutes.SpeakingBook,
      page: () => const SpeakingBookScreen(),
      binding: BookOpenBindings()),
  // GetPage(
  //     name: AppRoutes.BookOpen,
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

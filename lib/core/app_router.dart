import 'package:auto_route/auto_route.dart';
import '../presentation/presentation.dart';

@MaterialAutoRouter(replaceInRouteName: 'Screen,Route', routes: [
  AutoRoute(path: '/', page: FirstScreen),
  AutoRoute(path: '/second', page: SecondScreen),
  AutoRoute(path: '/api-paging-screen', page: ApiPagingScreen),
])
class $AppRouter {}

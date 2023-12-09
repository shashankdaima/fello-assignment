import 'package:floor/floor.dart';
import 'package:flutter_template/services/db_services/entities/news_entity.dart';

// @dao
// abstract class UserDao {
//   @Query('SELECT * FROM User')
//   Future<List<User>> findAllUser();

//   @Query('SELECT name FROM User')
//   Stream<List<String>> findAllUserName();

//   @Query('SELECT * FROM User WHERE id = :id')
//   Stream<User?> findUserById(int id);

//   @insert
//   Future<void> insertUser(User user);
// }

@dao
abstract class NewsArticleDao {
  @Query('SELECT * FROM news_table')
  Stream<List<NewsEntity>> getAllNews();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNews(NewsEntity user);
}

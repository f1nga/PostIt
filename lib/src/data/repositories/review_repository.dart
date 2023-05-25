
import "../models/review.dart";
import "../models/user.dart";

/// Abstract class that contains the necessary methods for the provider
abstract class ReviewRepository {
  Future<bool> addReview(Review review, User currentUser);
  Future<List<Review>> getReviewsByUser(User user);
}

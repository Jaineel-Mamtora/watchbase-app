import 'package:fpdart/fpdart.dart';
import 'package:watchbase_app/core/utils/failure.dart';

abstract class UseCase<MoviesList, Params> {
  // Returns either a Failure (Left) or the expected Data Type (Right)
  Future<Either<Failure, MoviesList>> call(Params params);
}

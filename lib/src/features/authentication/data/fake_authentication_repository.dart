import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The `AuthRepository` class defines a set of methods for managing user authentication, including
/// signing in, creating a new user, signing out, and getting the current user.
abstract class AuthenticationRepository {
  /// The `Stream<AppUser?> authStateChanges();` method is defining a stream that emits changes in the
  /// authentication state of the app user. It returns a `Stream` object that emits `AppUser` objects or
  /// `null` values. This stream can be used to listen for changes in the authentication state, such as
  /// when a user signs in or signs out.
  Stream<AppUser?> authStateChanges();

  /// The `AppUser? get currentUser;` is a getter method that returns the current authenticated user. It
  /// is defined in the `AuthRepository` abstract class.
  AppUser? get currentUser;

  /// The `signInWithEmailAndPassword` method is a function defined in the `AuthRepository` abstract
  /// class. It takes in an email and password as parameters and returns a `Future<void>`.
  Future<void> signInWithEmailAndPassword(String email, String password);

  /// The `createUserWithEmailAndPassword` method is a function defined in the `AuthRepository` abstract
  /// class. It takes in an email and password as parameters and returns a `Future<void>`.
  Future<void> createUserWithEmailAndPassword(String email, String password);

  /// The `Future<void> signOut();` method is a function defined in the `AuthRepository` abstract class.
  /// It is responsible for signing out the currently authenticated user. When called, it will
  /// invalidate the authenticated user session, effectively logging the user out of the app. The
  /// implementation of this method will vary depending on the authentication mechanism being used
  /// (e.g., Firebase, custom authentication).
  Future<void> signOut();
}

class FakeAuthenticationRepository implements AuthenticationRepository {
  /// The function returns a stream that emits changes in the authentication state of the app user.
  @override
  Stream<AppUser?> authStateChanges() => Stream.value(null);
   
  /// The `AppUser? get currentUser => null;` is a getter method that returns the current authenticated
  /// user. In this case, it always returns `null`, indicating that there is no authenticated user
  /// currently.
  @override
  AppUser? get currentUser => null;
  
  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // TODO: Implement authentication using email and password credentials
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    // TODO: Implement logic for creating users with unique email and password
  }

  @override
  Future<void> signOut() async {
    // TODO: Invalidate the authenticated user session
  }
}

/// The `authRepositoryProvider` is a provider that creates and provides an instance of the
/// `FakeAuthenticationRepository` class. It is defined using the `Provider` class from the
/// `flutter_riverpod` package.
final authRepositoryProvider = Provider<FakeAuthenticationRepository>((ref) {
  return FakeAuthenticationRepository();
});

/// The `authStateChangesProvider` is a provider that creates and provides a stream of changes in the
/// authentication state of the app user.
 final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
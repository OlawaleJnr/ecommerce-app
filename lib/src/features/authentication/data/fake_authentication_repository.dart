import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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
  
  /// The line is creating an instance of the `InMemoryStore` class with the type parameter `AppUser?` 
  /// and initializing it with a value of `null`.
  final _authState = InMemoryStore<AppUser?>(null);

  /// The function `authStateChanges()` returns a stream of `AppUser` objects that represent changes in
  /// the authentication state.
  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;
   
  /// The `AppUser? get currentUser => _authState.value;` is a getter method that returns the current
  /// authenticated user. It retrieves the value of the `_authState` variable, which is an instance of
  /// `InMemoryStore<AppUser?>`, and returns it. The `AppUser?` type indicates that the returned value
  /// can be either an `AppUser` object or `null`.
  @override
  AppUser? get currentUser => _authState.value;
  
  /// The function checks if there is a current user and creates a new user if there isn't one.
  /// 
  /// Args: email (String): A string representing the user's email address.
  /// 
  /// Args: password (String): The password parameter is a string that represents the user's password.
  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser ==  null) {
      _createNewUser(email);
    }
  }

  /// The function checks if there is a current user and creates a new user if there isn't one.
  /// 
  /// Args: email (String): A string representing the user's email address.
  /// 
  /// Args: password (String): The password parameter is a string that represents the user's password.
  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    if (currentUser ==  null) {
      _createNewUser(email);
    }
  }

  /// The signOut function sets the value of _authState to null.
  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 5));
    throw Exception('Connection Failed');
    _authState.value = null;
  }

  /// The function creates a new user with a unique identifier and the provided email address.
  /// 
  /// Args: email (String): The email parameter is a string that represents the email address of the user.
  void _createNewUser(String email) {
    _authState.value = AppUser(uid: const Uuid().v4(), email: email);
  }

  /// The dispose function closes the _authState stream.
  void dispose() => _authState.close();
}

/// The `authRepositoryProvider` is a provider that creates and provides an instance of the
/// `FakeAuthenticationRepository` class. It uses the `Provider` class from the `flutter_riverpod`
/// package to define the provider.
final authRepositoryProvider = Provider<FakeAuthenticationRepository>((ref) {
  final auth = FakeAuthenticationRepository();
  debugPrint("Event: Created Fake Authentication Repository Provider");
  /// The line `ref.onDispose(() => auth.dispose());` is registering a callback function to be called
  /// when the provider is disposed. In this case, it is calling the `dispose()` method of the
  /// `FakeAuthenticationRepository` instance `auth`.
  ref.onDispose(() {
    auth.dispose();
    debugPrint("Event: Disposed Fake Authentication Repository Provider");
  });
  return auth;
});

/// The `authStateChangesProvider` is a provider that creates and provides a stream of changes in the
/// authentication state of the app user.
 final authStateChangesProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
import 'package:ecommerce_app/src/features/authentication/data/fake_authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The AccountScreenController class is a state notifier that manages the asynchronous value of void.
class AccountScreenContoller extends StateNotifier<AsyncValue<void>> { 
  
  /// The `AccountScreenContoller` class is extending the `StateNotifier` class from the `flutter_riverpod` package.
  AccountScreenContoller({required this.authRepository}) : super(const AsyncValue.data(null));
  
  /// This variable is used to store an instance of the `FakeAuthenticationRepository` class, which is
  /// likely a repository class responsible for handling authentication-related operations in the
  /// application.
  final FakeAuthenticationRepository authRepository;

  Future<void> signOut() async {
    try {
      /// This line is setting the state of the `AccountScreenController` to a loading state.
      state = const AsyncValue.loading();
      /// This line is responsible for signing the user out of the application or clearing any
      /// authentication-related data. The `await` keyword is used to wait for the `signOut()` method to
      /// complete before moving on to the next line of code.
      await authRepository.signOut();
      /// This line is setting the state of the `AccountScreenController` to a completed state with a
      /// value of `null`. This means that the asynchronous operation being managed by the
      /// `AccountScreenController` has completed successfully and there is no data to be returned or
      /// stored.
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<AccountScreenContoller, AsyncValue<void>>((ref) {
  /// This line is registering a callback function to be called when the `accountScreenControllerProvider`
  /// is disposed.
  ref.onDispose(() => debugPrint("Event: Disposed Account Screen Controller Provider"));
  /// This line is using the `ref.watch` method to retrieve the current value of the
  /// `authRepositoryProvider` from the provider container.
  final authRepository = ref.watch(authRepositoryProvider);
  /// This line is responsible for initializing the `AccountScreenContoller` with the appropriate
  /// dependencies, in this case, the `authRepository`.
  return AccountScreenContoller(authRepository: authRepository);
});
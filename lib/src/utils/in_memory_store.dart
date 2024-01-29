import 'package:rxdart/rxdart.dart';

/// The class `InMemoryStore` is a generic class that uses a `BehaviorSubject` to store and manage a value of type `T`.
class InMemoryStore<T> {
  /// The line `InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial)` is the constructor of the `InMemoryStore` class.
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  
  /// This line declares a private instance variable `_subject` of type `BehaviorSubject<T>`. 
  /// This variable is used to store and manage the value of type `T` in the `InMemoryStore` class.
  final BehaviorSubject<T> _subject;

  /// The line `Stream<T> get stream => _subject.stream;` is defining a getter method called `stream`
  /// that returns a `Stream<T>`.
  Stream<T> get stream => _subject.stream;

  /// The line `T get value => _subject.value;` is defining a getter method called `value` that returns
  /// the current value stored in the `_subject` BehaviorSubject. The type of the returned value is `T`,
  /// which is the generic type parameter of the `InMemoryStore` class. This allows you to easily access
  /// the current value of the store without having to subscribe to the stream.
  T get value => _subject.value;

  /// The line `set value(T value) => _subject.add(value);` is defining a setter method called `value`
  /// that takes a value of type `T` and adds it to the `_subject` BehaviorSubject.
  set value(T value) => _subject.add(value);

  /// The close() function closes the subject.
  void close() => _subject.close();
}
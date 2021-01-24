import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/all.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

final authStateChangesProvider = StreamProvider<User>((ref) => ref.watch(firebaseAuthProvider).authStateChanges());


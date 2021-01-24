import 'package:checkgasusage/models/user.dart';
import 'package:checkgasusage/providers/firestore_provider.dart';
import 'package:checkgasusage/providers/loading_state_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userStateProvider = Provider<UserState>((ref) {
  final UserState myUser = ref.watch(currentUserProvider.state);
  return myUser;
});

class UserState {
  final User currentUser;
  final String error;
  UserState({ this.currentUser, this.error});

  UserState copyWith({User currentUser, String error}) {
    return UserState(
        currentUser: currentUser ?? this.currentUser,
        error: error ?? this.error
    );
  }
}

final currentUserProvider = StateNotifierProvider<CurrentUserState>((ref) {
  return CurrentUserState(ref.read);
});

class CurrentUserState extends StateNotifier<UserState> {
  final Reader read;
  static UserState initialUserState = UserState();

  CurrentUserState(this.read) : super(initialUserState);
  Future<void> getUserData() async{
    state = state.copyWith(error:'',currentUser: User());
    User user = await read(firestoreProvider).fetchUserData();
    state = state.copyWith(error: '',currentUser: user);
  }







  Future<void> fetchUser(User myUser) async{
    try{
      read(nowLoadingStateProvider).onLoading("user");
      state = state.copyWith(currentUser: myUser, error: '');
      read(nowLoadingStateProvider).offLoading("user");
    }catch(e){
      state = state.copyWith(error: e.toString());
      read(nowLoadingStateProvider).offLoading("user");
    }
  }

  updatePhoneNumber(String phoneNumber) async{
    read(nowLoadingStateProvider).onLoading("user");
    Map<String, dynamic> updateData = {
      'phone': phoneNumber
    };
    await read(firestoreProvider).updateUser(updateData);
    read(nowLoadingStateProvider).offLoading("user");
  }

  updateUserInfo(String name, String email) async{
    read(nowLoadingStateProvider).onLoading("user");
    Map<String, dynamic> updateData = {'email': email,'name':name};
    await read(firestoreProvider).updateUser(updateData);
    read(nowLoadingStateProvider).offLoading("user");
  }

  updateUser(Map<String, dynamic> updateData) async{
    read(nowLoadingStateProvider).onLoading("user");
    await read(firestoreProvider).updateUser(updateData);
    read(nowLoadingStateProvider).offLoading("user");
  }

  changeIsEnoughToTrue() async{
    read(nowLoadingStateProvider).onLoading("user");
    Map<String, dynamic> updateData = {'isEnough': true,};
    await read(firestoreProvider).updateUser(updateData);
    read(nowLoadingStateProvider).offLoading("user");
  }


  void clear(){
    state = initialUserState;
  }

}
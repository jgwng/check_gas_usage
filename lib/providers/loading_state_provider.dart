import 'package:flutter_riverpod/all.dart';
final loadingStateProvider = Provider<LoadingState>((ref) {
  final LoadingState loadingState = ref.watch(nowLoadingStateProvider.state);
  return loadingState;
});

class LoadingState {
   final bool userLoading;
  LoadingState({this.userLoading : false});

  LoadingState copyWith({bool userLoading, bool machineLoading, bool petLoading, bool petReportLoading, bool timeLogLoading}) {
    return LoadingState(
        userLoading: userLoading??this.userLoading,
    );
  }

}

final nowLoadingStateProvider = StateNotifierProvider<NowLoadingState>(
        (ref) {return NowLoadingState(ref.read);}
);

class NowLoadingState extends StateNotifier<LoadingState>{
  final Reader read;
  static LoadingState initialLoadingState = LoadingState();

  NowLoadingState(this.read) : super(initialLoadingState);

  onLoading(String loading) {
    state = state.copyWith(userLoading: true);
  }

  offLoading(String loading){
    state = state.copyWith(userLoading: false);
  }

}
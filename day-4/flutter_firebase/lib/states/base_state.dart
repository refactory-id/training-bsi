abstract class ViewState {}

class Idle extends ViewState {}

class Loading extends ViewState {}

class Error extends ViewState {
  final String error;

  Error(this.error);
}

class Success extends ViewState {}

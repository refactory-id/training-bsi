abstract class ViewState {}

class Loading extends ViewState {}

class Error extends ViewState {
  final String error;

  Error(this.error);
}

abstract class Success extends ViewState {}

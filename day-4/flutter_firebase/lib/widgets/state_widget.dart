import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/states/base_state.dart';
import 'package:flutter_firebase/widgets/oops_widget.dart';

class StateWidget extends StatelessWidget {
  final ViewState state;
  final Widget success, idle;

  StateWidget({@required this.state, @required this.success, this.idle});

  @override
  Widget build(BuildContext context) {
    final viewState = state;

    if (viewState is Loading) {
      return Center(
          child: CircularProgressIndicator(
        strokeWidth: 2,
      ));
    } else if (viewState is Error) {
      return OopsWidget(
        message: viewState.error,
      );
    } else if (viewState is Success) {
      return success;
    } else {
      return idle ?? success;
    }
  }
}

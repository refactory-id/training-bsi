import 'package:flutter_clean_arch/domain/entities/courier_entity.dart';
import 'package:flutter_clean_arch/domain/usecases/calculate_cost_use_case.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeliveryCostPresenter extends Presenter {
  final CalculateCostUseCase _useCase;

  DeliveryCostPresenter(this._useCase);

  Function(List<Courier>) onSuccess;
  Function(dynamic e) onError;
  Function onComplete;

  void calculateCost(List<CalculateCostBody> params) {
    _useCase.execute(_DeliveryCostObserver(this), params);
  }

  @override
  void dispose() {
    _useCase.dispose();
  }
}

class _DeliveryCostObserver extends Observer<List<Courier>> {
  final DeliveryCostPresenter _presenter;

  _DeliveryCostObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.onComplete();
  }

  @override
  void onError(e) {
    _presenter.onError(e);
  }

  @override
  void onNext(List<Courier> response) {
    _presenter.onSuccess(response);
  }
}

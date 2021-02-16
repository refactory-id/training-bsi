import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery_cost/delivery_cost_bloc.dart';
import 'package:flutter_bloc_state_management/blocs/delivery_cost/delivery_cost_event.dart';
import 'package:flutter_bloc_state_management/blocs/delivery_cost/delivery_cost_state.dart';
import 'package:flutter_bloc_state_management/models/city_model.dart';
import 'package:flutter_bloc_state_management/models/raja_ongkir_model.dart';
import 'package:flutter_bloc_state_management/widgets/button_widget.dart';
import 'package:flutter_bloc_state_management/widgets/dropdown_item.dart';
import 'package:flutter_bloc_state_management/widgets/dropdown_widget.dart';
import 'package:flutter_bloc_state_management/widgets/exception_widget.dart';
import 'package:flutter_bloc_state_management/widgets/loading_widget.dart';

class DeliveryCostPage extends StatelessWidget {
  final int weight;
  final City origin, destination;

  const DeliveryCostPage({Key key, this.origin, this.destination, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context
        .read<DeliveryCostBloc>()
        .add(CalculateCostEvent(origin.id, destination.id, weight));

    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC in Shipping Charges"),
        centerTitle: true,
      ),
      body: BlocBuilder<DeliveryCostBloc, DeliveryCostState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return LoadingWidget();
          } else if (state is ErrorState) {
            return ExceptionWidget(message: state.message);
          } else if (state is SuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        "Alamat penerima: ${origin.type} ${origin.name}, ${origin.province}"),
                  ),
                  Icon(
                    Icons.swap_calls,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                        "Alamat pengirim: ${destination.type} ${destination.name}, ${destination.province}"),
                  ),
                  DropdownWidget<DeliveryCost>(
                    items: state.couriers
                        .map<DropdownMenuItemWidget<DeliveryCost>>(
                            (courier) => DropdownMenuItemWidget<DeliveryCost>(
                                  text: courier.code.toUpperCase(),
                                  value: courier,
                                  context: context,
                                ))
                        .toList(),
                    value: state.selectedCourier,
                    onChanged: (courier) => context
                        .read<DeliveryCostBloc>()
                        .add(SelectCourierEvent(courier)),
                  ),
                  state.services.isNotEmpty
                      ? DropdownWidget<Cost>(
                          items: state.services
                              .map<DropdownMenuItemWidget<Cost>>((item) {
                            final cost = item.cost.first;

                            return DropdownMenuItemWidget(
                                text:
                                    "${item.service}: IDR ${cost.value}, etd: ${cost.etd}",
                                value: item,
                                context: context);
                          }).toList(),
                          value: state.selectedService,
                          onChanged: (service) => context
                              .read<DeliveryCostBloc>()
                              .add(SelectServiceEvent(service)),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "Service tidak tersedia",
                            style:
                                TextStyle(fontSize: 14, color: Colors.red[900]),
                          ),
                        ),
                  if (state.services.isNotEmpty)
                    ButtonWidget(
                      text:
                          "CHECKOUT IDR ${state.selectedService.cost.first.value}",
                      onClick: () {},
                    ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}

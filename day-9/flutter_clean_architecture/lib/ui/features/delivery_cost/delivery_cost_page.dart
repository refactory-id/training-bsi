import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/entities/city_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/courier_entity.dart';
import 'package:flutter_clean_architecture/domain/entities/service_entity.dart';
import 'package:flutter_clean_architecture/ui/features/delivery_cost/delivery_cost_cubit.dart';
import 'package:flutter_clean_architecture/ui/features/delivery_cost/delivery_cost_state.dart';
import 'package:flutter_clean_architecture/ui/widgets/button_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/dropdown_item.dart';
import 'package:flutter_clean_architecture/ui/widgets/dropdown_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/exception_widget.dart';
import 'package:flutter_clean_architecture/ui/widgets/loading_widget.dart';

class DeliveryCostPage extends StatelessWidget {
  final int weight;
  final City origin, destination;

  const DeliveryCostPage({Key key, this.origin, this.destination, this.weight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 56);

    context
        .read<DeliveryCostCubit>()
        .calculateCost(origin.id, destination.id, weight);

    return Scaffold(
      appBar: AppBar(
        title: Text("BLoC in Shipping Charges"),
        centerTitle: true,
      ),
      body: BlocBuilder<DeliveryCostCubit, DeliveryCostState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return LoadingWidget();
          } else if (state is ErrorState) {
            return ExceptionWidget(message: state.message);
          } else if (state is SuccessState) {
            return Column(
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
                DropdownWidget<Courier>(
                  items: state.couriers
                      .map<DropdownMenuItemWidget<Courier>>(
                          (courier) => DropdownMenuItemWidget<Courier>(
                                text: courier.code.toUpperCase(),
                                value: courier,
                                width: width,
                              ))
                      .toList(),
                  value: state.selectedCourier,
                  onChanged: (courier) =>
                      context.read<DeliveryCostCubit>().selectCourier(courier),
                ),
                state.services.isNotEmpty
                    ? DropdownWidget<Service>(
                        items: state.services
                            .map<DropdownMenuItemWidget<Service>>((item) {
                          final cost = item.costs.first;

                          return DropdownMenuItemWidget(
                              text:
                                  "${item.service}: IDR ${cost.value}, etd: ${cost.etd}",
                              value: item,
                              width: width);
                        }).toList(),
                        value: state.selectedService,
                        onChanged: (service) => context
                            .read<DeliveryCostCubit>()
                            .selectService(service),
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
                        "CHECKOUT IDR ${state.selectedService.costs.first.value}",
                    onClick: () {},
                  ),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}

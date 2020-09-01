import 'package:flutter/material.dart';
import 'package:flutter_fiap_state_manager/fcm/firebaseNotifications.dart';
import 'package:flutter_fiap_state_manager/mobx/paymentController.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ListBills extends StatelessWidget {

  PaymentController paymentController;

  ListBills(){
    paymentController = PaymentController();
  }

  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications(context).setUpFirebase();

    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: Observer(
          builder: (_) {
            if (paymentController.payments.length == 0) {
              return Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "Nenhuma conta recebida neste momento...",
                    style: TextStyle(
                        fontSize: 25
                    ),
                  )
              );
            } else {
              return DataTable(
                columns: <DataColumn>[
                  getColumn('Tipo'),
                  getColumn('Local'),
                  getColumn('Valor'),
                ],
                rows: getRows(paymentController),
              );
            }
          }
      ),
      /*
      //o consumer é como um listener eterno no ciclo de vida da Widget, ]
      //que responde com o builder do Consumer a qualquer mudança no
      //ChangeNotifier associado
      body: Consumer<PaymentController>(
        builder: (context, controller, child) {
          return controller.items.length == 0 ? Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Nenhuma conta recebida neste momento...",
                style: TextStyle(
                    fontSize: 25
                ),
              )
          ): DataTable(
            columns: <DataColumn>[
              getColumn('Tipo'),
              getColumn('Local'),
              getColumn('Valor'),
            ],
            rows: getRows(controller),
          );
        },
      ),*/
    );
  }

  DataColumn getColumn(String label) => DataColumn(
    label: Text(
      label,
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  );

  List<DataRow> getRows(PaymentController controller) {
    List<DataRow> rows = List();

    /*
    //com provider
    controller.payments.forEach((element) {
      rows.add(
          DataRow(
            selected: element.selected,
            cells: <DataCell>[
              DataCell(Text(element.type)),
              DataCell(Text(element.place)),
              DataCell(Text("${element.value}")),
            ],
            onSelectChanged: (value) {
              element.selected = value;
              controller.update();
            },
          )
      );
    });*/

    //mobx
    for(var index = 0; index < controller.payments.length; index++) {
      rows.add(
          DataRow(
            selected: controller.payments[index].selected,
            cells: <DataCell>[
              DataCell(Text(controller.payments[index].type)),
              DataCell(Text(controller.payments[index].place)),
              DataCell(Text("${controller.payments[index].value}")),
            ],
            onSelectChanged: (value) {
              controller.payments[index].selected = value;
              controller.update(index, controller.payments[index]);
            },
          )
      );
    }

    return rows;
  }
}

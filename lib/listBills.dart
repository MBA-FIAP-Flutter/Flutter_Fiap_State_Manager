import 'package:flutter/material.dart';
import 'package:flutter_fiap_state_manager/provider/paymentProvider.dart';
import 'package:provider/provider.dart';

class ListBills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
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
      ),
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

    controller.items.forEach((element) {
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
    });

    return rows;
  }
}

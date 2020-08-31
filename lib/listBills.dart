import 'package:flutter/material.dart';

class ListBills extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contas a pagar"),
      ),
      body: 1 == 1 ? Container(
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
            rows: getRows(),
          ),
    );
  }

  DataColumn getColumn(String label) => DataColumn(
    label: Text(
      label,
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  );

  List<DataRow> getRows() {
    List<DataRow> rows = List();

    return rows;
  }
}

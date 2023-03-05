import 'package:datatable/user/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyDataTable());
  }
}

class MyDataTable extends StatefulWidget {
  const MyDataTable({super.key});

  @override
  State<MyDataTable> createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTable> {
  final dio = Dio();
  late List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('数据表格')),
      body: Center(
        child: FutureBuilder(
          future: getUserList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: $snapshot.error');
              } else {
                Response res = snapshot.data as Response;
                users = (res.data as List).map((e) => User.fromJson(e)).toList();
                return DataTable(
                  columns: const [
                    DataColumn(label: Text('id')),
                    DataColumn(label: Text('username')),
                    DataColumn(label: Text('age')),
                  ],
                  rows: users.map((item) {
                    return DataRow(cells: [
                      DataCell(Text('${item.id}')),
                      DataCell(Text('${item.username}')),
                      DataCell(Text('${item.age}'))
                    ]);
                  }).toList(),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Response> getUserList() async {
    return await dio.get('https://mock.jsont.run/rt9h2dLRu1455i-uE2fBJ');
  }
}

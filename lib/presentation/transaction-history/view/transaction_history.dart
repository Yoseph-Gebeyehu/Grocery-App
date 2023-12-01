import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/transaction_history_bloc.dart';

class TransactionHistoryPage extends StatefulWidget {
  static const txnHistory = 'trxn-history';

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionHistoryBloc>(context)
        .add(FetchTransactionHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: deviceSize.height * 0.08,
        backgroundColor: const Color(0xFFFFFFFF),
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.only(left: deviceSize.width * 0.1),
          child: const Text(
            'Transaction History',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocListener<TransactionHistoryBloc, TransactionHistoryState>(
        listener: (context, state) {
          if (state is FetchTransactionHistoryState) {
            BlocProvider.of<TransactionHistoryBloc>(context)
                .add(FetchTransactionHistoryEvent());
          }
        },
        child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
          builder: (context, state) {
            if (state is FetchTransactionHistoryState) {
              return RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<TransactionHistoryBloc>(context)
                      .add(FetchTransactionHistoryEvent());
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var txnHistory = state.trxnHistoryList[index].data;
                    DateTime date = DateTime.parse(txnHistory!.createdAt!);
                    String dateString =
                        DateFormat('yyyy-MMM-dd HH:mm').format(date);
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFE67F1E),
                            child: Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          title: Text(
                            txnHistory.txRef.toString(),
                          ),
                          subtitle: Text(dateString),
                          trailing: Text(
                            txnHistory.amount.toString(),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          indent: deviceSize.width * 0.1,
                          endIndent: deviceSize.width * 0.1,
                        ),
                      ],
                    );
                  },
                  itemCount: state.trxnHistoryList.length,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

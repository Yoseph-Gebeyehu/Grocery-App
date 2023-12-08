import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/no_internet.dart';
import '../../transaction-detail/transaction_detail.dart';
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
        .add(TransactionHistoryInitialEvent());
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
        listener: (context, state) {},
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
                    var txRef = state.trxnHistoryList[index];
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
                          title: GestureDetector(
                            onTap: () async {
                              BlocProvider.of<TransactionHistoryBloc>(context)
                                  .add(
                                FetchTransactionDetailEvent(txnRef: txRef),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const TransactionDetail(),
                                ),
                              );
                            },
                            child: Text(
                              txRef,
                              style: const TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue,
                              ),
                            ),
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
            } else if (state is TransactionHistoryInitialState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE67F1E),
                ),
              );
            } else if (state is NetworkErrorState) {
              return const NoConnectionPage();
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE67F1E),
              ),
            );
          },
        ),
      ),
    );
  }
}

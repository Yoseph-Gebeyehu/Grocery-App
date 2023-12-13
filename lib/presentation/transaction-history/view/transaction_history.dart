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

    return BlocListener<TransactionHistoryBloc, TransactionHistoryState>(
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
                      SizedBox(height: deviceSize.height * 0.01),
                      InkWell(
                        onTap: () async {
                          BlocProvider.of<TransactionHistoryBloc>(context).add(
                            FetchTransactionDetailEvent(txnRef: txRef),
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TransactionDetail(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceSize.width * 0.01),
                          child: Card(
                            child: ListTile(
                              leading: const Icon(
                                Icons.person,
                                color: Color(0xFFE67F1E),
                              ),
                              title: Text(
                                txRef,
                                style: const TextStyle(
                                  // decoration: TextDecoration.underline,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Divider(
                      //   thickness: 1,
                      //   indent: deviceSize.width * 0.1,
                      //   endIndent: deviceSize.width * 0.1,
                      // ),
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
    );
  }
}

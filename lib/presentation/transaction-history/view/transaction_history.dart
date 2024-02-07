import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/no_internet.dart';
import '../../transaction-detail/transaction_detail.dart';
import '../bloc/transaction_history_bloc.dart';

class TransactionHistoryPage extends StatefulWidget {
  static const txnHistory = 'trxn-history';

  const TransactionHistoryPage({super.key});

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
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: ListTile(
                              leading: Icon(
                                Icons.person,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                txRef,
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .color,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: state.trxnHistoryList.length,
              ),
            );
          } else if (state is TransactionHistoryInitialState) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else if (state is NetworkErrorState) {
            return const NoConnectionPage();
          }
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }
}

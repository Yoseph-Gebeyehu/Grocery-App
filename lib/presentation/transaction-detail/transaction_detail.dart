import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/transaction-history/bloc/transaction_history_bloc.dart';
import '../../presentation/transaction-detail/widget/txn_detail_api_error.dart';
import '../../widgets/no_internet.dart';

class TransactionDetail extends StatefulWidget {
  const TransactionDetail({Key? key}) : super(key: key);

  @override
  State<TransactionDetail> createState() => _TransactionDetailState();
}

class _TransactionDetailState extends State<TransactionDetail> {
  @override
  void initState() {
    super.initState();
  }

  bool update = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<TransactionHistoryBloc>(context)
            .add(FetchTransactionHistoryEvent());
        Navigator.of(context).pop(update);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Transaction Detail',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<TransactionHistoryBloc>(context)
                  .add(FetchTransactionHistoryEvent());
              return Navigator.of(context).pop(update);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: BlocListener<TransactionHistoryBloc, TransactionHistoryState>(
          listener: (context, state) {},
          child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
            builder: (context, state) {
              Size deviceSize = MediaQuery.of(context).size;

              if (state is FetchTransactionDetailState) {
                var txnHistory = state.transactionHistory.data;
                DateTime gregorianDate = DateTime.parse(txnHistory!.createdAt!);
                EtDatetime ethiopianDate =
                    EtDatetime.fromMillisecondsSinceEpoch(
                  gregorianDate.millisecondsSinceEpoch,
                );
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: deviceSize.width * 0.05,
                    vertical: deviceSize.height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      columWidgets(
                          'Transaction Time', ethiopianDate.toString()),
                      columWidgets('Transaction Reference', txnHistory.txRef!),
                      columWidgets('Transaction Amount',
                          '${txnHistory.amount.toString()} (${txnHistory.currency})'),
                      columWidgets('Transaction Type', txnHistory.type!),
                      columWidgets('Transaction Method', txnHistory.method!),
                      columWidgets('Transaction Title',
                          txnHistory.customization!.title!),
                      columWidgets('Transaction Description',
                          txnHistory.customization!.description!)
                    ],
                  ),
                );
              } else if (state is NetworkErrorState) {
                return const NoConnectionPage();
              } else if (state is ApiErrorSatate) {
                return const TxnDetailApiErrorWidget();
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFE67F1E),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  columWidgets(String title, String subTitle) {
    Size deviceSize = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: deviceSize.width * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: deviceSize.height * 0.01),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: deviceSize.width * 0.035,
            color: const Color(0xFFE67F1E),
          ),
        ),
        SizedBox(height: deviceSize.height * 0.01),
        const Divider(thickness: 1),
        SizedBox(height: deviceSize.height * 0.01),
      ],
    );
  }
}

import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:grocery/widgets/snack_bar.dart';

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
        // backgroundColor: Color.fromARGB(255, 238, 232, 232),
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            AppLocalizations.of(context)!.transaction_detail,
            style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
            ),
          ),
          leading: IconButton(
            onPressed: () {
              BlocProvider.of<TransactionHistoryBloc>(context)
                  .add(FetchTransactionHistoryEvent());
              return Navigator.of(context).pop(update);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          'T-shirt',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleLarge!.color,
                            fontSize: deviceSize.width * 0.05,
                          ),
                        ),
                      ),
                      // SizedBox(height: deviceSize.height * 0.01),
                      Center(
                        child: Text(
                          '${txnHistory.amount.toString()} (${txnHistory.currency})',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleLarge!.color,
                            fontSize: deviceSize.width * 0.1,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          ethiopianDate.toString(),
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.titleLarge!.color,
                            fontSize: deviceSize.width * 0.05,
                          ),
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.03),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceSize.width * 0.05,
                        ),
                        height: deviceSize.height * 0.22,
                        // width: deviceSize.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: const Color(0xFF2C2C2C),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: deviceSize.height * 0.02),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text(
                                  AppLocalizations.of(context)!
                                      .transaction_type,
                                  context,
                                  deviceSize,
                                ),
                                const Spacer(),
                                text(txnHistory.type!, context, deviceSize),
                              ],
                            ),
                            SizedBox(height: deviceSize.height * 0.01),
                            divider(deviceSize),
                            SizedBox(height: deviceSize.height * 0.01),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text(
                                  AppLocalizations.of(context)!
                                      .transaction_method,
                                  context,
                                  deviceSize,
                                ),
                                const Spacer(),
                                text(txnHistory.method!, context, deviceSize),
                              ],
                            ),
                            SizedBox(height: deviceSize.height * 0.01),
                            divider(deviceSize),
                            SizedBox(height: deviceSize.height * 0.01),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                text('Txn Ref', context, deviceSize),
                                const Spacer(),
                                text(txnHistory.txRef!, context, deviceSize),
                              ],
                            ),
                            SizedBox(height: deviceSize.height * 0.01),
                            divider(deviceSize),
                            SizedBox(height: deviceSize.height * 0.01),
                          ],
                        ),
                      ),
                      SizedBox(height: deviceSize.height * 0.03),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: deviceSize.width * 0.05,
                        ),
                        height: deviceSize.height * 0.28,
                        // width: deviceSize.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: const Color(0xFF2C2C2C),
                          // color: const Color(0xFFEEEEEE)
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: deviceSize.height * 0.02),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text(
                                  AppLocalizations.of(context)!
                                      .transaction_title,
                                  context,
                                  deviceSize,
                                ),
                                const Spacer(),
                                text(
                                  txnHistory.customization!.title!,
                                  context,
                                  deviceSize,
                                ),
                              ],
                            ),
                            SizedBox(height: deviceSize.height * 0.01),
                            divider(deviceSize),
                            SizedBox(height: deviceSize.height * 0.01),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text(
                                  AppLocalizations.of(context)!
                                      .transaction_description,
                                  context,
                                  deviceSize,
                                ),
                                const Spacer(),
                                text(
                                  txnHistory.customization!.description!,
                                  context,
                                  deviceSize,
                                ),
                              ],
                            ),
                            SizedBox(height: deviceSize.height * 0.01),
                            divider(deviceSize),
                            SizedBox(height: deviceSize.height * 0.01),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                text('Download Receipt', context, deviceSize),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    SnackBarWidget()
                                        .showSnack(context, 'Downloaded');
                                  },
                                  icon: Icon(
                                    Icons.download,
                                    color: Theme.of(context).iconTheme.color,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: deviceSize.height * 0.01),
                            divider(deviceSize),
                            SizedBox(height: deviceSize.height * 0.01),
                          ],
                        ),
                      ),

                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_time,
                      //     ethiopianDate.toString()),
                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_reference,
                      //     txnHistory.txRef!),
                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_amount,
                      //     '${txnHistory.amount.toString()} (${txnHistory.currency})'),
                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_type,
                      //     txnHistory.type!),
                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_method,
                      //     txnHistory.method!),
                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_title,
                      //     txnHistory.customization!.title!),
                      // columWidgets(
                      //     AppLocalizations.of(context)!.transaction_description,
                      //     txnHistory.customization!.description!)
                    ],
                  ),
                );
              } else if (state is NetworkErrorState) {
                return const NoConnectionPage();
              } else if (state is ApiErrorSatate) {
                return const TxnDetailApiErrorWidget();
              }
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  divider(Size deviceSize) {
    return const Divider(
      color: Color(0xFF4D4D4D),
      // endIndent: deviceSize.width * 0.05,
      // indent: deviceSize.width * 0.05,
    );
  }

  text(String text, BuildContext context, Size deviceSize) {
    return SelectableText(
      text,
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color,
        fontSize: deviceSize.width * 0.036,
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
            color: Theme.of(context).textTheme.titleLarge!.color,
          ),
        ),
        SizedBox(height: deviceSize.height * 0.01),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: deviceSize.width * 0.035,
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(height: deviceSize.height * 0.01),
        Divider(
          thickness: 1,
          color: Theme.of(context).dividerColor,
        ),
        SizedBox(height: deviceSize.height * 0.01),
      ],
    );
  }
}

import 'package:abushakir/abushakir.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;

import '/data/models/transaction_history.dart';
import '/widgets/snack_bar.dart';
import '/presentation/transaction-history/bloc/transaction_history_bloc.dart';
import '/presentation/transaction-detail/widget/txn_detail_api_error.dart';
import '/widgets/no_internet.dart';

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
    return PopScope(
      onPopInvoked: (bool didPop) async {
        BlocProvider.of<TransactionHistoryBloc>(context)
            .add(FetchTransactionHistoryEvent());
        Navigator.of(context).pop(update);
        if (didPop) {
          return;
        }
      },
      child: Scaffold(
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
                var txnHist = state.transactionHistory;
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: deviceSize.height * 0.02),
                            Row(
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
                        height: deviceSize.height * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).cardColor,
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: deviceSize.height * 0.02),
                            Row(
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
                              children: [
                                text('Download Receipt', context, deviceSize),
                                const Spacer(),
                                InkWell(
                                  onTap: () {
                                    SnackBarWidget()
                                        .showSnack(context, 'Downloaded');
                                    printDoc(txnHist);
                                  },
                                  child: Icon(
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
    return Divider(
      color: Theme.of(context).dividerTheme.color,
    );
  }

  text(String text, BuildContext context, Size deviceSize) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).textTheme.titleLarge!.color,
        fontSize: deviceSize.width * 0.036,
      ),
    );
  }

  Future<void> printDoc(TransactionHistory txnHistory) async {
    final image = await imageFromAssetBundle("assets/images/broccoli.png");
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image, txnHistory);
        }));
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  buildPrintableData(image, TransactionHistory txnHistory) {
    Size deviceSize = MediaQuery.of(context).size;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Center(
          child: pw.Text(
            'T-shirt',
            style: pw.TextStyle(
              fontSize: deviceSize.width * 0.05,
            ),
          ),
        ),
        pw.Center(
          child: pw.Text(
            '${txnHistory.data!.amount.toString()} (${txnHistory.data!.currency})',
            style: pw.TextStyle(
              fontSize: deviceSize.width * 0.1,
            ),
          ),
        ),
        pw.SizedBox(height: deviceSize.height * 0.03),
        pw.Container(
          padding: pw.EdgeInsets.symmetric(
            horizontal: deviceSize.width * 0.05,
          ),
          height: deviceSize.height * 0.22,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(20),
          ),
          child: pw.Column(
            children: [
              pw.SizedBox(height: deviceSize.height * 0.02),
              pw.Row(
                children: [
                  pw.Text(
                    AppLocalizations.of(context)!.transaction_type,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    txnHistory.data!.type!,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Divider(),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Row(
                children: [
                  pw.Text(
                    AppLocalizations.of(context)!.transaction_method,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    txnHistory.data!.method!,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Divider(),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Row(
                children: [
                  pw.Text(
                    'Txn Ref',
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    txnHistory.data!.txRef!,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Divider(),
              pw.SizedBox(height: deviceSize.height * 0.00),
            ],
          ),
        ),
        pw.SizedBox(height: deviceSize.height * 0.0),
        pw.Container(
          padding: pw.EdgeInsets.symmetric(
            horizontal: deviceSize.width * 0.05,
          ),
          height: deviceSize.height * 0.25,
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(20),
          ),
          child: pw.Column(
            children: [
              pw.SizedBox(height: deviceSize.height * 0.02),
              pw.Row(
                children: [
                  pw.Text(
                    AppLocalizations.of(context)!.transaction_title,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    txnHistory.data!.customization!.title!,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Divider(),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Row(
                children: [
                  pw.Text(
                    AppLocalizations.of(context)!.transaction_description,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                  pw.Spacer(),
                  pw.Text(
                    txnHistory.data!.customization!.description!,
                    style: pw.TextStyle(
                      fontSize: deviceSize.width * 0.036,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Divider(),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Divider(),
              pw.SizedBox(height: deviceSize.height * 0.01),
              pw.Center(
                child: pw.Image(
                  image,
                  width: 240,
                  height: 300,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

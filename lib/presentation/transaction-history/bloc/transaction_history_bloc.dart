import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/remote-request/repository.dart';
import '../../../data/models/transaction_history.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc() : super(const TransactionHistoryState()) {
    List<String> txRef = [];
    Future<void> loadTxRef() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      txRef = prefs.getStringList('txns') ?? [];
    }

    on<TransactionHistoryInitialEvent>((event, emit) async {
      emit(TransactionHistoryInitialState());
    });

    on<FetchTransactionHistoryEvent>((event, emit) async {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none && Platform.isAndroid) {
        emit(NetworkErrorState());
        return;
      }
      await loadTxRef();

      emit(FetchTransactionHistoryState(trxnHistoryList: txRef));
    });

    on<FetchTransactionDetailEvent>((event, emit) async {
      Repository repository = Repository();
      var response = await repository.getVerify(event.txnRef);
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (response.status == 200) {
        TransactionHistory transactionHistory =
            TransactionHistory.fromJson(response.body);

        emit(FetchTransactionDetailState(
            transactionHistory: transactionHistory));
      } else if (connectivityResult == ConnectivityResult.none &&
          Platform.isAndroid) {
        emit(NetworkErrorState());
        return;
      } else {
        emit(ApiErrorSatate());
      }
    });
  }
}

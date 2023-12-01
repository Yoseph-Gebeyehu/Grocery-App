import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/remote-request/repository.dart';
import '../../../data/models/transaction_history.dart';

part 'transaction_history_event.dart';
part 'transaction_history_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionHistoryEvent, TransactionHistoryState> {
  TransactionHistoryBloc() : super(TransactionHistoryInitial()) {
    List<String> _txRef = [];
    Future<void> loadTxRef() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _txRef = prefs.getStringList('txns') ?? [];
    }

    on<FetchTransactionHistoryEvent>((event, emit) async {
      await loadTxRef();

      Repository repository = Repository();
      List<TransactionHistory> txnHistoryList = [];
      for (int i = 0; i < _txRef.length; i++) {
        var response = await repository.getVerify(_txRef[i]);

        TransactionHistory transactionHistory =
            TransactionHistory.fromJson(response.body);
        txnHistoryList.add(transactionHistory);
        print(txnHistoryList.length);
      }

      emit(FetchTransactionHistoryState(trxnHistoryList: txnHistoryList));
    });
  }
}

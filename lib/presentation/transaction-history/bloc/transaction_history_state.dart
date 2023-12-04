part of 'transaction_history_bloc.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

class TransactionHistoryInitialState extends TransactionHistoryState {}

class FetchTransactionHistoryState extends TransactionHistoryState {
  List<String> trxnHistoryList;
  FetchTransactionHistoryState({required this.trxnHistoryList});
}

class FetchTransactionDetailState extends TransactionHistoryState {
  TransactionHistory transactionHistory;
  FetchTransactionDetailState({required this.transactionHistory});
}

class NetworkErrorState extends TransactionHistoryState {}

class ApiErrorSatate extends TransactionHistoryState {}

part of 'transaction_history_bloc.dart';

class TransactionHistoryState extends Equatable {
  const TransactionHistoryState();

  @override
  List<Object> get props => [];
}

class TransactionHistoryInitial extends TransactionHistoryState {}

class FetchTransactionHistoryState extends TransactionHistoryState {
  List<TransactionHistory> trxnHistoryList;
  FetchTransactionHistoryState({required this.trxnHistoryList});
}

part of 'transaction_history_bloc.dart';

class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

class TransactionHistoryInitialEvent extends TransactionHistoryEvent {}

class FetchTransactionHistoryEvent extends TransactionHistoryEvent {}

class FetchTransactionDetailEvent extends TransactionHistoryEvent {
  final String txnRef;
  const FetchTransactionDetailEvent({required this.txnRef});
}

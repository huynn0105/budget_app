// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analysis_bloc.dart';

abstract class AnalysisState extends Equatable {
  const AnalysisState();

  @override
  List<Object> get props => [];
}

class AnalysisInitial extends AnalysisState {
  const AnalysisInitial();
  @override
  List<Object> get props => [];
}

class AnalysisLoaded extends AnalysisState {
  final TransactionUIModel transactionOfWeek;
  final TransactionUIModel transactionOfMonth;
  final TransactionUIModel transactionOfYear;
  const AnalysisLoaded({
    this.viewType = ViewType.week,
    required this.transactionOfWeek,
    required this.transactionOfMonth,
    required this.transactionOfYear,
  });
  final ViewType viewType;
  @override
  List<Object> get props => [viewType, transactionOfWeek, transactionOfMonth];
  int get totalOfWeek => transactionOfWeek.transactions.fold(
      0,
      (prevValue, x) =>
          prevValue +
          (x.type == TransactionType.expense ? -x.amount : x.amount));
  int get totalOfMonth => transactionOfMonth.transactions.fold(
      0,
      (prevValue, x) =>
          prevValue +
          (x.type == TransactionType.expense ? -x.amount : x.amount));
  int get totalOfYear => transactionOfYear.transactions.fold(
      0,
      (prevValue, x) =>
          prevValue +
          (x.type == TransactionType.expense ? -x.amount : x.amount));

  Map<int, List<Transaction>> get transactionsDateOfViewType {
    switch (viewType) {
      case ViewType.week:
        return transactionOfWeek.transactions
            .groupListsBy<int>((x) => x.dateTime.weekday);
      case ViewType.month:
        return transactionOfMonth.transactions
            .groupListsBy<int>((x) => x.dateTime.weekNumber);
      case ViewType.year:
        return transactionOfYear.transactions
            .groupListsBy<int>((x) => x.dateTime.month);
    }
  }

  List<CategoryUIModel> get transactionOfCategory {
    Map<Category, List<Transaction>> transactionsOfCategory;
    switch (viewType) {
      case ViewType.week:
        transactionsOfCategory = transactionOfWeek.transactions
            .groupListsBy<Category>((x) => x.category.target!);
        break;
      case ViewType.month:
        transactionsOfCategory = transactionOfMonth.transactions
            .groupListsBy<Category>((x) => x.category.target!);
        break;
      case ViewType.year:
        transactionsOfCategory = transactionOfYear.transactions
            .groupListsBy<Category>((x) => x.category.target!);
        break;
    }
    List<CategoryUIModel> categoriesUI = [];
    for (var item in transactionsOfCategory.entries) {
      categoriesUI.add(
        CategoryUIModel(
          category: item.key,
          total: item.value.fold(
              0,
              (p, e) =>
                  p +
                  (e.type == TransactionType.expense ? -e.amount : e.amount)),
          transactions:
              item.value.groupListsBy<DateTime>((e) => e.dateTime.toDate()),
          lastUpdate: item.value.fold(item.value.first.dateTime,
              (p, e) => p.compareTo(e.dateTime) > 0 ? p : e.dateTime),
        ),
      );
    }
    categoriesUI.sort((a, b) => b.lastUpdate.compareTo(a.lastUpdate));
    return categoriesUI;
  }

  int get maxOfTransactions {
    int max = transactionsDateOfViewType.values.fold(0, (prevValue, e) {
      int totalAmountOfDate = e.fold(0, (prev, x) => prev + x.amount);
      return totalAmountOfDate > prevValue ? totalAmountOfDate : prevValue;
    });

    return max;
  }

  int getTotalOfDay(int value) {
    final transactions = transactionsDateOfViewType.entries
        .firstWhereOrNull((x) => x.key == value)
        ?.value;
    int total =
        transactions != null ? transactions.fold(0, (p, e) => p + e.amount) : 0;
    return total;
  }

  int get maxValueOfWeek => transactionOfWeek.transactions
      .fold(0, (prevValue, x) => x.amount > prevValue ? x.amount : prevValue);
  int get maxValueOfMonth => transactionOfMonth.transactions
      .fold(0, (prevValue, x) => x.amount > prevValue ? x.amount : prevValue);
  int get maxValueOfYear => transactionOfYear.transactions
      .fold(0, (prevValue, x) => x.amount > prevValue ? x.amount : prevValue);

  AnalysisLoaded copyWith({
    ViewType? viewType,
    TransactionUIModel? transactionOfMonth,
    TransactionUIModel? transactionOfWeek,
    TransactionUIModel? transactionOfYear,
  }) {
    return AnalysisLoaded(
      viewType: viewType ?? this.viewType,
      transactionOfMonth: transactionOfMonth ?? this.transactionOfMonth,
      transactionOfWeek: transactionOfWeek ?? this.transactionOfWeek,
      transactionOfYear: transactionOfYear ?? this.transactionOfYear,
    );
  }
}

const List<String> listWeek = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

const List<String> listYear = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec'
];

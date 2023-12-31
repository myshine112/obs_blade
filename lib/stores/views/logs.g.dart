// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logs.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LogsStore on _LogsStore, Store {
  late final _$logLevelAtom =
      Atom(name: '_LogsStore.logLevel', context: context);

  @override
  LogLevel? get logLevel {
    _$logLevelAtom.reportRead();
    return super.logLevel;
  }

  @override
  set logLevel(LogLevel? value) {
    _$logLevelAtom.reportWrite(value, super.logLevel, () {
      super.logLevel = value;
    });
  }

  late final _$fromDateAtom =
      Atom(name: '_LogsStore.fromDate', context: context);

  @override
  DateTime? get fromDate {
    _$fromDateAtom.reportRead();
    return super.fromDate;
  }

  @override
  set fromDate(DateTime? value) {
    _$fromDateAtom.reportWrite(value, super.fromDate, () {
      super.fromDate = value;
    });
  }

  late final _$toDateAtom = Atom(name: '_LogsStore.toDate', context: context);

  @override
  DateTime? get toDate {
    _$toDateAtom.reportRead();
    return super.toDate;
  }

  @override
  set toDate(DateTime? value) {
    _$toDateAtom.reportWrite(value, super.toDate, () {
      super.toDate = value;
    });
  }

  late final _$amountLogEntriesAtom =
      Atom(name: '_LogsStore.amountLogEntries', context: context);

  @override
  AmountLogEntries? get amountLogEntries {
    _$amountLogEntriesAtom.reportRead();
    return super.amountLogEntries;
  }

  @override
  set amountLogEntries(AmountLogEntries? value) {
    _$amountLogEntriesAtom.reportWrite(value, super.amountLogEntries, () {
      super.amountLogEntries = value;
    });
  }

  late final _$filterOrderAtom =
      Atom(name: '_LogsStore.filterOrder', context: context);

  @override
  Order get filterOrder {
    _$filterOrderAtom.reportRead();
    return super.filterOrder;
  }

  @override
  set filterOrder(Order value) {
    _$filterOrderAtom.reportWrite(value, super.filterOrder, () {
      super.filterOrder = value;
    });
  }

  late final _$_LogsStoreActionController =
      ActionController(name: '_LogsStore', context: context);

  @override
  void setLogLevel(LogLevel? logLevel) {
    final _$actionInfo = _$_LogsStoreActionController.startAction(
        name: '_LogsStore.setLogLevel');
    try {
      return super.setLogLevel(logLevel);
    } finally {
      _$_LogsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFromDate(DateTime? fromDate) {
    final _$actionInfo = _$_LogsStoreActionController.startAction(
        name: '_LogsStore.setFromDate');
    try {
      return super.setFromDate(fromDate);
    } finally {
      _$_LogsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setToDate(DateTime? toDate) {
    final _$actionInfo =
        _$_LogsStoreActionController.startAction(name: '_LogsStore.setToDate');
    try {
      return super.setToDate(toDate);
    } finally {
      _$_LogsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAmountLogEntries(AmountLogEntries? amountLogEntries) {
    final _$actionInfo = _$_LogsStoreActionController.startAction(
        name: '_LogsStore.setAmountLogEntries');
    try {
      return super.setAmountLogEntries(amountLogEntries);
    } finally {
      _$_LogsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFilterOrder() {
    final _$actionInfo = _$_LogsStoreActionController.startAction(
        name: '_LogsStore.toggleFilterOrder');
    try {
      return super.toggleFilterOrder();
    } finally {
      _$_LogsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
logLevel: ${logLevel},
fromDate: ${fromDate},
toDate: ${toDate},
amountLogEntries: ${amountLogEntries},
filterOrder: ${filterOrder}
    ''';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LedgerTable extends Ledger with TableInfo<$LedgerTable, LedgerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LedgerTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _creditMeta = const VerificationMeta('credit');
  @override
  late final GeneratedColumn<double> credit = GeneratedColumn<double>(
    'credit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _debitMeta = const VerificationMeta('debit');
  @override
  late final GeneratedColumn<double> debit = GeneratedColumn<double>(
    'debit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _balanceMeta = const VerificationMeta(
    'balance',
  );
  @override
  late final GeneratedColumn<double> balance = GeneratedColumn<double>(
    'balance',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receivedFromMeta = const VerificationMeta(
    'receivedFrom',
  );
  @override
  late final GeneratedColumn<String> receivedFrom = GeneratedColumn<String>(
    'received_from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _givenToMeta = const VerificationMeta(
    'givenTo',
  );
  @override
  late final GeneratedColumn<String> givenTo = GeneratedColumn<String>(
    'given_to',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: Constant(DateTime.now()),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    credit,
    debit,
    balance,
    category,
    notes,
    receivedFrom,
    givenTo,
    paymentMethod,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ledger';
  @override
  VerificationContext validateIntegrity(
    Insertable<LedgerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('credit')) {
      context.handle(
        _creditMeta,
        credit.isAcceptableOrUnknown(data['credit']!, _creditMeta),
      );
    }
    if (data.containsKey('debit')) {
      context.handle(
        _debitMeta,
        debit.isAcceptableOrUnknown(data['debit']!, _debitMeta),
      );
    }
    if (data.containsKey('balance')) {
      context.handle(
        _balanceMeta,
        balance.isAcceptableOrUnknown(data['balance']!, _balanceMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('received_from')) {
      context.handle(
        _receivedFromMeta,
        receivedFrom.isAcceptableOrUnknown(
          data['received_from']!,
          _receivedFromMeta,
        ),
      );
    }
    if (data.containsKey('given_to')) {
      context.handle(
        _givenToMeta,
        givenTo.isAcceptableOrUnknown(data['given_to']!, _givenToMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LedgerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LedgerData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      credit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}credit'],
          )!,
      debit:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}debit'],
          )!,
      balance:
          attachedDatabase.typeMapping.read(
            DriftSqlType.double,
            data['${effectivePrefix}balance'],
          )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      receivedFrom:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}received_from'],
          )!,
      givenTo:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}given_to'],
          )!,
      paymentMethod:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}payment_method'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $LedgerTable createAlias(String alias) {
    return $LedgerTable(attachedDatabase, alias);
  }
}

class LedgerData extends DataClass implements Insertable<LedgerData> {
  final int id;
  final double credit;
  final double debit;
  final double balance;
  final String? category;
  final String? notes;
  final String receivedFrom;
  final String givenTo;
  final String paymentMethod;
  final DateTime createdAt;
  const LedgerData({
    required this.id,
    required this.credit,
    required this.debit,
    required this.balance,
    this.category,
    this.notes,
    required this.receivedFrom,
    required this.givenTo,
    required this.paymentMethod,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['credit'] = Variable<double>(credit);
    map['debit'] = Variable<double>(debit);
    map['balance'] = Variable<double>(balance);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['received_from'] = Variable<String>(receivedFrom);
    map['given_to'] = Variable<String>(givenTo);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LedgerCompanion toCompanion(bool nullToAbsent) {
    return LedgerCompanion(
      id: Value(id),
      credit: Value(credit),
      debit: Value(debit),
      balance: Value(balance),
      category:
          category == null && nullToAbsent
              ? const Value.absent()
              : Value(category),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      receivedFrom: Value(receivedFrom),
      givenTo: Value(givenTo),
      paymentMethod: Value(paymentMethod),
      createdAt: Value(createdAt),
    );
  }

  factory LedgerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LedgerData(
      id: serializer.fromJson<int>(json['id']),
      credit: serializer.fromJson<double>(json['credit']),
      debit: serializer.fromJson<double>(json['debit']),
      balance: serializer.fromJson<double>(json['balance']),
      category: serializer.fromJson<String?>(json['category']),
      notes: serializer.fromJson<String?>(json['notes']),
      receivedFrom: serializer.fromJson<String>(json['receivedFrom']),
      givenTo: serializer.fromJson<String>(json['givenTo']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'credit': serializer.toJson<double>(credit),
      'debit': serializer.toJson<double>(debit),
      'balance': serializer.toJson<double>(balance),
      'category': serializer.toJson<String?>(category),
      'notes': serializer.toJson<String?>(notes),
      'receivedFrom': serializer.toJson<String>(receivedFrom),
      'givenTo': serializer.toJson<String>(givenTo),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LedgerData copyWith({
    int? id,
    double? credit,
    double? debit,
    double? balance,
    Value<String?> category = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? receivedFrom,
    String? givenTo,
    String? paymentMethod,
    DateTime? createdAt,
  }) => LedgerData(
    id: id ?? this.id,
    credit: credit ?? this.credit,
    debit: debit ?? this.debit,
    balance: balance ?? this.balance,
    category: category.present ? category.value : this.category,
    notes: notes.present ? notes.value : this.notes,
    receivedFrom: receivedFrom ?? this.receivedFrom,
    givenTo: givenTo ?? this.givenTo,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    createdAt: createdAt ?? this.createdAt,
  );
  LedgerData copyWithCompanion(LedgerCompanion data) {
    return LedgerData(
      id: data.id.present ? data.id.value : this.id,
      credit: data.credit.present ? data.credit.value : this.credit,
      debit: data.debit.present ? data.debit.value : this.debit,
      balance: data.balance.present ? data.balance.value : this.balance,
      category: data.category.present ? data.category.value : this.category,
      notes: data.notes.present ? data.notes.value : this.notes,
      receivedFrom:
          data.receivedFrom.present
              ? data.receivedFrom.value
              : this.receivedFrom,
      givenTo: data.givenTo.present ? data.givenTo.value : this.givenTo,
      paymentMethod:
          data.paymentMethod.present
              ? data.paymentMethod.value
              : this.paymentMethod,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LedgerData(')
          ..write('id: $id, ')
          ..write('credit: $credit, ')
          ..write('debit: $debit, ')
          ..write('balance: $balance, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('receivedFrom: $receivedFrom, ')
          ..write('givenTo: $givenTo, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    credit,
    debit,
    balance,
    category,
    notes,
    receivedFrom,
    givenTo,
    paymentMethod,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LedgerData &&
          other.id == this.id &&
          other.credit == this.credit &&
          other.debit == this.debit &&
          other.balance == this.balance &&
          other.category == this.category &&
          other.notes == this.notes &&
          other.receivedFrom == this.receivedFrom &&
          other.givenTo == this.givenTo &&
          other.paymentMethod == this.paymentMethod &&
          other.createdAt == this.createdAt);
}

class LedgerCompanion extends UpdateCompanion<LedgerData> {
  final Value<int> id;
  final Value<double> credit;
  final Value<double> debit;
  final Value<double> balance;
  final Value<String?> category;
  final Value<String?> notes;
  final Value<String> receivedFrom;
  final Value<String> givenTo;
  final Value<String> paymentMethod;
  final Value<DateTime> createdAt;
  const LedgerCompanion({
    this.id = const Value.absent(),
    this.credit = const Value.absent(),
    this.debit = const Value.absent(),
    this.balance = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.receivedFrom = const Value.absent(),
    this.givenTo = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  LedgerCompanion.insert({
    this.id = const Value.absent(),
    this.credit = const Value.absent(),
    this.debit = const Value.absent(),
    this.balance = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.receivedFrom = const Value.absent(),
    this.givenTo = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<LedgerData> custom({
    Expression<int>? id,
    Expression<double>? credit,
    Expression<double>? debit,
    Expression<double>? balance,
    Expression<String>? category,
    Expression<String>? notes,
    Expression<String>? receivedFrom,
    Expression<String>? givenTo,
    Expression<String>? paymentMethod,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (credit != null) 'credit': credit,
      if (debit != null) 'debit': debit,
      if (balance != null) 'balance': balance,
      if (category != null) 'category': category,
      if (notes != null) 'notes': notes,
      if (receivedFrom != null) 'received_from': receivedFrom,
      if (givenTo != null) 'given_to': givenTo,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  LedgerCompanion copyWith({
    Value<int>? id,
    Value<double>? credit,
    Value<double>? debit,
    Value<double>? balance,
    Value<String?>? category,
    Value<String?>? notes,
    Value<String>? receivedFrom,
    Value<String>? givenTo,
    Value<String>? paymentMethod,
    Value<DateTime>? createdAt,
  }) {
    return LedgerCompanion(
      id: id ?? this.id,
      credit: credit ?? this.credit,
      debit: debit ?? this.debit,
      balance: balance ?? this.balance,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      receivedFrom: receivedFrom ?? this.receivedFrom,
      givenTo: givenTo ?? this.givenTo,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (credit.present) {
      map['credit'] = Variable<double>(credit.value);
    }
    if (debit.present) {
      map['debit'] = Variable<double>(debit.value);
    }
    if (balance.present) {
      map['balance'] = Variable<double>(balance.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (receivedFrom.present) {
      map['received_from'] = Variable<String>(receivedFrom.value);
    }
    if (givenTo.present) {
      map['given_to'] = Variable<String>(givenTo.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LedgerCompanion(')
          ..write('id: $id, ')
          ..write('credit: $credit, ')
          ..write('debit: $debit, ')
          ..write('balance: $balance, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('receivedFrom: $receivedFrom, ')
          ..write('givenTo: $givenTo, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<Category> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      category:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}category'],
          )!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final String category;
  const Category({required this.category});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['category'] = Variable<String>(category);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(category: Value(category));
  }

  factory Category.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(category: serializer.fromJson<String>(json['category']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'category': serializer.toJson<String>(category)};
  }

  Category copyWith({String? category}) =>
      Category(category: category ?? this.category);
  Category copyWithCompanion(CategoriesCompanion data) {
    return Category(
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => category.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category && other.category == this.category);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<String> category;
  final Value<int> rowid;
  const CategoriesCompanion({
    this.category = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriesCompanion.insert({
    required String category,
    this.rowid = const Value.absent(),
  }) : category = Value(category);
  static Insertable<Category> custom({
    Expression<String>? category,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (category != null) 'category': category,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriesCompanion copyWith({Value<String>? category, Value<int>? rowid}) {
    return CategoriesCompanion(
      category: category ?? this.category,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('category: $category, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  $DatabaseManager get managers => $DatabaseManager(this);
  late final $LedgerTable ledger = $LedgerTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [ledger, categories];
}

typedef $$LedgerTableCreateCompanionBuilder =
    LedgerCompanion Function({
      Value<int> id,
      Value<double> credit,
      Value<double> debit,
      Value<double> balance,
      Value<String?> category,
      Value<String?> notes,
      Value<String> receivedFrom,
      Value<String> givenTo,
      Value<String> paymentMethod,
      Value<DateTime> createdAt,
    });
typedef $$LedgerTableUpdateCompanionBuilder =
    LedgerCompanion Function({
      Value<int> id,
      Value<double> credit,
      Value<double> debit,
      Value<double> balance,
      Value<String?> category,
      Value<String?> notes,
      Value<String> receivedFrom,
      Value<String> givenTo,
      Value<String> paymentMethod,
      Value<DateTime> createdAt,
    });

class $$LedgerTableFilterComposer extends Composer<_$Database, $LedgerTable> {
  $$LedgerTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get credit => $composableBuilder(
    column: $table.credit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get debit => $composableBuilder(
    column: $table.debit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receivedFrom => $composableBuilder(
    column: $table.receivedFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get givenTo => $composableBuilder(
    column: $table.givenTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LedgerTableOrderingComposer extends Composer<_$Database, $LedgerTable> {
  $$LedgerTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get credit => $composableBuilder(
    column: $table.credit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get debit => $composableBuilder(
    column: $table.debit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get balance => $composableBuilder(
    column: $table.balance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receivedFrom => $composableBuilder(
    column: $table.receivedFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get givenTo => $composableBuilder(
    column: $table.givenTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LedgerTableAnnotationComposer
    extends Composer<_$Database, $LedgerTable> {
  $$LedgerTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get credit =>
      $composableBuilder(column: $table.credit, builder: (column) => column);

  GeneratedColumn<double> get debit =>
      $composableBuilder(column: $table.debit, builder: (column) => column);

  GeneratedColumn<double> get balance =>
      $composableBuilder(column: $table.balance, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get receivedFrom => $composableBuilder(
    column: $table.receivedFrom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get givenTo =>
      $composableBuilder(column: $table.givenTo, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LedgerTableTableManager
    extends
        RootTableManager<
          _$Database,
          $LedgerTable,
          LedgerData,
          $$LedgerTableFilterComposer,
          $$LedgerTableOrderingComposer,
          $$LedgerTableAnnotationComposer,
          $$LedgerTableCreateCompanionBuilder,
          $$LedgerTableUpdateCompanionBuilder,
          (LedgerData, BaseReferences<_$Database, $LedgerTable, LedgerData>),
          LedgerData,
          PrefetchHooks Function()
        > {
  $$LedgerTableTableManager(_$Database db, $LedgerTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$LedgerTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$LedgerTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$LedgerTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> credit = const Value.absent(),
                Value<double> debit = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> receivedFrom = const Value.absent(),
                Value<String> givenTo = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LedgerCompanion(
                id: id,
                credit: credit,
                debit: debit,
                balance: balance,
                category: category,
                notes: notes,
                receivedFrom: receivedFrom,
                givenTo: givenTo,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> credit = const Value.absent(),
                Value<double> debit = const Value.absent(),
                Value<double> balance = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> receivedFrom = const Value.absent(),
                Value<String> givenTo = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => LedgerCompanion.insert(
                id: id,
                credit: credit,
                debit: debit,
                balance: balance,
                category: category,
                notes: notes,
                receivedFrom: receivedFrom,
                givenTo: givenTo,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LedgerTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $LedgerTable,
      LedgerData,
      $$LedgerTableFilterComposer,
      $$LedgerTableOrderingComposer,
      $$LedgerTableAnnotationComposer,
      $$LedgerTableCreateCompanionBuilder,
      $$LedgerTableUpdateCompanionBuilder,
      (LedgerData, BaseReferences<_$Database, $LedgerTable, LedgerData>),
      LedgerData,
      PrefetchHooks Function()
    >;
typedef $$CategoriesTableCreateCompanionBuilder =
    CategoriesCompanion Function({required String category, Value<int> rowid});
typedef $$CategoriesTableUpdateCompanionBuilder =
    CategoriesCompanion Function({Value<String> category, Value<int> rowid});

class $$CategoriesTableFilterComposer
    extends Composer<_$Database, $CategoriesTable> {
  $$CategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoriesTableOrderingComposer
    extends Composer<_$Database, $CategoriesTable> {
  $$CategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriesTableAnnotationComposer
    extends Composer<_$Database, $CategoriesTable> {
  $$CategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);
}

class $$CategoriesTableTableManager
    extends
        RootTableManager<
          _$Database,
          $CategoriesTable,
          Category,
          $$CategoriesTableFilterComposer,
          $$CategoriesTableOrderingComposer,
          $$CategoriesTableAnnotationComposer,
          $$CategoriesTableCreateCompanionBuilder,
          $$CategoriesTableUpdateCompanionBuilder,
          (Category, BaseReferences<_$Database, $CategoriesTable, Category>),
          Category,
          PrefetchHooks Function()
        > {
  $$CategoriesTableTableManager(_$Database db, $CategoriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$CategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$CategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> category = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriesCompanion(category: category, rowid: rowid),
          createCompanionCallback:
              ({
                required String category,
                Value<int> rowid = const Value.absent(),
              }) =>
                  CategoriesCompanion.insert(category: category, rowid: rowid),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$Database,
      $CategoriesTable,
      Category,
      $$CategoriesTableFilterComposer,
      $$CategoriesTableOrderingComposer,
      $$CategoriesTableAnnotationComposer,
      $$CategoriesTableCreateCompanionBuilder,
      $$CategoriesTableUpdateCompanionBuilder,
      (Category, BaseReferences<_$Database, $CategoriesTable, Category>),
      Category,
      PrefetchHooks Function()
    >;

class $DatabaseManager {
  final _$Database _db;
  $DatabaseManager(this._db);
  $$LedgerTableTableManager get ledger =>
      $$LedgerTableTableManager(_db, _db.ledger);
  $$CategoriesTableTableManager get categories =>
      $$CategoriesTableTableManager(_db, _db.categories);
}

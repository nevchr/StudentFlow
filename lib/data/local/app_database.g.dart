// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LocalAccountsTable extends LocalAccounts
    with TableInfo<$LocalAccountsTable, LocalAccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _institutionNameMeta = const VerificationMeta(
    'institutionName',
  );
  @override
  late final GeneratedColumn<String> institutionName = GeneratedColumn<String>(
    'institution_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maskMeta = const VerificationMeta('mask');
  @override
  late final GeneratedColumn<String> mask = GeneratedColumn<String>(
    'mask',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountTypeMeta = const VerificationMeta(
    'accountType',
  );
  @override
  late final GeneratedColumn<int> accountType = GeneratedColumn<int>(
    'account_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentBalanceCentsMeta =
      const VerificationMeta('currentBalanceCents');
  @override
  late final GeneratedColumn<int> currentBalanceCents = GeneratedColumn<int>(
    'current_balance_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableBalanceCentsMeta =
      const VerificationMeta('availableBalanceCents');
  @override
  late final GeneratedColumn<int> availableBalanceCents = GeneratedColumn<int>(
    'available_balance_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    institutionName,
    mask,
    accountType,
    currentBalanceCents,
    availableBalanceCents,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalAccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('institution_name')) {
      context.handle(
        _institutionNameMeta,
        institutionName.isAcceptableOrUnknown(
          data['institution_name']!,
          _institutionNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_institutionNameMeta);
    }
    if (data.containsKey('mask')) {
      context.handle(
        _maskMeta,
        mask.isAcceptableOrUnknown(data['mask']!, _maskMeta),
      );
    } else if (isInserting) {
      context.missing(_maskMeta);
    }
    if (data.containsKey('account_type')) {
      context.handle(
        _accountTypeMeta,
        accountType.isAcceptableOrUnknown(
          data['account_type']!,
          _accountTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountTypeMeta);
    }
    if (data.containsKey('current_balance_cents')) {
      context.handle(
        _currentBalanceCentsMeta,
        currentBalanceCents.isAcceptableOrUnknown(
          data['current_balance_cents']!,
          _currentBalanceCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentBalanceCentsMeta);
    }
    if (data.containsKey('available_balance_cents')) {
      context.handle(
        _availableBalanceCentsMeta,
        availableBalanceCents.isAcceptableOrUnknown(
          data['available_balance_cents']!,
          _availableBalanceCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_availableBalanceCentsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalAccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalAccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      institutionName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}institution_name'],
      )!,
      mask: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mask'],
      )!,
      accountType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}account_type'],
      )!,
      currentBalanceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_balance_cents'],
      )!,
      availableBalanceCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}available_balance_cents'],
      )!,
    );
  }

  @override
  $LocalAccountsTable createAlias(String alias) {
    return $LocalAccountsTable(attachedDatabase, alias);
  }
}

class LocalAccountRow extends DataClass implements Insertable<LocalAccountRow> {
  final String id;
  final String name;
  final String institutionName;
  final String mask;
  final int accountType;
  final int currentBalanceCents;
  final int availableBalanceCents;
  const LocalAccountRow({
    required this.id,
    required this.name,
    required this.institutionName,
    required this.mask,
    required this.accountType,
    required this.currentBalanceCents,
    required this.availableBalanceCents,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['institution_name'] = Variable<String>(institutionName);
    map['mask'] = Variable<String>(mask);
    map['account_type'] = Variable<int>(accountType);
    map['current_balance_cents'] = Variable<int>(currentBalanceCents);
    map['available_balance_cents'] = Variable<int>(availableBalanceCents);
    return map;
  }

  LocalAccountsCompanion toCompanion(bool nullToAbsent) {
    return LocalAccountsCompanion(
      id: Value(id),
      name: Value(name),
      institutionName: Value(institutionName),
      mask: Value(mask),
      accountType: Value(accountType),
      currentBalanceCents: Value(currentBalanceCents),
      availableBalanceCents: Value(availableBalanceCents),
    );
  }

  factory LocalAccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalAccountRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      institutionName: serializer.fromJson<String>(json['institutionName']),
      mask: serializer.fromJson<String>(json['mask']),
      accountType: serializer.fromJson<int>(json['accountType']),
      currentBalanceCents: serializer.fromJson<int>(
        json['currentBalanceCents'],
      ),
      availableBalanceCents: serializer.fromJson<int>(
        json['availableBalanceCents'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'institutionName': serializer.toJson<String>(institutionName),
      'mask': serializer.toJson<String>(mask),
      'accountType': serializer.toJson<int>(accountType),
      'currentBalanceCents': serializer.toJson<int>(currentBalanceCents),
      'availableBalanceCents': serializer.toJson<int>(availableBalanceCents),
    };
  }

  LocalAccountRow copyWith({
    String? id,
    String? name,
    String? institutionName,
    String? mask,
    int? accountType,
    int? currentBalanceCents,
    int? availableBalanceCents,
  }) => LocalAccountRow(
    id: id ?? this.id,
    name: name ?? this.name,
    institutionName: institutionName ?? this.institutionName,
    mask: mask ?? this.mask,
    accountType: accountType ?? this.accountType,
    currentBalanceCents: currentBalanceCents ?? this.currentBalanceCents,
    availableBalanceCents: availableBalanceCents ?? this.availableBalanceCents,
  );
  LocalAccountRow copyWithCompanion(LocalAccountsCompanion data) {
    return LocalAccountRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      institutionName: data.institutionName.present
          ? data.institutionName.value
          : this.institutionName,
      mask: data.mask.present ? data.mask.value : this.mask,
      accountType: data.accountType.present
          ? data.accountType.value
          : this.accountType,
      currentBalanceCents: data.currentBalanceCents.present
          ? data.currentBalanceCents.value
          : this.currentBalanceCents,
      availableBalanceCents: data.availableBalanceCents.present
          ? data.availableBalanceCents.value
          : this.availableBalanceCents,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('institutionName: $institutionName, ')
          ..write('mask: $mask, ')
          ..write('accountType: $accountType, ')
          ..write('currentBalanceCents: $currentBalanceCents, ')
          ..write('availableBalanceCents: $availableBalanceCents')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    institutionName,
    mask,
    accountType,
    currentBalanceCents,
    availableBalanceCents,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalAccountRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.institutionName == this.institutionName &&
          other.mask == this.mask &&
          other.accountType == this.accountType &&
          other.currentBalanceCents == this.currentBalanceCents &&
          other.availableBalanceCents == this.availableBalanceCents);
}

class LocalAccountsCompanion extends UpdateCompanion<LocalAccountRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> institutionName;
  final Value<String> mask;
  final Value<int> accountType;
  final Value<int> currentBalanceCents;
  final Value<int> availableBalanceCents;
  final Value<int> rowid;
  const LocalAccountsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.institutionName = const Value.absent(),
    this.mask = const Value.absent(),
    this.accountType = const Value.absent(),
    this.currentBalanceCents = const Value.absent(),
    this.availableBalanceCents = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalAccountsCompanion.insert({
    required String id,
    required String name,
    required String institutionName,
    required String mask,
    required int accountType,
    required int currentBalanceCents,
    required int availableBalanceCents,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       institutionName = Value(institutionName),
       mask = Value(mask),
       accountType = Value(accountType),
       currentBalanceCents = Value(currentBalanceCents),
       availableBalanceCents = Value(availableBalanceCents);
  static Insertable<LocalAccountRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? institutionName,
    Expression<String>? mask,
    Expression<int>? accountType,
    Expression<int>? currentBalanceCents,
    Expression<int>? availableBalanceCents,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (institutionName != null) 'institution_name': institutionName,
      if (mask != null) 'mask': mask,
      if (accountType != null) 'account_type': accountType,
      if (currentBalanceCents != null)
        'current_balance_cents': currentBalanceCents,
      if (availableBalanceCents != null)
        'available_balance_cents': availableBalanceCents,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? institutionName,
    Value<String>? mask,
    Value<int>? accountType,
    Value<int>? currentBalanceCents,
    Value<int>? availableBalanceCents,
    Value<int>? rowid,
  }) {
    return LocalAccountsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      institutionName: institutionName ?? this.institutionName,
      mask: mask ?? this.mask,
      accountType: accountType ?? this.accountType,
      currentBalanceCents: currentBalanceCents ?? this.currentBalanceCents,
      availableBalanceCents:
          availableBalanceCents ?? this.availableBalanceCents,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (institutionName.present) {
      map['institution_name'] = Variable<String>(institutionName.value);
    }
    if (mask.present) {
      map['mask'] = Variable<String>(mask.value);
    }
    if (accountType.present) {
      map['account_type'] = Variable<int>(accountType.value);
    }
    if (currentBalanceCents.present) {
      map['current_balance_cents'] = Variable<int>(currentBalanceCents.value);
    }
    if (availableBalanceCents.present) {
      map['available_balance_cents'] = Variable<int>(
        availableBalanceCents.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalAccountsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('institutionName: $institutionName, ')
          ..write('mask: $mask, ')
          ..write('accountType: $accountType, ')
          ..write('currentBalanceCents: $currentBalanceCents, ')
          ..write('availableBalanceCents: $availableBalanceCents, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalTransactionsTable extends LocalTransactions
    with TableInfo<$LocalTransactionsTable, LocalTransactionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountIdMeta = const VerificationMeta(
    'accountId',
  );
  @override
  late final GeneratedColumn<String> accountId = GeneratedColumn<String>(
    'account_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_accounts (id)',
    ),
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionStatusMeta = const VerificationMeta(
    'transactionStatus',
  );
  @override
  late final GeneratedColumn<int> transactionStatus = GeneratedColumn<int>(
    'transaction_status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _merchantNameMeta = const VerificationMeta(
    'merchantName',
  );
  @override
  late final GeneratedColumn<String> merchantName = GeneratedColumn<String>(
    'merchant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _providerTransactionIdMeta =
      const VerificationMeta('providerTransactionId');
  @override
  late final GeneratedColumn<String> providerTransactionId =
      GeneratedColumn<String>(
        'provider_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _parentTransactionIdMeta =
      const VerificationMeta('parentTransactionId');
  @override
  late final GeneratedColumn<String> parentTransactionId =
      GeneratedColumn<String>(
        'parent_transaction_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isPossibleDuplicateMeta =
      const VerificationMeta('isPossibleDuplicate');
  @override
  late final GeneratedColumn<bool> isPossibleDuplicate = GeneratedColumn<bool>(
    'is_possible_duplicate',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_possible_duplicate" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _importFingerprintMeta = const VerificationMeta(
    'importFingerprint',
  );
  @override
  late final GeneratedColumn<String> importFingerprint =
      GeneratedColumn<String>(
        'import_fingerprint',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
      );
  static const VerificationMeta _importBatchIdMeta = const VerificationMeta(
    'importBatchId',
  );
  @override
  late final GeneratedColumn<String> importBatchId = GeneratedColumn<String>(
    'import_batch_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountId,
    transactionDate,
    description,
    amountCents,
    category,
    transactionStatus,
    merchantName,
    providerTransactionId,
    parentTransactionId,
    isPossibleDuplicate,
    importFingerprint,
    importBatchId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalTransactionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('account_id')) {
      context.handle(
        _accountIdMeta,
        accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta),
      );
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('transaction_status')) {
      context.handle(
        _transactionStatusMeta,
        transactionStatus.isAcceptableOrUnknown(
          data['transaction_status']!,
          _transactionStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionStatusMeta);
    }
    if (data.containsKey('merchant_name')) {
      context.handle(
        _merchantNameMeta,
        merchantName.isAcceptableOrUnknown(
          data['merchant_name']!,
          _merchantNameMeta,
        ),
      );
    }
    if (data.containsKey('provider_transaction_id')) {
      context.handle(
        _providerTransactionIdMeta,
        providerTransactionId.isAcceptableOrUnknown(
          data['provider_transaction_id']!,
          _providerTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('parent_transaction_id')) {
      context.handle(
        _parentTransactionIdMeta,
        parentTransactionId.isAcceptableOrUnknown(
          data['parent_transaction_id']!,
          _parentTransactionIdMeta,
        ),
      );
    }
    if (data.containsKey('is_possible_duplicate')) {
      context.handle(
        _isPossibleDuplicateMeta,
        isPossibleDuplicate.isAcceptableOrUnknown(
          data['is_possible_duplicate']!,
          _isPossibleDuplicateMeta,
        ),
      );
    }
    if (data.containsKey('import_fingerprint')) {
      context.handle(
        _importFingerprintMeta,
        importFingerprint.isAcceptableOrUnknown(
          data['import_fingerprint']!,
          _importFingerprintMeta,
        ),
      );
    }
    if (data.containsKey('import_batch_id')) {
      context.handle(
        _importBatchIdMeta,
        importBatchId.isAcceptableOrUnknown(
          data['import_batch_id']!,
          _importBatchIdMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalTransactionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalTransactionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      accountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_id'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category'],
      )!,
      transactionStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}transaction_status'],
      )!,
      merchantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name'],
      ),
      providerTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider_transaction_id'],
      ),
      parentTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_transaction_id'],
      ),
      isPossibleDuplicate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_possible_duplicate'],
      )!,
      importFingerprint: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}import_fingerprint'],
      ),
      importBatchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}import_batch_id'],
      ),
    );
  }

  @override
  $LocalTransactionsTable createAlias(String alias) {
    return $LocalTransactionsTable(attachedDatabase, alias);
  }
}

class LocalTransactionRow extends DataClass
    implements Insertable<LocalTransactionRow> {
  final String id;
  final String accountId;
  final DateTime transactionDate;
  final String description;
  final int amountCents;
  final int category;
  final int transactionStatus;
  final String? merchantName;
  final String? providerTransactionId;
  final String? parentTransactionId;
  final bool isPossibleDuplicate;
  final String? importFingerprint;
  final String? importBatchId;
  const LocalTransactionRow({
    required this.id,
    required this.accountId,
    required this.transactionDate,
    required this.description,
    required this.amountCents,
    required this.category,
    required this.transactionStatus,
    this.merchantName,
    this.providerTransactionId,
    this.parentTransactionId,
    required this.isPossibleDuplicate,
    this.importFingerprint,
    this.importBatchId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['account_id'] = Variable<String>(accountId);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    map['category'] = Variable<int>(category);
    map['transaction_status'] = Variable<int>(transactionStatus);
    if (!nullToAbsent || merchantName != null) {
      map['merchant_name'] = Variable<String>(merchantName);
    }
    if (!nullToAbsent || providerTransactionId != null) {
      map['provider_transaction_id'] = Variable<String>(providerTransactionId);
    }
    if (!nullToAbsent || parentTransactionId != null) {
      map['parent_transaction_id'] = Variable<String>(parentTransactionId);
    }
    map['is_possible_duplicate'] = Variable<bool>(isPossibleDuplicate);
    if (!nullToAbsent || importFingerprint != null) {
      map['import_fingerprint'] = Variable<String>(importFingerprint);
    }
    if (!nullToAbsent || importBatchId != null) {
      map['import_batch_id'] = Variable<String>(importBatchId);
    }
    return map;
  }

  LocalTransactionsCompanion toCompanion(bool nullToAbsent) {
    return LocalTransactionsCompanion(
      id: Value(id),
      accountId: Value(accountId),
      transactionDate: Value(transactionDate),
      description: Value(description),
      amountCents: Value(amountCents),
      category: Value(category),
      transactionStatus: Value(transactionStatus),
      merchantName: merchantName == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantName),
      providerTransactionId: providerTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(providerTransactionId),
      parentTransactionId: parentTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentTransactionId),
      isPossibleDuplicate: Value(isPossibleDuplicate),
      importFingerprint: importFingerprint == null && nullToAbsent
          ? const Value.absent()
          : Value(importFingerprint),
      importBatchId: importBatchId == null && nullToAbsent
          ? const Value.absent()
          : Value(importBatchId),
    );
  }

  factory LocalTransactionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalTransactionRow(
      id: serializer.fromJson<String>(json['id']),
      accountId: serializer.fromJson<String>(json['accountId']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      category: serializer.fromJson<int>(json['category']),
      transactionStatus: serializer.fromJson<int>(json['transactionStatus']),
      merchantName: serializer.fromJson<String?>(json['merchantName']),
      providerTransactionId: serializer.fromJson<String?>(
        json['providerTransactionId'],
      ),
      parentTransactionId: serializer.fromJson<String?>(
        json['parentTransactionId'],
      ),
      isPossibleDuplicate: serializer.fromJson<bool>(
        json['isPossibleDuplicate'],
      ),
      importFingerprint: serializer.fromJson<String?>(
        json['importFingerprint'],
      ),
      importBatchId: serializer.fromJson<String?>(json['importBatchId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'accountId': serializer.toJson<String>(accountId),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'description': serializer.toJson<String>(description),
      'amountCents': serializer.toJson<int>(amountCents),
      'category': serializer.toJson<int>(category),
      'transactionStatus': serializer.toJson<int>(transactionStatus),
      'merchantName': serializer.toJson<String?>(merchantName),
      'providerTransactionId': serializer.toJson<String?>(
        providerTransactionId,
      ),
      'parentTransactionId': serializer.toJson<String?>(parentTransactionId),
      'isPossibleDuplicate': serializer.toJson<bool>(isPossibleDuplicate),
      'importFingerprint': serializer.toJson<String?>(importFingerprint),
      'importBatchId': serializer.toJson<String?>(importBatchId),
    };
  }

  LocalTransactionRow copyWith({
    String? id,
    String? accountId,
    DateTime? transactionDate,
    String? description,
    int? amountCents,
    int? category,
    int? transactionStatus,
    Value<String?> merchantName = const Value.absent(),
    Value<String?> providerTransactionId = const Value.absent(),
    Value<String?> parentTransactionId = const Value.absent(),
    bool? isPossibleDuplicate,
    Value<String?> importFingerprint = const Value.absent(),
    Value<String?> importBatchId = const Value.absent(),
  }) => LocalTransactionRow(
    id: id ?? this.id,
    accountId: accountId ?? this.accountId,
    transactionDate: transactionDate ?? this.transactionDate,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
    category: category ?? this.category,
    transactionStatus: transactionStatus ?? this.transactionStatus,
    merchantName: merchantName.present ? merchantName.value : this.merchantName,
    providerTransactionId: providerTransactionId.present
        ? providerTransactionId.value
        : this.providerTransactionId,
    parentTransactionId: parentTransactionId.present
        ? parentTransactionId.value
        : this.parentTransactionId,
    isPossibleDuplicate: isPossibleDuplicate ?? this.isPossibleDuplicate,
    importFingerprint: importFingerprint.present
        ? importFingerprint.value
        : this.importFingerprint,
    importBatchId: importBatchId.present
        ? importBatchId.value
        : this.importBatchId,
  );
  LocalTransactionRow copyWithCompanion(LocalTransactionsCompanion data) {
    return LocalTransactionRow(
      id: data.id.present ? data.id.value : this.id,
      accountId: data.accountId.present ? data.accountId.value : this.accountId,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      category: data.category.present ? data.category.value : this.category,
      transactionStatus: data.transactionStatus.present
          ? data.transactionStatus.value
          : this.transactionStatus,
      merchantName: data.merchantName.present
          ? data.merchantName.value
          : this.merchantName,
      providerTransactionId: data.providerTransactionId.present
          ? data.providerTransactionId.value
          : this.providerTransactionId,
      parentTransactionId: data.parentTransactionId.present
          ? data.parentTransactionId.value
          : this.parentTransactionId,
      isPossibleDuplicate: data.isPossibleDuplicate.present
          ? data.isPossibleDuplicate.value
          : this.isPossibleDuplicate,
      importFingerprint: data.importFingerprint.present
          ? data.importFingerprint.value
          : this.importFingerprint,
      importBatchId: data.importBatchId.present
          ? data.importBatchId.value
          : this.importBatchId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionRow(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('category: $category, ')
          ..write('transactionStatus: $transactionStatus, ')
          ..write('merchantName: $merchantName, ')
          ..write('providerTransactionId: $providerTransactionId, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('isPossibleDuplicate: $isPossibleDuplicate, ')
          ..write('importFingerprint: $importFingerprint, ')
          ..write('importBatchId: $importBatchId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    accountId,
    transactionDate,
    description,
    amountCents,
    category,
    transactionStatus,
    merchantName,
    providerTransactionId,
    parentTransactionId,
    isPossibleDuplicate,
    importFingerprint,
    importBatchId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalTransactionRow &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.transactionDate == this.transactionDate &&
          other.description == this.description &&
          other.amountCents == this.amountCents &&
          other.category == this.category &&
          other.transactionStatus == this.transactionStatus &&
          other.merchantName == this.merchantName &&
          other.providerTransactionId == this.providerTransactionId &&
          other.parentTransactionId == this.parentTransactionId &&
          other.isPossibleDuplicate == this.isPossibleDuplicate &&
          other.importFingerprint == this.importFingerprint &&
          other.importBatchId == this.importBatchId);
}

class LocalTransactionsCompanion extends UpdateCompanion<LocalTransactionRow> {
  final Value<String> id;
  final Value<String> accountId;
  final Value<DateTime> transactionDate;
  final Value<String> description;
  final Value<int> amountCents;
  final Value<int> category;
  final Value<int> transactionStatus;
  final Value<String?> merchantName;
  final Value<String?> providerTransactionId;
  final Value<String?> parentTransactionId;
  final Value<bool> isPossibleDuplicate;
  final Value<String?> importFingerprint;
  final Value<String?> importBatchId;
  final Value<int> rowid;
  const LocalTransactionsCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.category = const Value.absent(),
    this.transactionStatus = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.providerTransactionId = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.isPossibleDuplicate = const Value.absent(),
    this.importFingerprint = const Value.absent(),
    this.importBatchId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalTransactionsCompanion.insert({
    required String id,
    required String accountId,
    required DateTime transactionDate,
    required String description,
    required int amountCents,
    required int category,
    required int transactionStatus,
    this.merchantName = const Value.absent(),
    this.providerTransactionId = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.isPossibleDuplicate = const Value.absent(),
    this.importFingerprint = const Value.absent(),
    this.importBatchId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       accountId = Value(accountId),
       transactionDate = Value(transactionDate),
       description = Value(description),
       amountCents = Value(amountCents),
       category = Value(category),
       transactionStatus = Value(transactionStatus);
  static Insertable<LocalTransactionRow> custom({
    Expression<String>? id,
    Expression<String>? accountId,
    Expression<DateTime>? transactionDate,
    Expression<String>? description,
    Expression<int>? amountCents,
    Expression<int>? category,
    Expression<int>? transactionStatus,
    Expression<String>? merchantName,
    Expression<String>? providerTransactionId,
    Expression<String>? parentTransactionId,
    Expression<bool>? isPossibleDuplicate,
    Expression<String>? importFingerprint,
    Expression<String>? importBatchId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
      if (category != null) 'category': category,
      if (transactionStatus != null) 'transaction_status': transactionStatus,
      if (merchantName != null) 'merchant_name': merchantName,
      if (providerTransactionId != null)
        'provider_transaction_id': providerTransactionId,
      if (parentTransactionId != null)
        'parent_transaction_id': parentTransactionId,
      if (isPossibleDuplicate != null)
        'is_possible_duplicate': isPossibleDuplicate,
      if (importFingerprint != null) 'import_fingerprint': importFingerprint,
      if (importBatchId != null) 'import_batch_id': importBatchId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalTransactionsCompanion copyWith({
    Value<String>? id,
    Value<String>? accountId,
    Value<DateTime>? transactionDate,
    Value<String>? description,
    Value<int>? amountCents,
    Value<int>? category,
    Value<int>? transactionStatus,
    Value<String?>? merchantName,
    Value<String?>? providerTransactionId,
    Value<String?>? parentTransactionId,
    Value<bool>? isPossibleDuplicate,
    Value<String?>? importFingerprint,
    Value<String?>? importBatchId,
    Value<int>? rowid,
  }) {
    return LocalTransactionsCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      transactionDate: transactionDate ?? this.transactionDate,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
      category: category ?? this.category,
      transactionStatus: transactionStatus ?? this.transactionStatus,
      merchantName: merchantName ?? this.merchantName,
      providerTransactionId:
          providerTransactionId ?? this.providerTransactionId,
      parentTransactionId: parentTransactionId ?? this.parentTransactionId,
      isPossibleDuplicate: isPossibleDuplicate ?? this.isPossibleDuplicate,
      importFingerprint: importFingerprint ?? this.importFingerprint,
      importBatchId: importBatchId ?? this.importBatchId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<String>(accountId.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (transactionStatus.present) {
      map['transaction_status'] = Variable<int>(transactionStatus.value);
    }
    if (merchantName.present) {
      map['merchant_name'] = Variable<String>(merchantName.value);
    }
    if (providerTransactionId.present) {
      map['provider_transaction_id'] = Variable<String>(
        providerTransactionId.value,
      );
    }
    if (parentTransactionId.present) {
      map['parent_transaction_id'] = Variable<String>(
        parentTransactionId.value,
      );
    }
    if (isPossibleDuplicate.present) {
      map['is_possible_duplicate'] = Variable<bool>(isPossibleDuplicate.value);
    }
    if (importFingerprint.present) {
      map['import_fingerprint'] = Variable<String>(importFingerprint.value);
    }
    if (importBatchId.present) {
      map['import_batch_id'] = Variable<String>(importBatchId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('category: $category, ')
          ..write('transactionStatus: $transactionStatus, ')
          ..write('merchantName: $merchantName, ')
          ..write('providerTransactionId: $providerTransactionId, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('isPossibleDuplicate: $isPossibleDuplicate, ')
          ..write('importFingerprint: $importFingerprint, ')
          ..write('importBatchId: $importBatchId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoryCorrectionsTable extends CategoryCorrections
    with TableInfo<$CategoryCorrectionsTable, CategoryCorrectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryCorrectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [transactionId, category, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_corrections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryCorrectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {transactionId};
  @override
  CategoryCorrectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryCorrectionRow(
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CategoryCorrectionsTable createAlias(String alias) {
    return $CategoryCorrectionsTable(attachedDatabase, alias);
  }
}

class CategoryCorrectionRow extends DataClass
    implements Insertable<CategoryCorrectionRow> {
  final String transactionId;
  final int category;
  final DateTime updatedAt;
  const CategoryCorrectionRow({
    required this.transactionId,
    required this.category,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['transaction_id'] = Variable<String>(transactionId);
    map['category'] = Variable<int>(category);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryCorrectionsCompanion toCompanion(bool nullToAbsent) {
    return CategoryCorrectionsCompanion(
      transactionId: Value(transactionId),
      category: Value(category),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryCorrectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryCorrectionRow(
      transactionId: serializer.fromJson<String>(json['transactionId']),
      category: serializer.fromJson<int>(json['category']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'transactionId': serializer.toJson<String>(transactionId),
      'category': serializer.toJson<int>(category),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryCorrectionRow copyWith({
    String? transactionId,
    int? category,
    DateTime? updatedAt,
  }) => CategoryCorrectionRow(
    transactionId: transactionId ?? this.transactionId,
    category: category ?? this.category,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CategoryCorrectionRow copyWithCompanion(CategoryCorrectionsCompanion data) {
    return CategoryCorrectionRow(
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      category: data.category.present ? data.category.value : this.category,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCorrectionRow(')
          ..write('transactionId: $transactionId, ')
          ..write('category: $category, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(transactionId, category, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryCorrectionRow &&
          other.transactionId == this.transactionId &&
          other.category == this.category &&
          other.updatedAt == this.updatedAt);
}

class CategoryCorrectionsCompanion
    extends UpdateCompanion<CategoryCorrectionRow> {
  final Value<String> transactionId;
  final Value<int> category;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CategoryCorrectionsCompanion({
    this.transactionId = const Value.absent(),
    this.category = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoryCorrectionsCompanion.insert({
    required String transactionId,
    required int category,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : transactionId = Value(transactionId),
       category = Value(category),
       updatedAt = Value(updatedAt);
  static Insertable<CategoryCorrectionRow> custom({
    Expression<String>? transactionId,
    Expression<int>? category,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (transactionId != null) 'transaction_id': transactionId,
      if (category != null) 'category': category,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoryCorrectionsCompanion copyWith({
    Value<String>? transactionId,
    Value<int>? category,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CategoryCorrectionsCompanion(
      transactionId: transactionId ?? this.transactionId,
      category: category ?? this.category,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCorrectionsCompanion(')
          ..write('transactionId: $transactionId, ')
          ..write('category: $category, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionSplitsTable extends TransactionSplits
    with TableInfo<$TransactionSplitsTable, TransactionSplitRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionSplitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parentTransactionIdMeta =
      const VerificationMeta('parentTransactionId');
  @override
  late final GeneratedColumn<String> parentTransactionId =
      GeneratedColumn<String>(
        'parent_transaction_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<int> category = GeneratedColumn<int>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    parentTransactionId,
    description,
    amountCents,
    category,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_splits';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionSplitRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('parent_transaction_id')) {
      context.handle(
        _parentTransactionIdMeta,
        parentTransactionId.isAcceptableOrUnknown(
          data['parent_transaction_id']!,
          _parentTransactionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_parentTransactionIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountCentsMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionSplitRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionSplitRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      parentTransactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}parent_transaction_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TransactionSplitsTable createAlias(String alias) {
    return $TransactionSplitsTable(attachedDatabase, alias);
  }
}

class TransactionSplitRow extends DataClass
    implements Insertable<TransactionSplitRow> {
  final String id;
  final String parentTransactionId;
  final String description;
  final int amountCents;
  final int category;
  final DateTime createdAt;
  const TransactionSplitRow({
    required this.id,
    required this.parentTransactionId,
    required this.description,
    required this.amountCents,
    required this.category,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['parent_transaction_id'] = Variable<String>(parentTransactionId);
    map['description'] = Variable<String>(description);
    map['amount_cents'] = Variable<int>(amountCents);
    map['category'] = Variable<int>(category);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionSplitsCompanion toCompanion(bool nullToAbsent) {
    return TransactionSplitsCompanion(
      id: Value(id),
      parentTransactionId: Value(parentTransactionId),
      description: Value(description),
      amountCents: Value(amountCents),
      category: Value(category),
      createdAt: Value(createdAt),
    );
  }

  factory TransactionSplitRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionSplitRow(
      id: serializer.fromJson<String>(json['id']),
      parentTransactionId: serializer.fromJson<String>(
        json['parentTransactionId'],
      ),
      description: serializer.fromJson<String>(json['description']),
      amountCents: serializer.fromJson<int>(json['amountCents']),
      category: serializer.fromJson<int>(json['category']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'parentTransactionId': serializer.toJson<String>(parentTransactionId),
      'description': serializer.toJson<String>(description),
      'amountCents': serializer.toJson<int>(amountCents),
      'category': serializer.toJson<int>(category),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TransactionSplitRow copyWith({
    String? id,
    String? parentTransactionId,
    String? description,
    int? amountCents,
    int? category,
    DateTime? createdAt,
  }) => TransactionSplitRow(
    id: id ?? this.id,
    parentTransactionId: parentTransactionId ?? this.parentTransactionId,
    description: description ?? this.description,
    amountCents: amountCents ?? this.amountCents,
    category: category ?? this.category,
    createdAt: createdAt ?? this.createdAt,
  );
  TransactionSplitRow copyWithCompanion(TransactionSplitsCompanion data) {
    return TransactionSplitRow(
      id: data.id.present ? data.id.value : this.id,
      parentTransactionId: data.parentTransactionId.present
          ? data.parentTransactionId.value
          : this.parentTransactionId,
      description: data.description.present
          ? data.description.value
          : this.description,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionSplitRow(')
          ..write('id: $id, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    parentTransactionId,
    description,
    amountCents,
    category,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionSplitRow &&
          other.id == this.id &&
          other.parentTransactionId == this.parentTransactionId &&
          other.description == this.description &&
          other.amountCents == this.amountCents &&
          other.category == this.category &&
          other.createdAt == this.createdAt);
}

class TransactionSplitsCompanion extends UpdateCompanion<TransactionSplitRow> {
  final Value<String> id;
  final Value<String> parentTransactionId;
  final Value<String> description;
  final Value<int> amountCents;
  final Value<int> category;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TransactionSplitsCompanion({
    this.id = const Value.absent(),
    this.parentTransactionId = const Value.absent(),
    this.description = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionSplitsCompanion.insert({
    required String id,
    required String parentTransactionId,
    required String description,
    required int amountCents,
    required int category,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       parentTransactionId = Value(parentTransactionId),
       description = Value(description),
       amountCents = Value(amountCents),
       category = Value(category),
       createdAt = Value(createdAt);
  static Insertable<TransactionSplitRow> custom({
    Expression<String>? id,
    Expression<String>? parentTransactionId,
    Expression<String>? description,
    Expression<int>? amountCents,
    Expression<int>? category,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (parentTransactionId != null)
        'parent_transaction_id': parentTransactionId,
      if (description != null) 'description': description,
      if (amountCents != null) 'amount_cents': amountCents,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionSplitsCompanion copyWith({
    Value<String>? id,
    Value<String>? parentTransactionId,
    Value<String>? description,
    Value<int>? amountCents,
    Value<int>? category,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TransactionSplitsCompanion(
      id: id ?? this.id,
      parentTransactionId: parentTransactionId ?? this.parentTransactionId,
      description: description ?? this.description,
      amountCents: amountCents ?? this.amountCents,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (parentTransactionId.present) {
      map['parent_transaction_id'] = Variable<String>(
        parentTransactionId.value,
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(category.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionSplitsCompanion(')
          ..write('id: $id, ')
          ..write('parentTransactionId: $parentTransactionId, ')
          ..write('description: $description, ')
          ..write('amountCents: $amountCents, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportMappingsTable extends ImportMappings
    with TableInfo<$ImportMappingsTable, ImportMappingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportMappingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _headerSignatureMeta = const VerificationMeta(
    'headerSignature',
  );
  @override
  late final GeneratedColumn<String> headerSignature = GeneratedColumn<String>(
    'header_signature',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateColumnMeta = const VerificationMeta(
    'dateColumn',
  );
  @override
  late final GeneratedColumn<String> dateColumn = GeneratedColumn<String>(
    'date_column',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionColumnMeta = const VerificationMeta(
    'descriptionColumn',
  );
  @override
  late final GeneratedColumn<String> descriptionColumn =
      GeneratedColumn<String>(
        'description_column',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _amountColumnMeta = const VerificationMeta(
    'amountColumn',
  );
  @override
  late final GeneratedColumn<String> amountColumn = GeneratedColumn<String>(
    'amount_column',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _debitColumnMeta = const VerificationMeta(
    'debitColumn',
  );
  @override
  late final GeneratedColumn<String> debitColumn = GeneratedColumn<String>(
    'debit_column',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creditColumnMeta = const VerificationMeta(
    'creditColumn',
  );
  @override
  late final GeneratedColumn<String> creditColumn = GeneratedColumn<String>(
    'credit_column',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datePatternMeta = const VerificationMeta(
    'datePattern',
  );
  @override
  late final GeneratedColumn<String> datePattern = GeneratedColumn<String>(
    'date_pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expensesAreNegativeMeta =
      const VerificationMeta('expensesAreNegative');
  @override
  late final GeneratedColumn<bool> expensesAreNegative = GeneratedColumn<bool>(
    'expenses_are_negative',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("expenses_are_negative" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    headerSignature,
    dateColumn,
    descriptionColumn,
    amountColumn,
    debitColumn,
    creditColumn,
    datePattern,
    expensesAreNegative,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'import_mappings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportMappingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('header_signature')) {
      context.handle(
        _headerSignatureMeta,
        headerSignature.isAcceptableOrUnknown(
          data['header_signature']!,
          _headerSignatureMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_headerSignatureMeta);
    }
    if (data.containsKey('date_column')) {
      context.handle(
        _dateColumnMeta,
        dateColumn.isAcceptableOrUnknown(data['date_column']!, _dateColumnMeta),
      );
    } else if (isInserting) {
      context.missing(_dateColumnMeta);
    }
    if (data.containsKey('description_column')) {
      context.handle(
        _descriptionColumnMeta,
        descriptionColumn.isAcceptableOrUnknown(
          data['description_column']!,
          _descriptionColumnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionColumnMeta);
    }
    if (data.containsKey('amount_column')) {
      context.handle(
        _amountColumnMeta,
        amountColumn.isAcceptableOrUnknown(
          data['amount_column']!,
          _amountColumnMeta,
        ),
      );
    }
    if (data.containsKey('debit_column')) {
      context.handle(
        _debitColumnMeta,
        debitColumn.isAcceptableOrUnknown(
          data['debit_column']!,
          _debitColumnMeta,
        ),
      );
    }
    if (data.containsKey('credit_column')) {
      context.handle(
        _creditColumnMeta,
        creditColumn.isAcceptableOrUnknown(
          data['credit_column']!,
          _creditColumnMeta,
        ),
      );
    }
    if (data.containsKey('date_pattern')) {
      context.handle(
        _datePatternMeta,
        datePattern.isAcceptableOrUnknown(
          data['date_pattern']!,
          _datePatternMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datePatternMeta);
    }
    if (data.containsKey('expenses_are_negative')) {
      context.handle(
        _expensesAreNegativeMeta,
        expensesAreNegative.isAcceptableOrUnknown(
          data['expenses_are_negative']!,
          _expensesAreNegativeMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {headerSignature};
  @override
  ImportMappingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportMappingRow(
      headerSignature: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}header_signature'],
      )!,
      dateColumn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_column'],
      )!,
      descriptionColumn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description_column'],
      )!,
      amountColumn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount_column'],
      ),
      debitColumn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}debit_column'],
      ),
      creditColumn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}credit_column'],
      ),
      datePattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_pattern'],
      )!,
      expensesAreNegative: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}expenses_are_negative'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ImportMappingsTable createAlias(String alias) {
    return $ImportMappingsTable(attachedDatabase, alias);
  }
}

class ImportMappingRow extends DataClass
    implements Insertable<ImportMappingRow> {
  final String headerSignature;
  final String dateColumn;
  final String descriptionColumn;
  final String? amountColumn;
  final String? debitColumn;
  final String? creditColumn;
  final String datePattern;
  final bool expensesAreNegative;
  final DateTime updatedAt;
  const ImportMappingRow({
    required this.headerSignature,
    required this.dateColumn,
    required this.descriptionColumn,
    this.amountColumn,
    this.debitColumn,
    this.creditColumn,
    required this.datePattern,
    required this.expensesAreNegative,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['header_signature'] = Variable<String>(headerSignature);
    map['date_column'] = Variable<String>(dateColumn);
    map['description_column'] = Variable<String>(descriptionColumn);
    if (!nullToAbsent || amountColumn != null) {
      map['amount_column'] = Variable<String>(amountColumn);
    }
    if (!nullToAbsent || debitColumn != null) {
      map['debit_column'] = Variable<String>(debitColumn);
    }
    if (!nullToAbsent || creditColumn != null) {
      map['credit_column'] = Variable<String>(creditColumn);
    }
    map['date_pattern'] = Variable<String>(datePattern);
    map['expenses_are_negative'] = Variable<bool>(expensesAreNegative);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ImportMappingsCompanion toCompanion(bool nullToAbsent) {
    return ImportMappingsCompanion(
      headerSignature: Value(headerSignature),
      dateColumn: Value(dateColumn),
      descriptionColumn: Value(descriptionColumn),
      amountColumn: amountColumn == null && nullToAbsent
          ? const Value.absent()
          : Value(amountColumn),
      debitColumn: debitColumn == null && nullToAbsent
          ? const Value.absent()
          : Value(debitColumn),
      creditColumn: creditColumn == null && nullToAbsent
          ? const Value.absent()
          : Value(creditColumn),
      datePattern: Value(datePattern),
      expensesAreNegative: Value(expensesAreNegative),
      updatedAt: Value(updatedAt),
    );
  }

  factory ImportMappingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportMappingRow(
      headerSignature: serializer.fromJson<String>(json['headerSignature']),
      dateColumn: serializer.fromJson<String>(json['dateColumn']),
      descriptionColumn: serializer.fromJson<String>(json['descriptionColumn']),
      amountColumn: serializer.fromJson<String?>(json['amountColumn']),
      debitColumn: serializer.fromJson<String?>(json['debitColumn']),
      creditColumn: serializer.fromJson<String?>(json['creditColumn']),
      datePattern: serializer.fromJson<String>(json['datePattern']),
      expensesAreNegative: serializer.fromJson<bool>(
        json['expensesAreNegative'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'headerSignature': serializer.toJson<String>(headerSignature),
      'dateColumn': serializer.toJson<String>(dateColumn),
      'descriptionColumn': serializer.toJson<String>(descriptionColumn),
      'amountColumn': serializer.toJson<String?>(amountColumn),
      'debitColumn': serializer.toJson<String?>(debitColumn),
      'creditColumn': serializer.toJson<String?>(creditColumn),
      'datePattern': serializer.toJson<String>(datePattern),
      'expensesAreNegative': serializer.toJson<bool>(expensesAreNegative),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ImportMappingRow copyWith({
    String? headerSignature,
    String? dateColumn,
    String? descriptionColumn,
    Value<String?> amountColumn = const Value.absent(),
    Value<String?> debitColumn = const Value.absent(),
    Value<String?> creditColumn = const Value.absent(),
    String? datePattern,
    bool? expensesAreNegative,
    DateTime? updatedAt,
  }) => ImportMappingRow(
    headerSignature: headerSignature ?? this.headerSignature,
    dateColumn: dateColumn ?? this.dateColumn,
    descriptionColumn: descriptionColumn ?? this.descriptionColumn,
    amountColumn: amountColumn.present ? amountColumn.value : this.amountColumn,
    debitColumn: debitColumn.present ? debitColumn.value : this.debitColumn,
    creditColumn: creditColumn.present ? creditColumn.value : this.creditColumn,
    datePattern: datePattern ?? this.datePattern,
    expensesAreNegative: expensesAreNegative ?? this.expensesAreNegative,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ImportMappingRow copyWithCompanion(ImportMappingsCompanion data) {
    return ImportMappingRow(
      headerSignature: data.headerSignature.present
          ? data.headerSignature.value
          : this.headerSignature,
      dateColumn: data.dateColumn.present
          ? data.dateColumn.value
          : this.dateColumn,
      descriptionColumn: data.descriptionColumn.present
          ? data.descriptionColumn.value
          : this.descriptionColumn,
      amountColumn: data.amountColumn.present
          ? data.amountColumn.value
          : this.amountColumn,
      debitColumn: data.debitColumn.present
          ? data.debitColumn.value
          : this.debitColumn,
      creditColumn: data.creditColumn.present
          ? data.creditColumn.value
          : this.creditColumn,
      datePattern: data.datePattern.present
          ? data.datePattern.value
          : this.datePattern,
      expensesAreNegative: data.expensesAreNegative.present
          ? data.expensesAreNegative.value
          : this.expensesAreNegative,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportMappingRow(')
          ..write('headerSignature: $headerSignature, ')
          ..write('dateColumn: $dateColumn, ')
          ..write('descriptionColumn: $descriptionColumn, ')
          ..write('amountColumn: $amountColumn, ')
          ..write('debitColumn: $debitColumn, ')
          ..write('creditColumn: $creditColumn, ')
          ..write('datePattern: $datePattern, ')
          ..write('expensesAreNegative: $expensesAreNegative, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    headerSignature,
    dateColumn,
    descriptionColumn,
    amountColumn,
    debitColumn,
    creditColumn,
    datePattern,
    expensesAreNegative,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportMappingRow &&
          other.headerSignature == this.headerSignature &&
          other.dateColumn == this.dateColumn &&
          other.descriptionColumn == this.descriptionColumn &&
          other.amountColumn == this.amountColumn &&
          other.debitColumn == this.debitColumn &&
          other.creditColumn == this.creditColumn &&
          other.datePattern == this.datePattern &&
          other.expensesAreNegative == this.expensesAreNegative &&
          other.updatedAt == this.updatedAt);
}

class ImportMappingsCompanion extends UpdateCompanion<ImportMappingRow> {
  final Value<String> headerSignature;
  final Value<String> dateColumn;
  final Value<String> descriptionColumn;
  final Value<String?> amountColumn;
  final Value<String?> debitColumn;
  final Value<String?> creditColumn;
  final Value<String> datePattern;
  final Value<bool> expensesAreNegative;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ImportMappingsCompanion({
    this.headerSignature = const Value.absent(),
    this.dateColumn = const Value.absent(),
    this.descriptionColumn = const Value.absent(),
    this.amountColumn = const Value.absent(),
    this.debitColumn = const Value.absent(),
    this.creditColumn = const Value.absent(),
    this.datePattern = const Value.absent(),
    this.expensesAreNegative = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportMappingsCompanion.insert({
    required String headerSignature,
    required String dateColumn,
    required String descriptionColumn,
    this.amountColumn = const Value.absent(),
    this.debitColumn = const Value.absent(),
    this.creditColumn = const Value.absent(),
    required String datePattern,
    this.expensesAreNegative = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : headerSignature = Value(headerSignature),
       dateColumn = Value(dateColumn),
       descriptionColumn = Value(descriptionColumn),
       datePattern = Value(datePattern),
       updatedAt = Value(updatedAt);
  static Insertable<ImportMappingRow> custom({
    Expression<String>? headerSignature,
    Expression<String>? dateColumn,
    Expression<String>? descriptionColumn,
    Expression<String>? amountColumn,
    Expression<String>? debitColumn,
    Expression<String>? creditColumn,
    Expression<String>? datePattern,
    Expression<bool>? expensesAreNegative,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (headerSignature != null) 'header_signature': headerSignature,
      if (dateColumn != null) 'date_column': dateColumn,
      if (descriptionColumn != null) 'description_column': descriptionColumn,
      if (amountColumn != null) 'amount_column': amountColumn,
      if (debitColumn != null) 'debit_column': debitColumn,
      if (creditColumn != null) 'credit_column': creditColumn,
      if (datePattern != null) 'date_pattern': datePattern,
      if (expensesAreNegative != null)
        'expenses_are_negative': expensesAreNegative,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportMappingsCompanion copyWith({
    Value<String>? headerSignature,
    Value<String>? dateColumn,
    Value<String>? descriptionColumn,
    Value<String?>? amountColumn,
    Value<String?>? debitColumn,
    Value<String?>? creditColumn,
    Value<String>? datePattern,
    Value<bool>? expensesAreNegative,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ImportMappingsCompanion(
      headerSignature: headerSignature ?? this.headerSignature,
      dateColumn: dateColumn ?? this.dateColumn,
      descriptionColumn: descriptionColumn ?? this.descriptionColumn,
      amountColumn: amountColumn ?? this.amountColumn,
      debitColumn: debitColumn ?? this.debitColumn,
      creditColumn: creditColumn ?? this.creditColumn,
      datePattern: datePattern ?? this.datePattern,
      expensesAreNegative: expensesAreNegative ?? this.expensesAreNegative,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (headerSignature.present) {
      map['header_signature'] = Variable<String>(headerSignature.value);
    }
    if (dateColumn.present) {
      map['date_column'] = Variable<String>(dateColumn.value);
    }
    if (descriptionColumn.present) {
      map['description_column'] = Variable<String>(descriptionColumn.value);
    }
    if (amountColumn.present) {
      map['amount_column'] = Variable<String>(amountColumn.value);
    }
    if (debitColumn.present) {
      map['debit_column'] = Variable<String>(debitColumn.value);
    }
    if (creditColumn.present) {
      map['credit_column'] = Variable<String>(creditColumn.value);
    }
    if (datePattern.present) {
      map['date_pattern'] = Variable<String>(datePattern.value);
    }
    if (expensesAreNegative.present) {
      map['expenses_are_negative'] = Variable<bool>(expensesAreNegative.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportMappingsCompanion(')
          ..write('headerSignature: $headerSignature, ')
          ..write('dateColumn: $dateColumn, ')
          ..write('descriptionColumn: $descriptionColumn, ')
          ..write('amountColumn: $amountColumn, ')
          ..write('debitColumn: $debitColumn, ')
          ..write('creditColumn: $creditColumn, ')
          ..write('datePattern: $datePattern, ')
          ..write('expensesAreNegative: $expensesAreNegative, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportBatchesTable extends ImportBatches
    with TableInfo<$ImportBatchesTable, ImportBatchRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportBatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedCountMeta = const VerificationMeta(
    'importedCount',
  );
  @override
  late final GeneratedColumn<int> importedCount = GeneratedColumn<int>(
    'imported_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _duplicateCountMeta = const VerificationMeta(
    'duplicateCount',
  );
  @override
  late final GeneratedColumn<int> duplicateCount = GeneratedColumn<int>(
    'duplicate_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rejectedCountMeta = const VerificationMeta(
    'rejectedCount',
  );
  @override
  late final GeneratedColumn<int> rejectedCount = GeneratedColumn<int>(
    'rejected_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fileName,
    importedAt,
    importedCount,
    duplicateCount,
    rejectedCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'import_batches';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportBatchRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    if (data.containsKey('imported_count')) {
      context.handle(
        _importedCountMeta,
        importedCount.isAcceptableOrUnknown(
          data['imported_count']!,
          _importedCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_importedCountMeta);
    }
    if (data.containsKey('duplicate_count')) {
      context.handle(
        _duplicateCountMeta,
        duplicateCount.isAcceptableOrUnknown(
          data['duplicate_count']!,
          _duplicateCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_duplicateCountMeta);
    }
    if (data.containsKey('rejected_count')) {
      context.handle(
        _rejectedCountMeta,
        rejectedCount.isAcceptableOrUnknown(
          data['rejected_count']!,
          _rejectedCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rejectedCountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportBatchRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportBatchRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
      importedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}imported_count'],
      )!,
      duplicateCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duplicate_count'],
      )!,
      rejectedCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rejected_count'],
      )!,
    );
  }

  @override
  $ImportBatchesTable createAlias(String alias) {
    return $ImportBatchesTable(attachedDatabase, alias);
  }
}

class ImportBatchRow extends DataClass implements Insertable<ImportBatchRow> {
  final String id;
  final String fileName;
  final DateTime importedAt;
  final int importedCount;
  final int duplicateCount;
  final int rejectedCount;
  const ImportBatchRow({
    required this.id,
    required this.fileName,
    required this.importedAt,
    required this.importedCount,
    required this.duplicateCount,
    required this.rejectedCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['file_name'] = Variable<String>(fileName);
    map['imported_at'] = Variable<DateTime>(importedAt);
    map['imported_count'] = Variable<int>(importedCount);
    map['duplicate_count'] = Variable<int>(duplicateCount);
    map['rejected_count'] = Variable<int>(rejectedCount);
    return map;
  }

  ImportBatchesCompanion toCompanion(bool nullToAbsent) {
    return ImportBatchesCompanion(
      id: Value(id),
      fileName: Value(fileName),
      importedAt: Value(importedAt),
      importedCount: Value(importedCount),
      duplicateCount: Value(duplicateCount),
      rejectedCount: Value(rejectedCount),
    );
  }

  factory ImportBatchRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportBatchRow(
      id: serializer.fromJson<String>(json['id']),
      fileName: serializer.fromJson<String>(json['fileName']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
      importedCount: serializer.fromJson<int>(json['importedCount']),
      duplicateCount: serializer.fromJson<int>(json['duplicateCount']),
      rejectedCount: serializer.fromJson<int>(json['rejectedCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fileName': serializer.toJson<String>(fileName),
      'importedAt': serializer.toJson<DateTime>(importedAt),
      'importedCount': serializer.toJson<int>(importedCount),
      'duplicateCount': serializer.toJson<int>(duplicateCount),
      'rejectedCount': serializer.toJson<int>(rejectedCount),
    };
  }

  ImportBatchRow copyWith({
    String? id,
    String? fileName,
    DateTime? importedAt,
    int? importedCount,
    int? duplicateCount,
    int? rejectedCount,
  }) => ImportBatchRow(
    id: id ?? this.id,
    fileName: fileName ?? this.fileName,
    importedAt: importedAt ?? this.importedAt,
    importedCount: importedCount ?? this.importedCount,
    duplicateCount: duplicateCount ?? this.duplicateCount,
    rejectedCount: rejectedCount ?? this.rejectedCount,
  );
  ImportBatchRow copyWithCompanion(ImportBatchesCompanion data) {
    return ImportBatchRow(
      id: data.id.present ? data.id.value : this.id,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
      importedCount: data.importedCount.present
          ? data.importedCount.value
          : this.importedCount,
      duplicateCount: data.duplicateCount.present
          ? data.duplicateCount.value
          : this.duplicateCount,
      rejectedCount: data.rejectedCount.present
          ? data.rejectedCount.value
          : this.rejectedCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportBatchRow(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('importedAt: $importedAt, ')
          ..write('importedCount: $importedCount, ')
          ..write('duplicateCount: $duplicateCount, ')
          ..write('rejectedCount: $rejectedCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fileName,
    importedAt,
    importedCount,
    duplicateCount,
    rejectedCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportBatchRow &&
          other.id == this.id &&
          other.fileName == this.fileName &&
          other.importedAt == this.importedAt &&
          other.importedCount == this.importedCount &&
          other.duplicateCount == this.duplicateCount &&
          other.rejectedCount == this.rejectedCount);
}

class ImportBatchesCompanion extends UpdateCompanion<ImportBatchRow> {
  final Value<String> id;
  final Value<String> fileName;
  final Value<DateTime> importedAt;
  final Value<int> importedCount;
  final Value<int> duplicateCount;
  final Value<int> rejectedCount;
  final Value<int> rowid;
  const ImportBatchesCompanion({
    this.id = const Value.absent(),
    this.fileName = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.importedCount = const Value.absent(),
    this.duplicateCount = const Value.absent(),
    this.rejectedCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportBatchesCompanion.insert({
    required String id,
    required String fileName,
    required DateTime importedAt,
    required int importedCount,
    required int duplicateCount,
    required int rejectedCount,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fileName = Value(fileName),
       importedAt = Value(importedAt),
       importedCount = Value(importedCount),
       duplicateCount = Value(duplicateCount),
       rejectedCount = Value(rejectedCount);
  static Insertable<ImportBatchRow> custom({
    Expression<String>? id,
    Expression<String>? fileName,
    Expression<DateTime>? importedAt,
    Expression<int>? importedCount,
    Expression<int>? duplicateCount,
    Expression<int>? rejectedCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fileName != null) 'file_name': fileName,
      if (importedAt != null) 'imported_at': importedAt,
      if (importedCount != null) 'imported_count': importedCount,
      if (duplicateCount != null) 'duplicate_count': duplicateCount,
      if (rejectedCount != null) 'rejected_count': rejectedCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportBatchesCompanion copyWith({
    Value<String>? id,
    Value<String>? fileName,
    Value<DateTime>? importedAt,
    Value<int>? importedCount,
    Value<int>? duplicateCount,
    Value<int>? rejectedCount,
    Value<int>? rowid,
  }) {
    return ImportBatchesCompanion(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      importedAt: importedAt ?? this.importedAt,
      importedCount: importedCount ?? this.importedCount,
      duplicateCount: duplicateCount ?? this.duplicateCount,
      rejectedCount: rejectedCount ?? this.rejectedCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (importedCount.present) {
      map['imported_count'] = Variable<int>(importedCount.value);
    }
    if (duplicateCount.present) {
      map['duplicate_count'] = Variable<int>(duplicateCount.value);
    }
    if (rejectedCount.present) {
      map['rejected_count'] = Variable<int>(rejectedCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportBatchesCompanion(')
          ..write('id: $id, ')
          ..write('fileName: $fileName, ')
          ..write('importedAt: $importedAt, ')
          ..write('importedCount: $importedCount, ')
          ..write('duplicateCount: $duplicateCount, ')
          ..write('rejectedCount: $rejectedCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$StudentFlowDatabase extends GeneratedDatabase {
  _$StudentFlowDatabase(QueryExecutor e) : super(e);
  $StudentFlowDatabaseManager get managers => $StudentFlowDatabaseManager(this);
  late final $LocalAccountsTable localAccounts = $LocalAccountsTable(this);
  late final $LocalTransactionsTable localTransactions =
      $LocalTransactionsTable(this);
  late final $CategoryCorrectionsTable categoryCorrections =
      $CategoryCorrectionsTable(this);
  late final $TransactionSplitsTable transactionSplits =
      $TransactionSplitsTable(this);
  late final $ImportMappingsTable importMappings = $ImportMappingsTable(this);
  late final $ImportBatchesTable importBatches = $ImportBatchesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localAccounts,
    localTransactions,
    categoryCorrections,
    transactionSplits,
    importMappings,
    importBatches,
  ];
}

typedef $$LocalAccountsTableCreateCompanionBuilder =
    LocalAccountsCompanion Function({
      required String id,
      required String name,
      required String institutionName,
      required String mask,
      required int accountType,
      required int currentBalanceCents,
      required int availableBalanceCents,
      Value<int> rowid,
    });
typedef $$LocalAccountsTableUpdateCompanionBuilder =
    LocalAccountsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> institutionName,
      Value<String> mask,
      Value<int> accountType,
      Value<int> currentBalanceCents,
      Value<int> availableBalanceCents,
      Value<int> rowid,
    });

final class $$LocalAccountsTableReferences
    extends
        BaseReferences<
          _$StudentFlowDatabase,
          $LocalAccountsTable,
          LocalAccountRow
        > {
  $$LocalAccountsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$LocalTransactionsTable, List<LocalTransactionRow>>
  _localTransactionsRefsTable(_$StudentFlowDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localTransactions,
        aliasName: 'local_accounts__id__local_transactions__account_id',
      );

  $$LocalTransactionsTableProcessedTableManager get localTransactionsRefs {
    final manager = $$LocalTransactionsTableTableManager(
      $_db,
      $_db.localTransactions,
    ).filter((f) => f.accountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalAccountsTableFilterComposer
    extends Composer<_$StudentFlowDatabase, $LocalAccountsTable> {
  $$LocalAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get institutionName => $composableBuilder(
    column: $table.institutionName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mask => $composableBuilder(
    column: $table.mask,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentBalanceCents => $composableBuilder(
    column: $table.currentBalanceCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get availableBalanceCents => $composableBuilder(
    column: $table.availableBalanceCents,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localTransactionsRefs(
    Expression<bool> Function($$LocalTransactionsTableFilterComposer f) f,
  ) {
    final $$LocalTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localTransactions,
      getReferencedColumn: (t) => t.accountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.localTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalAccountsTableOrderingComposer
    extends Composer<_$StudentFlowDatabase, $LocalAccountsTable> {
  $$LocalAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get institutionName => $composableBuilder(
    column: $table.institutionName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mask => $composableBuilder(
    column: $table.mask,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentBalanceCents => $composableBuilder(
    column: $table.currentBalanceCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get availableBalanceCents => $composableBuilder(
    column: $table.availableBalanceCents,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalAccountsTableAnnotationComposer
    extends Composer<_$StudentFlowDatabase, $LocalAccountsTable> {
  $$LocalAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get institutionName => $composableBuilder(
    column: $table.institutionName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mask =>
      $composableBuilder(column: $table.mask, builder: (column) => column);

  GeneratedColumn<int> get accountType => $composableBuilder(
    column: $table.accountType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentBalanceCents => $composableBuilder(
    column: $table.currentBalanceCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get availableBalanceCents => $composableBuilder(
    column: $table.availableBalanceCents,
    builder: (column) => column,
  );

  Expression<T> localTransactionsRefs<T extends Object>(
    Expression<T> Function($$LocalTransactionsTableAnnotationComposer a) f,
  ) {
    final $$LocalTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localTransactions,
          getReferencedColumn: (t) => t.accountId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalAccountsTableTableManager
    extends
        RootTableManager<
          _$StudentFlowDatabase,
          $LocalAccountsTable,
          LocalAccountRow,
          $$LocalAccountsTableFilterComposer,
          $$LocalAccountsTableOrderingComposer,
          $$LocalAccountsTableAnnotationComposer,
          $$LocalAccountsTableCreateCompanionBuilder,
          $$LocalAccountsTableUpdateCompanionBuilder,
          (LocalAccountRow, $$LocalAccountsTableReferences),
          LocalAccountRow,
          PrefetchHooks Function({bool localTransactionsRefs})
        > {
  $$LocalAccountsTableTableManager(
    _$StudentFlowDatabase db,
    $LocalAccountsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> institutionName = const Value.absent(),
                Value<String> mask = const Value.absent(),
                Value<int> accountType = const Value.absent(),
                Value<int> currentBalanceCents = const Value.absent(),
                Value<int> availableBalanceCents = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalAccountsCompanion(
                id: id,
                name: name,
                institutionName: institutionName,
                mask: mask,
                accountType: accountType,
                currentBalanceCents: currentBalanceCents,
                availableBalanceCents: availableBalanceCents,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String institutionName,
                required String mask,
                required int accountType,
                required int currentBalanceCents,
                required int availableBalanceCents,
                Value<int> rowid = const Value.absent(),
              }) => LocalAccountsCompanion.insert(
                id: id,
                name: name,
                institutionName: institutionName,
                mask: mask,
                accountType: accountType,
                currentBalanceCents: currentBalanceCents,
                availableBalanceCents: availableBalanceCents,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalAccountsTable, LocalAccountRow>(table),
                  $$LocalAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({localTransactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localTransactionsRefs) db.localTransactions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localTransactionsRefs)
                    await $_getPrefetchedData<
                      LocalAccountRow,
                      $LocalAccountsTable,
                      LocalTransactionRow
                    >(
                      currentTable: table,
                      referencedTable: $$LocalAccountsTableReferences
                          ._localTransactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LocalAccountsTableReferences(
                            db,
                            table,
                            p0,
                          ).localTransactionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.accountId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LocalAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$StudentFlowDatabase,
      $LocalAccountsTable,
      LocalAccountRow,
      $$LocalAccountsTableFilterComposer,
      $$LocalAccountsTableOrderingComposer,
      $$LocalAccountsTableAnnotationComposer,
      $$LocalAccountsTableCreateCompanionBuilder,
      $$LocalAccountsTableUpdateCompanionBuilder,
      (LocalAccountRow, $$LocalAccountsTableReferences),
      LocalAccountRow,
      PrefetchHooks Function({bool localTransactionsRefs})
    >;
typedef $$LocalTransactionsTableCreateCompanionBuilder =
    LocalTransactionsCompanion Function({
      required String id,
      required String accountId,
      required DateTime transactionDate,
      required String description,
      required int amountCents,
      required int category,
      required int transactionStatus,
      Value<String?> merchantName,
      Value<String?> providerTransactionId,
      Value<String?> parentTransactionId,
      Value<bool> isPossibleDuplicate,
      Value<String?> importFingerprint,
      Value<String?> importBatchId,
      Value<int> rowid,
    });
typedef $$LocalTransactionsTableUpdateCompanionBuilder =
    LocalTransactionsCompanion Function({
      Value<String> id,
      Value<String> accountId,
      Value<DateTime> transactionDate,
      Value<String> description,
      Value<int> amountCents,
      Value<int> category,
      Value<int> transactionStatus,
      Value<String?> merchantName,
      Value<String?> providerTransactionId,
      Value<String?> parentTransactionId,
      Value<bool> isPossibleDuplicate,
      Value<String?> importFingerprint,
      Value<String?> importBatchId,
      Value<int> rowid,
    });

final class $$LocalTransactionsTableReferences
    extends
        BaseReferences<
          _$StudentFlowDatabase,
          $LocalTransactionsTable,
          LocalTransactionRow
        > {
  $$LocalTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalAccountsTable _accountIdTable(_$StudentFlowDatabase db) => db
      .localAccounts
      .createAlias('local_transactions__account_id__local_accounts__id');

  $$LocalAccountsTableProcessedTableManager get accountId {
    final $_column = $_itemColumn<String>('account_id')!;

    final manager = $$LocalAccountsTableTableManager(
      $_db,
      $_db.localAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_accountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalTransactionsTableFilterComposer
    extends Composer<_$StudentFlowDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get transactionStatus => $composableBuilder(
    column: $table.transactionStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get providerTransactionId => $composableBuilder(
    column: $table.providerTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPossibleDuplicate => $composableBuilder(
    column: $table.isPossibleDuplicate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importFingerprint => $composableBuilder(
    column: $table.importFingerprint,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalAccountsTableFilterComposer get accountId {
    final $$LocalAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableFilterComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalTransactionsTableOrderingComposer
    extends Composer<_$StudentFlowDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get transactionStatus => $composableBuilder(
    column: $table.transactionStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get providerTransactionId => $composableBuilder(
    column: $table.providerTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPossibleDuplicate => $composableBuilder(
    column: $table.isPossibleDuplicate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importFingerprint => $composableBuilder(
    column: $table.importFingerprint,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalAccountsTableOrderingComposer get accountId {
    final $$LocalAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalTransactionsTableAnnotationComposer
    extends Composer<_$StudentFlowDatabase, $LocalTransactionsTable> {
  $$LocalTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get transactionStatus => $composableBuilder(
    column: $table.transactionStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get providerTransactionId => $composableBuilder(
    column: $table.providerTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isPossibleDuplicate => $composableBuilder(
    column: $table.isPossibleDuplicate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importFingerprint => $composableBuilder(
    column: $table.importFingerprint,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importBatchId => $composableBuilder(
    column: $table.importBatchId,
    builder: (column) => column,
  );

  $$LocalAccountsTableAnnotationComposer get accountId {
    final $$LocalAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.accountId,
      referencedTable: $db.localAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.localAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalTransactionsTableTableManager
    extends
        RootTableManager<
          _$StudentFlowDatabase,
          $LocalTransactionsTable,
          LocalTransactionRow,
          $$LocalTransactionsTableFilterComposer,
          $$LocalTransactionsTableOrderingComposer,
          $$LocalTransactionsTableAnnotationComposer,
          $$LocalTransactionsTableCreateCompanionBuilder,
          $$LocalTransactionsTableUpdateCompanionBuilder,
          (LocalTransactionRow, $$LocalTransactionsTableReferences),
          LocalTransactionRow,
          PrefetchHooks Function({bool accountId})
        > {
  $$LocalTransactionsTableTableManager(
    _$StudentFlowDatabase db,
    $LocalTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> accountId = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<int> transactionStatus = const Value.absent(),
                Value<String?> merchantName = const Value.absent(),
                Value<String?> providerTransactionId = const Value.absent(),
                Value<String?> parentTransactionId = const Value.absent(),
                Value<bool> isPossibleDuplicate = const Value.absent(),
                Value<String?> importFingerprint = const Value.absent(),
                Value<String?> importBatchId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTransactionsCompanion(
                id: id,
                accountId: accountId,
                transactionDate: transactionDate,
                description: description,
                amountCents: amountCents,
                category: category,
                transactionStatus: transactionStatus,
                merchantName: merchantName,
                providerTransactionId: providerTransactionId,
                parentTransactionId: parentTransactionId,
                isPossibleDuplicate: isPossibleDuplicate,
                importFingerprint: importFingerprint,
                importBatchId: importBatchId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String accountId,
                required DateTime transactionDate,
                required String description,
                required int amountCents,
                required int category,
                required int transactionStatus,
                Value<String?> merchantName = const Value.absent(),
                Value<String?> providerTransactionId = const Value.absent(),
                Value<String?> parentTransactionId = const Value.absent(),
                Value<bool> isPossibleDuplicate = const Value.absent(),
                Value<String?> importFingerprint = const Value.absent(),
                Value<String?> importBatchId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalTransactionsCompanion.insert(
                id: id,
                accountId: accountId,
                transactionDate: transactionDate,
                description: description,
                amountCents: amountCents,
                category: category,
                transactionStatus: transactionStatus,
                merchantName: merchantName,
                providerTransactionId: providerTransactionId,
                parentTransactionId: parentTransactionId,
                isPossibleDuplicate: isPossibleDuplicate,
                importFingerprint: importFingerprint,
                importBatchId: importBatchId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LocalTransactionsTable, LocalTransactionRow>(
                    table,
                  ),
                  $$LocalTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({accountId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (accountId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.accountId,
                        referencedTable: $$LocalTransactionsTableReferences
                            ._accountIdTable(db),
                        referencedColumn: $$LocalTransactionsTableReferences
                            ._accountIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$StudentFlowDatabase,
      $LocalTransactionsTable,
      LocalTransactionRow,
      $$LocalTransactionsTableFilterComposer,
      $$LocalTransactionsTableOrderingComposer,
      $$LocalTransactionsTableAnnotationComposer,
      $$LocalTransactionsTableCreateCompanionBuilder,
      $$LocalTransactionsTableUpdateCompanionBuilder,
      (LocalTransactionRow, $$LocalTransactionsTableReferences),
      LocalTransactionRow,
      PrefetchHooks Function({bool accountId})
    >;
typedef $$CategoryCorrectionsTableCreateCompanionBuilder =
    CategoryCorrectionsCompanion Function({
      required String transactionId,
      required int category,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CategoryCorrectionsTableUpdateCompanionBuilder =
    CategoryCorrectionsCompanion Function({
      Value<String> transactionId,
      Value<int> category,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CategoryCorrectionsTableFilterComposer
    extends Composer<_$StudentFlowDatabase, $CategoryCorrectionsTable> {
  $$CategoryCorrectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CategoryCorrectionsTableOrderingComposer
    extends Composer<_$StudentFlowDatabase, $CategoryCorrectionsTable> {
  $$CategoryCorrectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryCorrectionsTableAnnotationComposer
    extends Composer<_$StudentFlowDatabase, $CategoryCorrectionsTable> {
  $$CategoryCorrectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CategoryCorrectionsTableTableManager
    extends
        RootTableManager<
          _$StudentFlowDatabase,
          $CategoryCorrectionsTable,
          CategoryCorrectionRow,
          $$CategoryCorrectionsTableFilterComposer,
          $$CategoryCorrectionsTableOrderingComposer,
          $$CategoryCorrectionsTableAnnotationComposer,
          $$CategoryCorrectionsTableCreateCompanionBuilder,
          $$CategoryCorrectionsTableUpdateCompanionBuilder,
          (
            CategoryCorrectionRow,
            BaseReferences<
              _$StudentFlowDatabase,
              $CategoryCorrectionsTable,
              CategoryCorrectionRow
            >,
          ),
          CategoryCorrectionRow,
          PrefetchHooks Function()
        > {
  $$CategoryCorrectionsTableTableManager(
    _$StudentFlowDatabase db,
    $CategoryCorrectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryCorrectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryCorrectionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CategoryCorrectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> transactionId = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoryCorrectionsCompanion(
                transactionId: transactionId,
                category: category,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String transactionId,
                required int category,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CategoryCorrectionsCompanion.insert(
                transactionId: transactionId,
                category: category,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoryCorrectionsTable, CategoryCorrectionRow>(
                    table,
                  ),
                  BaseReferences<
                    _$StudentFlowDatabase,
                    $CategoryCorrectionsTable,
                    CategoryCorrectionRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CategoryCorrectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$StudentFlowDatabase,
      $CategoryCorrectionsTable,
      CategoryCorrectionRow,
      $$CategoryCorrectionsTableFilterComposer,
      $$CategoryCorrectionsTableOrderingComposer,
      $$CategoryCorrectionsTableAnnotationComposer,
      $$CategoryCorrectionsTableCreateCompanionBuilder,
      $$CategoryCorrectionsTableUpdateCompanionBuilder,
      (
        CategoryCorrectionRow,
        BaseReferences<
          _$StudentFlowDatabase,
          $CategoryCorrectionsTable,
          CategoryCorrectionRow
        >,
      ),
      CategoryCorrectionRow,
      PrefetchHooks Function()
    >;
typedef $$TransactionSplitsTableCreateCompanionBuilder =
    TransactionSplitsCompanion Function({
      required String id,
      required String parentTransactionId,
      required String description,
      required int amountCents,
      required int category,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$TransactionSplitsTableUpdateCompanionBuilder =
    TransactionSplitsCompanion Function({
      Value<String> id,
      Value<String> parentTransactionId,
      Value<String> description,
      Value<int> amountCents,
      Value<int> category,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$TransactionSplitsTableFilterComposer
    extends Composer<_$StudentFlowDatabase, $TransactionSplitsTable> {
  $$TransactionSplitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionSplitsTableOrderingComposer
    extends Composer<_$StudentFlowDatabase, $TransactionSplitsTable> {
  $$TransactionSplitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionSplitsTableAnnotationComposer
    extends Composer<_$StudentFlowDatabase, $TransactionSplitsTable> {
  $$TransactionSplitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get parentTransactionId => $composableBuilder(
    column: $table.parentTransactionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TransactionSplitsTableTableManager
    extends
        RootTableManager<
          _$StudentFlowDatabase,
          $TransactionSplitsTable,
          TransactionSplitRow,
          $$TransactionSplitsTableFilterComposer,
          $$TransactionSplitsTableOrderingComposer,
          $$TransactionSplitsTableAnnotationComposer,
          $$TransactionSplitsTableCreateCompanionBuilder,
          $$TransactionSplitsTableUpdateCompanionBuilder,
          (
            TransactionSplitRow,
            BaseReferences<
              _$StudentFlowDatabase,
              $TransactionSplitsTable,
              TransactionSplitRow
            >,
          ),
          TransactionSplitRow,
          PrefetchHooks Function()
        > {
  $$TransactionSplitsTableTableManager(
    _$StudentFlowDatabase db,
    $TransactionSplitsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionSplitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionSplitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionSplitsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> parentTransactionId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> amountCents = const Value.absent(),
                Value<int> category = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionSplitsCompanion(
                id: id,
                parentTransactionId: parentTransactionId,
                description: description,
                amountCents: amountCents,
                category: category,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String parentTransactionId,
                required String description,
                required int amountCents,
                required int category,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TransactionSplitsCompanion.insert(
                id: id,
                parentTransactionId: parentTransactionId,
                description: description,
                amountCents: amountCents,
                category: category,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionSplitsTable, TransactionSplitRow>(
                    table,
                  ),
                  BaseReferences<
                    _$StudentFlowDatabase,
                    $TransactionSplitsTable,
                    TransactionSplitRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionSplitsTableProcessedTableManager =
    ProcessedTableManager<
      _$StudentFlowDatabase,
      $TransactionSplitsTable,
      TransactionSplitRow,
      $$TransactionSplitsTableFilterComposer,
      $$TransactionSplitsTableOrderingComposer,
      $$TransactionSplitsTableAnnotationComposer,
      $$TransactionSplitsTableCreateCompanionBuilder,
      $$TransactionSplitsTableUpdateCompanionBuilder,
      (
        TransactionSplitRow,
        BaseReferences<
          _$StudentFlowDatabase,
          $TransactionSplitsTable,
          TransactionSplitRow
        >,
      ),
      TransactionSplitRow,
      PrefetchHooks Function()
    >;
typedef $$ImportMappingsTableCreateCompanionBuilder =
    ImportMappingsCompanion Function({
      required String headerSignature,
      required String dateColumn,
      required String descriptionColumn,
      Value<String?> amountColumn,
      Value<String?> debitColumn,
      Value<String?> creditColumn,
      required String datePattern,
      Value<bool> expensesAreNegative,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ImportMappingsTableUpdateCompanionBuilder =
    ImportMappingsCompanion Function({
      Value<String> headerSignature,
      Value<String> dateColumn,
      Value<String> descriptionColumn,
      Value<String?> amountColumn,
      Value<String?> debitColumn,
      Value<String?> creditColumn,
      Value<String> datePattern,
      Value<bool> expensesAreNegative,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ImportMappingsTableFilterComposer
    extends Composer<_$StudentFlowDatabase, $ImportMappingsTable> {
  $$ImportMappingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get headerSignature => $composableBuilder(
    column: $table.headerSignature,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateColumn => $composableBuilder(
    column: $table.dateColumn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descriptionColumn => $composableBuilder(
    column: $table.descriptionColumn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amountColumn => $composableBuilder(
    column: $table.amountColumn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get debitColumn => $composableBuilder(
    column: $table.debitColumn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creditColumn => $composableBuilder(
    column: $table.creditColumn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get datePattern => $composableBuilder(
    column: $table.datePattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get expensesAreNegative => $composableBuilder(
    column: $table.expensesAreNegative,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportMappingsTableOrderingComposer
    extends Composer<_$StudentFlowDatabase, $ImportMappingsTable> {
  $$ImportMappingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get headerSignature => $composableBuilder(
    column: $table.headerSignature,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateColumn => $composableBuilder(
    column: $table.dateColumn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descriptionColumn => $composableBuilder(
    column: $table.descriptionColumn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amountColumn => $composableBuilder(
    column: $table.amountColumn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get debitColumn => $composableBuilder(
    column: $table.debitColumn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creditColumn => $composableBuilder(
    column: $table.creditColumn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get datePattern => $composableBuilder(
    column: $table.datePattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get expensesAreNegative => $composableBuilder(
    column: $table.expensesAreNegative,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportMappingsTableAnnotationComposer
    extends Composer<_$StudentFlowDatabase, $ImportMappingsTable> {
  $$ImportMappingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get headerSignature => $composableBuilder(
    column: $table.headerSignature,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dateColumn => $composableBuilder(
    column: $table.dateColumn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get descriptionColumn => $composableBuilder(
    column: $table.descriptionColumn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get amountColumn => $composableBuilder(
    column: $table.amountColumn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get debitColumn => $composableBuilder(
    column: $table.debitColumn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get creditColumn => $composableBuilder(
    column: $table.creditColumn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get datePattern => $composableBuilder(
    column: $table.datePattern,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get expensesAreNegative => $composableBuilder(
    column: $table.expensesAreNegative,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ImportMappingsTableTableManager
    extends
        RootTableManager<
          _$StudentFlowDatabase,
          $ImportMappingsTable,
          ImportMappingRow,
          $$ImportMappingsTableFilterComposer,
          $$ImportMappingsTableOrderingComposer,
          $$ImportMappingsTableAnnotationComposer,
          $$ImportMappingsTableCreateCompanionBuilder,
          $$ImportMappingsTableUpdateCompanionBuilder,
          (
            ImportMappingRow,
            BaseReferences<
              _$StudentFlowDatabase,
              $ImportMappingsTable,
              ImportMappingRow
            >,
          ),
          ImportMappingRow,
          PrefetchHooks Function()
        > {
  $$ImportMappingsTableTableManager(
    _$StudentFlowDatabase db,
    $ImportMappingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportMappingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportMappingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportMappingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> headerSignature = const Value.absent(),
                Value<String> dateColumn = const Value.absent(),
                Value<String> descriptionColumn = const Value.absent(),
                Value<String?> amountColumn = const Value.absent(),
                Value<String?> debitColumn = const Value.absent(),
                Value<String?> creditColumn = const Value.absent(),
                Value<String> datePattern = const Value.absent(),
                Value<bool> expensesAreNegative = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportMappingsCompanion(
                headerSignature: headerSignature,
                dateColumn: dateColumn,
                descriptionColumn: descriptionColumn,
                amountColumn: amountColumn,
                debitColumn: debitColumn,
                creditColumn: creditColumn,
                datePattern: datePattern,
                expensesAreNegative: expensesAreNegative,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String headerSignature,
                required String dateColumn,
                required String descriptionColumn,
                Value<String?> amountColumn = const Value.absent(),
                Value<String?> debitColumn = const Value.absent(),
                Value<String?> creditColumn = const Value.absent(),
                required String datePattern,
                Value<bool> expensesAreNegative = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ImportMappingsCompanion.insert(
                headerSignature: headerSignature,
                dateColumn: dateColumn,
                descriptionColumn: descriptionColumn,
                amountColumn: amountColumn,
                debitColumn: debitColumn,
                creditColumn: creditColumn,
                datePattern: datePattern,
                expensesAreNegative: expensesAreNegative,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ImportMappingsTable, ImportMappingRow>(table),
                  BaseReferences<
                    _$StudentFlowDatabase,
                    $ImportMappingsTable,
                    ImportMappingRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImportMappingsTableProcessedTableManager =
    ProcessedTableManager<
      _$StudentFlowDatabase,
      $ImportMappingsTable,
      ImportMappingRow,
      $$ImportMappingsTableFilterComposer,
      $$ImportMappingsTableOrderingComposer,
      $$ImportMappingsTableAnnotationComposer,
      $$ImportMappingsTableCreateCompanionBuilder,
      $$ImportMappingsTableUpdateCompanionBuilder,
      (
        ImportMappingRow,
        BaseReferences<
          _$StudentFlowDatabase,
          $ImportMappingsTable,
          ImportMappingRow
        >,
      ),
      ImportMappingRow,
      PrefetchHooks Function()
    >;
typedef $$ImportBatchesTableCreateCompanionBuilder =
    ImportBatchesCompanion Function({
      required String id,
      required String fileName,
      required DateTime importedAt,
      required int importedCount,
      required int duplicateCount,
      required int rejectedCount,
      Value<int> rowid,
    });
typedef $$ImportBatchesTableUpdateCompanionBuilder =
    ImportBatchesCompanion Function({
      Value<String> id,
      Value<String> fileName,
      Value<DateTime> importedAt,
      Value<int> importedCount,
      Value<int> duplicateCount,
      Value<int> rejectedCount,
      Value<int> rowid,
    });

class $$ImportBatchesTableFilterComposer
    extends Composer<_$StudentFlowDatabase, $ImportBatchesTable> {
  $$ImportBatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get importedCount => $composableBuilder(
    column: $table.importedCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duplicateCount => $composableBuilder(
    column: $table.duplicateCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rejectedCount => $composableBuilder(
    column: $table.rejectedCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportBatchesTableOrderingComposer
    extends Composer<_$StudentFlowDatabase, $ImportBatchesTable> {
  $$ImportBatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get importedCount => $composableBuilder(
    column: $table.importedCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duplicateCount => $composableBuilder(
    column: $table.duplicateCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rejectedCount => $composableBuilder(
    column: $table.rejectedCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportBatchesTableAnnotationComposer
    extends Composer<_$StudentFlowDatabase, $ImportBatchesTable> {
  $$ImportBatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get importedCount => $composableBuilder(
    column: $table.importedCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duplicateCount => $composableBuilder(
    column: $table.duplicateCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rejectedCount => $composableBuilder(
    column: $table.rejectedCount,
    builder: (column) => column,
  );
}

class $$ImportBatchesTableTableManager
    extends
        RootTableManager<
          _$StudentFlowDatabase,
          $ImportBatchesTable,
          ImportBatchRow,
          $$ImportBatchesTableFilterComposer,
          $$ImportBatchesTableOrderingComposer,
          $$ImportBatchesTableAnnotationComposer,
          $$ImportBatchesTableCreateCompanionBuilder,
          $$ImportBatchesTableUpdateCompanionBuilder,
          (
            ImportBatchRow,
            BaseReferences<
              _$StudentFlowDatabase,
              $ImportBatchesTable,
              ImportBatchRow
            >,
          ),
          ImportBatchRow,
          PrefetchHooks Function()
        > {
  $$ImportBatchesTableTableManager(
    _$StudentFlowDatabase db,
    $ImportBatchesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportBatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportBatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportBatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> importedCount = const Value.absent(),
                Value<int> duplicateCount = const Value.absent(),
                Value<int> rejectedCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportBatchesCompanion(
                id: id,
                fileName: fileName,
                importedAt: importedAt,
                importedCount: importedCount,
                duplicateCount: duplicateCount,
                rejectedCount: rejectedCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fileName,
                required DateTime importedAt,
                required int importedCount,
                required int duplicateCount,
                required int rejectedCount,
                Value<int> rowid = const Value.absent(),
              }) => ImportBatchesCompanion.insert(
                id: id,
                fileName: fileName,
                importedAt: importedAt,
                importedCount: importedCount,
                duplicateCount: duplicateCount,
                rejectedCount: rejectedCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ImportBatchesTable, ImportBatchRow>(table),
                  BaseReferences<
                    _$StudentFlowDatabase,
                    $ImportBatchesTable,
                    ImportBatchRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImportBatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$StudentFlowDatabase,
      $ImportBatchesTable,
      ImportBatchRow,
      $$ImportBatchesTableFilterComposer,
      $$ImportBatchesTableOrderingComposer,
      $$ImportBatchesTableAnnotationComposer,
      $$ImportBatchesTableCreateCompanionBuilder,
      $$ImportBatchesTableUpdateCompanionBuilder,
      (
        ImportBatchRow,
        BaseReferences<
          _$StudentFlowDatabase,
          $ImportBatchesTable,
          ImportBatchRow
        >,
      ),
      ImportBatchRow,
      PrefetchHooks Function()
    >;

class $StudentFlowDatabaseManager {
  final _$StudentFlowDatabase _db;
  $StudentFlowDatabaseManager(this._db);
  $$LocalAccountsTableTableManager get localAccounts =>
      $$LocalAccountsTableTableManager(_db, _db.localAccounts);
  $$LocalTransactionsTableTableManager get localTransactions =>
      $$LocalTransactionsTableTableManager(_db, _db.localTransactions);
  $$CategoryCorrectionsTableTableManager get categoryCorrections =>
      $$CategoryCorrectionsTableTableManager(_db, _db.categoryCorrections);
  $$TransactionSplitsTableTableManager get transactionSplits =>
      $$TransactionSplitsTableTableManager(_db, _db.transactionSplits);
  $$ImportMappingsTableTableManager get importMappings =>
      $$ImportMappingsTableTableManager(_db, _db.importMappings);
  $$ImportBatchesTableTableManager get importBatches =>
      $$ImportBatchesTableTableManager(_db, _db.importBatches);
}

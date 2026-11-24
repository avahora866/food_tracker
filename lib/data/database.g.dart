// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $IngredientsTable extends Ingredients
    with TableInfo<$IngredientsTable, Ingredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Unit, String> unit =
      GeneratedColumn<String>(
        'unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Unit>($IngredientsTable.$converterunit);
  static const VerificationMeta _refAmountMeta = const VerificationMeta(
    'refAmount',
  );
  @override
  late final GeneratedColumn<double> refAmount = GeneratedColumn<double>(
    'ref_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refKcalMeta = const VerificationMeta(
    'refKcal',
  );
  @override
  late final GeneratedColumn<double> refKcal = GeneratedColumn<double>(
    'ref_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refProteinMeta = const VerificationMeta(
    'refProtein',
  );
  @override
  late final GeneratedColumn<double> refProtein = GeneratedColumn<double>(
    'ref_protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    unit,
    refAmount,
    refKcal,
    refProtein,
    archived,
    lastUsedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ingredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('ref_amount')) {
      context.handle(
        _refAmountMeta,
        refAmount.isAcceptableOrUnknown(data['ref_amount']!, _refAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_refAmountMeta);
    }
    if (data.containsKey('ref_kcal')) {
      context.handle(
        _refKcalMeta,
        refKcal.isAcceptableOrUnknown(data['ref_kcal']!, _refKcalMeta),
      );
    } else if (isInserting) {
      context.missing(_refKcalMeta);
    }
    if (data.containsKey('ref_protein')) {
      context.handle(
        _refProteinMeta,
        refProtein.isAcceptableOrUnknown(data['ref_protein']!, _refProteinMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ingredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ingredient(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: $IngredientsTable.$converterunit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unit'],
        )!,
      ),
      refAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_amount'],
      )!,
      refKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_kcal'],
      )!,
      refProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_protein'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
    );
  }

  @override
  $IngredientsTable createAlias(String alias) {
    return $IngredientsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Unit, String, String> $converterunit =
      const EnumNameConverter<Unit>(Unit.values);
}

class Ingredient extends DataClass implements Insertable<Ingredient> {
  final int id;
  final String name;
  final Unit unit;
  final double refAmount;
  final double refKcal;
  final double refProtein;
  final bool archived;

  /// Recents-first ordering when an ingredient is logged on its own.
  final DateTime? lastUsedAt;
  const Ingredient({
    required this.id,
    required this.name,
    required this.unit,
    required this.refAmount,
    required this.refKcal,
    required this.refProtein,
    required this.archived,
    this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['unit'] = Variable<String>(
        $IngredientsTable.$converterunit.toSql(unit),
      );
    }
    map['ref_amount'] = Variable<double>(refAmount);
    map['ref_kcal'] = Variable<double>(refKcal);
    map['ref_protein'] = Variable<double>(refProtein);
    map['archived'] = Variable<bool>(archived);
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    return map;
  }

  IngredientsCompanion toCompanion(bool nullToAbsent) {
    return IngredientsCompanion(
      id: Value(id),
      name: Value(name),
      unit: Value(unit),
      refAmount: Value(refAmount),
      refKcal: Value(refKcal),
      refProtein: Value(refProtein),
      archived: Value(archived),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
    );
  }

  factory Ingredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ingredient(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      unit: $IngredientsTable.$converterunit.fromJson(
        serializer.fromJson<String>(json['unit']),
      ),
      refAmount: serializer.fromJson<double>(json['refAmount']),
      refKcal: serializer.fromJson<double>(json['refKcal']),
      refProtein: serializer.fromJson<double>(json['refProtein']),
      archived: serializer.fromJson<bool>(json['archived']),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(
        $IngredientsTable.$converterunit.toJson(unit),
      ),
      'refAmount': serializer.toJson<double>(refAmount),
      'refKcal': serializer.toJson<double>(refKcal),
      'refProtein': serializer.toJson<double>(refProtein),
      'archived': serializer.toJson<bool>(archived),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
    };
  }

  Ingredient copyWith({
    int? id,
    String? name,
    Unit? unit,
    double? refAmount,
    double? refKcal,
    double? refProtein,
    bool? archived,
    Value<DateTime?> lastUsedAt = const Value.absent(),
  }) => Ingredient(
    id: id ?? this.id,
    name: name ?? this.name,
    unit: unit ?? this.unit,
    refAmount: refAmount ?? this.refAmount,
    refKcal: refKcal ?? this.refKcal,
    refProtein: refProtein ?? this.refProtein,
    archived: archived ?? this.archived,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
  );
  Ingredient copyWithCompanion(IngredientsCompanion data) {
    return Ingredient(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      refAmount: data.refAmount.present ? data.refAmount.value : this.refAmount,
      refKcal: data.refKcal.present ? data.refKcal.value : this.refKcal,
      refProtein: data.refProtein.present
          ? data.refProtein.value
          : this.refProtein,
      archived: data.archived.present ? data.archived.value : this.archived,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ingredient(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('refAmount: $refAmount, ')
          ..write('refKcal: $refKcal, ')
          ..write('refProtein: $refProtein, ')
          ..write('archived: $archived, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    unit,
    refAmount,
    refKcal,
    refProtein,
    archived,
    lastUsedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ingredient &&
          other.id == this.id &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.refAmount == this.refAmount &&
          other.refKcal == this.refKcal &&
          other.refProtein == this.refProtein &&
          other.archived == this.archived &&
          other.lastUsedAt == this.lastUsedAt);
}

class IngredientsCompanion extends UpdateCompanion<Ingredient> {
  final Value<int> id;
  final Value<String> name;
  final Value<Unit> unit;
  final Value<double> refAmount;
  final Value<double> refKcal;
  final Value<double> refProtein;
  final Value<bool> archived;
  final Value<DateTime?> lastUsedAt;
  const IngredientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.refAmount = const Value.absent(),
    this.refKcal = const Value.absent(),
    this.refProtein = const Value.absent(),
    this.archived = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
  });
  IngredientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Unit unit,
    required double refAmount,
    required double refKcal,
    this.refProtein = const Value.absent(),
    this.archived = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
  }) : name = Value(name),
       unit = Value(unit),
       refAmount = Value(refAmount),
       refKcal = Value(refKcal);
  static Insertable<Ingredient> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<double>? refAmount,
    Expression<double>? refKcal,
    Expression<double>? refProtein,
    Expression<bool>? archived,
    Expression<DateTime>? lastUsedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (refAmount != null) 'ref_amount': refAmount,
      if (refKcal != null) 'ref_kcal': refKcal,
      if (refProtein != null) 'ref_protein': refProtein,
      if (archived != null) 'archived': archived,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
    });
  }

  IngredientsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Unit>? unit,
    Value<double>? refAmount,
    Value<double>? refKcal,
    Value<double>? refProtein,
    Value<bool>? archived,
    Value<DateTime?>? lastUsedAt,
  }) {
    return IngredientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      refAmount: refAmount ?? this.refAmount,
      refKcal: refKcal ?? this.refKcal,
      refProtein: refProtein ?? this.refProtein,
      archived: archived ?? this.archived,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(
        $IngredientsTable.$converterunit.toSql(unit.value),
      );
    }
    if (refAmount.present) {
      map['ref_amount'] = Variable<double>(refAmount.value);
    }
    if (refKcal.present) {
      map['ref_kcal'] = Variable<double>(refKcal.value);
    }
    if (refProtein.present) {
      map['ref_protein'] = Variable<double>(refProtein.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('refAmount: $refAmount, ')
          ..write('refKcal: $refKcal, ')
          ..write('refProtein: $refProtein, ')
          ..write('archived: $archived, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Slot?, String> defaultSlot =
      GeneratedColumn<String>(
        'default_slot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Slot?>($RecipesTable.$converterdefaultSlotn);
  static const VerificationMeta _lastUsedAtMeta = const VerificationMeta(
    'lastUsedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastUsedAt = GeneratedColumn<DateTime>(
    'last_used_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, defaultSlot, lastUsedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('last_used_at')) {
      context.handle(
        _lastUsedAtMeta,
        lastUsedAt.isAcceptableOrUnknown(
          data['last_used_at']!,
          _lastUsedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      defaultSlot: $RecipesTable.$converterdefaultSlotn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}default_slot'],
        ),
      ),
      lastUsedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_used_at'],
      ),
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Slot, String, String> $converterdefaultSlot =
      const EnumNameConverter<Slot>(Slot.values);
  static JsonTypeConverter2<Slot?, String?, String?> $converterdefaultSlotn =
      JsonTypeConverter2.asNullable($converterdefaultSlot);
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String name;
  final Slot? defaultSlot;
  final DateTime? lastUsedAt;
  const Recipe({
    required this.id,
    required this.name,
    this.defaultSlot,
    this.lastUsedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || defaultSlot != null) {
      map['default_slot'] = Variable<String>(
        $RecipesTable.$converterdefaultSlotn.toSql(defaultSlot),
      );
    }
    if (!nullToAbsent || lastUsedAt != null) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt);
    }
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      name: Value(name),
      defaultSlot: defaultSlot == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultSlot),
      lastUsedAt: lastUsedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUsedAt),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      defaultSlot: $RecipesTable.$converterdefaultSlotn.fromJson(
        serializer.fromJson<String?>(json['defaultSlot']),
      ),
      lastUsedAt: serializer.fromJson<DateTime?>(json['lastUsedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'defaultSlot': serializer.toJson<String?>(
        $RecipesTable.$converterdefaultSlotn.toJson(defaultSlot),
      ),
      'lastUsedAt': serializer.toJson<DateTime?>(lastUsedAt),
    };
  }

  Recipe copyWith({
    int? id,
    String? name,
    Value<Slot?> defaultSlot = const Value.absent(),
    Value<DateTime?> lastUsedAt = const Value.absent(),
  }) => Recipe(
    id: id ?? this.id,
    name: name ?? this.name,
    defaultSlot: defaultSlot.present ? defaultSlot.value : this.defaultSlot,
    lastUsedAt: lastUsedAt.present ? lastUsedAt.value : this.lastUsedAt,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      defaultSlot: data.defaultSlot.present
          ? data.defaultSlot.value
          : this.defaultSlot,
      lastUsedAt: data.lastUsedAt.present
          ? data.lastUsedAt.value
          : this.lastUsedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultSlot: $defaultSlot, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, defaultSlot, lastUsedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.name == this.name &&
          other.defaultSlot == this.defaultSlot &&
          other.lastUsedAt == this.lastUsedAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> name;
  final Value<Slot?> defaultSlot;
  final Value<DateTime?> lastUsedAt;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultSlot = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.defaultSlot = const Value.absent(),
    this.lastUsedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? defaultSlot,
    Expression<DateTime>? lastUsedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (defaultSlot != null) 'default_slot': defaultSlot,
      if (lastUsedAt != null) 'last_used_at': lastUsedAt,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Slot?>? defaultSlot,
    Value<DateTime?>? lastUsedAt,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      defaultSlot: defaultSlot ?? this.defaultSlot,
      lastUsedAt: lastUsedAt ?? this.lastUsedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (defaultSlot.present) {
      map['default_slot'] = Variable<String>(
        $RecipesTable.$converterdefaultSlotn.toSql(defaultSlot.value),
      );
    }
    if (lastUsedAt.present) {
      map['last_used_at'] = Variable<DateTime>(lastUsedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('defaultSlot: $defaultSlot, ')
          ..write('lastUsedAt: $lastUsedAt')
          ..write(')'))
        .toString();
  }
}

class $RecipeLinesTable extends RecipeLines
    with TableInfo<$RecipeLinesTable, RecipeLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id)',
    ),
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, recipeId, ingredientId, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
    );
  }

  @override
  $RecipeLinesTable createAlias(String alias) {
    return $RecipeLinesTable(attachedDatabase, alias);
  }
}

class RecipeLine extends DataClass implements Insertable<RecipeLine> {
  final int id;
  final int recipeId;
  final int ingredientId;
  final double amount;
  const RecipeLine({
    required this.id,
    required this.recipeId,
    required this.ingredientId,
    required this.amount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['recipe_id'] = Variable<int>(recipeId);
    map['ingredient_id'] = Variable<int>(ingredientId);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  RecipeLinesCompanion toCompanion(bool nullToAbsent) {
    return RecipeLinesCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      ingredientId: Value(ingredientId),
      amount: Value(amount),
    );
  }

  factory RecipeLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeLine(
      id: serializer.fromJson<int>(json['id']),
      recipeId: serializer.fromJson<int>(json['recipeId']),
      ingredientId: serializer.fromJson<int>(json['ingredientId']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recipeId': serializer.toJson<int>(recipeId),
      'ingredientId': serializer.toJson<int>(ingredientId),
      'amount': serializer.toJson<double>(amount),
    };
  }

  RecipeLine copyWith({
    int? id,
    int? recipeId,
    int? ingredientId,
    double? amount,
  }) => RecipeLine(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    ingredientId: ingredientId ?? this.ingredientId,
    amount: amount ?? this.amount,
  );
  RecipeLine copyWithCompanion(RecipeLinesCompanion data) {
    return RecipeLine(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeLine(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recipeId, ingredientId, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeLine &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.ingredientId == this.ingredientId &&
          other.amount == this.amount);
}

class RecipeLinesCompanion extends UpdateCompanion<RecipeLine> {
  final Value<int> id;
  final Value<int> recipeId;
  final Value<int> ingredientId;
  final Value<double> amount;
  const RecipeLinesCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.amount = const Value.absent(),
  });
  RecipeLinesCompanion.insert({
    this.id = const Value.absent(),
    required int recipeId,
    required int ingredientId,
    required double amount,
  }) : recipeId = Value(recipeId),
       ingredientId = Value(ingredientId),
       amount = Value(amount);
  static Insertable<RecipeLine> custom({
    Expression<int>? id,
    Expression<int>? recipeId,
    Expression<int>? ingredientId,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (amount != null) 'amount': amount,
    });
  }

  RecipeLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? recipeId,
    Value<int>? ingredientId,
    Value<double>? amount,
  }) {
    return RecipeLinesCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      ingredientId: ingredientId ?? this.ingredientId,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeLinesCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class $LogEntriesTable extends LogEntries
    with TableInfo<$LogEntriesTable, LogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Slot, String> slot =
      GeneratedColumn<String>(
        'slot',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Slot>($LogEntriesTable.$converterslot);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceRecipeIdMeta = const VerificationMeta(
    'sourceRecipeId',
  );
  @override
  late final GeneratedColumn<int> sourceRecipeId = GeneratedColumn<int>(
    'source_recipe_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _quickKcalMeta = const VerificationMeta(
    'quickKcal',
  );
  @override
  late final GeneratedColumn<double> quickKcal = GeneratedColumn<double>(
    'quick_kcal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quickProteinMeta = const VerificationMeta(
    'quickProtein',
  );
  @override
  late final GeneratedColumn<double> quickProtein = GeneratedColumn<double>(
    'quick_protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _originalLineCountMeta = const VerificationMeta(
    'originalLineCount',
  );
  @override
  late final GeneratedColumn<int> originalLineCount = GeneratedColumn<int>(
    'original_line_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    slot,
    name,
    sourceRecipeId,
    quickKcal,
    quickProtein,
    sortOrder,
    originalLineCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('source_recipe_id')) {
      context.handle(
        _sourceRecipeIdMeta,
        sourceRecipeId.isAcceptableOrUnknown(
          data['source_recipe_id']!,
          _sourceRecipeIdMeta,
        ),
      );
    }
    if (data.containsKey('quick_kcal')) {
      context.handle(
        _quickKcalMeta,
        quickKcal.isAcceptableOrUnknown(data['quick_kcal']!, _quickKcalMeta),
      );
    }
    if (data.containsKey('quick_protein')) {
      context.handle(
        _quickProteinMeta,
        quickProtein.isAcceptableOrUnknown(
          data['quick_protein']!,
          _quickProteinMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('original_line_count')) {
      context.handle(
        _originalLineCountMeta,
        originalLineCount.isAcceptableOrUnknown(
          data['original_line_count']!,
          _originalLineCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
      slot: $LogEntriesTable.$converterslot.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}slot'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sourceRecipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}source_recipe_id'],
      ),
      quickKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quick_kcal'],
      ),
      quickProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quick_protein'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      originalLineCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_line_count'],
      ),
    );
  }

  @override
  $LogEntriesTable createAlias(String alias) {
    return $LogEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Slot, String, String> $converterslot =
      const EnumNameConverter<Slot>(Slot.values);
}

class LogEntry extends DataClass implements Insertable<LogEntry> {
  final int id;

  /// Logical day ("yyyy-MM-dd") with a 3am rollover, not a timestamp.
  final String date;
  final Slot slot;
  final String name;

  /// Link only, never read for amounts. Null for quick add or deleted recipe.
  final int? sourceRecipeId;
  final double? quickKcal;
  final double? quickProtein;
  final int sortOrder;

  /// Number of lines when the recipe was logged; null for quick add.
  final int? originalLineCount;
  const LogEntry({
    required this.id,
    required this.date,
    required this.slot,
    required this.name,
    this.sourceRecipeId,
    this.quickKcal,
    this.quickProtein,
    required this.sortOrder,
    this.originalLineCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<String>(date);
    {
      map['slot'] = Variable<String>(
        $LogEntriesTable.$converterslot.toSql(slot),
      );
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || sourceRecipeId != null) {
      map['source_recipe_id'] = Variable<int>(sourceRecipeId);
    }
    if (!nullToAbsent || quickKcal != null) {
      map['quick_kcal'] = Variable<double>(quickKcal);
    }
    if (!nullToAbsent || quickProtein != null) {
      map['quick_protein'] = Variable<double>(quickProtein);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    if (!nullToAbsent || originalLineCount != null) {
      map['original_line_count'] = Variable<int>(originalLineCount);
    }
    return map;
  }

  LogEntriesCompanion toCompanion(bool nullToAbsent) {
    return LogEntriesCompanion(
      id: Value(id),
      date: Value(date),
      slot: Value(slot),
      name: Value(name),
      sourceRecipeId: sourceRecipeId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceRecipeId),
      quickKcal: quickKcal == null && nullToAbsent
          ? const Value.absent()
          : Value(quickKcal),
      quickProtein: quickProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(quickProtein),
      sortOrder: Value(sortOrder),
      originalLineCount: originalLineCount == null && nullToAbsent
          ? const Value.absent()
          : Value(originalLineCount),
    );
  }

  factory LogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogEntry(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<String>(json['date']),
      slot: $LogEntriesTable.$converterslot.fromJson(
        serializer.fromJson<String>(json['slot']),
      ),
      name: serializer.fromJson<String>(json['name']),
      sourceRecipeId: serializer.fromJson<int?>(json['sourceRecipeId']),
      quickKcal: serializer.fromJson<double?>(json['quickKcal']),
      quickProtein: serializer.fromJson<double?>(json['quickProtein']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      originalLineCount: serializer.fromJson<int?>(json['originalLineCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<String>(date),
      'slot': serializer.toJson<String>(
        $LogEntriesTable.$converterslot.toJson(slot),
      ),
      'name': serializer.toJson<String>(name),
      'sourceRecipeId': serializer.toJson<int?>(sourceRecipeId),
      'quickKcal': serializer.toJson<double?>(quickKcal),
      'quickProtein': serializer.toJson<double?>(quickProtein),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'originalLineCount': serializer.toJson<int?>(originalLineCount),
    };
  }

  LogEntry copyWith({
    int? id,
    String? date,
    Slot? slot,
    String? name,
    Value<int?> sourceRecipeId = const Value.absent(),
    Value<double?> quickKcal = const Value.absent(),
    Value<double?> quickProtein = const Value.absent(),
    int? sortOrder,
    Value<int?> originalLineCount = const Value.absent(),
  }) => LogEntry(
    id: id ?? this.id,
    date: date ?? this.date,
    slot: slot ?? this.slot,
    name: name ?? this.name,
    sourceRecipeId: sourceRecipeId.present
        ? sourceRecipeId.value
        : this.sourceRecipeId,
    quickKcal: quickKcal.present ? quickKcal.value : this.quickKcal,
    quickProtein: quickProtein.present ? quickProtein.value : this.quickProtein,
    sortOrder: sortOrder ?? this.sortOrder,
    originalLineCount: originalLineCount.present
        ? originalLineCount.value
        : this.originalLineCount,
  );
  LogEntry copyWithCompanion(LogEntriesCompanion data) {
    return LogEntry(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      slot: data.slot.present ? data.slot.value : this.slot,
      name: data.name.present ? data.name.value : this.name,
      sourceRecipeId: data.sourceRecipeId.present
          ? data.sourceRecipeId.value
          : this.sourceRecipeId,
      quickKcal: data.quickKcal.present ? data.quickKcal.value : this.quickKcal,
      quickProtein: data.quickProtein.present
          ? data.quickProtein.value
          : this.quickProtein,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      originalLineCount: data.originalLineCount.present
          ? data.originalLineCount.value
          : this.originalLineCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogEntry(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slot: $slot, ')
          ..write('name: $name, ')
          ..write('sourceRecipeId: $sourceRecipeId, ')
          ..write('quickKcal: $quickKcal, ')
          ..write('quickProtein: $quickProtein, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('originalLineCount: $originalLineCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    slot,
    name,
    sourceRecipeId,
    quickKcal,
    quickProtein,
    sortOrder,
    originalLineCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogEntry &&
          other.id == this.id &&
          other.date == this.date &&
          other.slot == this.slot &&
          other.name == this.name &&
          other.sourceRecipeId == this.sourceRecipeId &&
          other.quickKcal == this.quickKcal &&
          other.quickProtein == this.quickProtein &&
          other.sortOrder == this.sortOrder &&
          other.originalLineCount == this.originalLineCount);
}

class LogEntriesCompanion extends UpdateCompanion<LogEntry> {
  final Value<int> id;
  final Value<String> date;
  final Value<Slot> slot;
  final Value<String> name;
  final Value<int?> sourceRecipeId;
  final Value<double?> quickKcal;
  final Value<double?> quickProtein;
  final Value<int> sortOrder;
  final Value<int?> originalLineCount;
  const LogEntriesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.slot = const Value.absent(),
    this.name = const Value.absent(),
    this.sourceRecipeId = const Value.absent(),
    this.quickKcal = const Value.absent(),
    this.quickProtein = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.originalLineCount = const Value.absent(),
  });
  LogEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String date,
    required Slot slot,
    required String name,
    this.sourceRecipeId = const Value.absent(),
    this.quickKcal = const Value.absent(),
    this.quickProtein = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.originalLineCount = const Value.absent(),
  }) : date = Value(date),
       slot = Value(slot),
       name = Value(name);
  static Insertable<LogEntry> custom({
    Expression<int>? id,
    Expression<String>? date,
    Expression<String>? slot,
    Expression<String>? name,
    Expression<int>? sourceRecipeId,
    Expression<double>? quickKcal,
    Expression<double>? quickProtein,
    Expression<int>? sortOrder,
    Expression<int>? originalLineCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (slot != null) 'slot': slot,
      if (name != null) 'name': name,
      if (sourceRecipeId != null) 'source_recipe_id': sourceRecipeId,
      if (quickKcal != null) 'quick_kcal': quickKcal,
      if (quickProtein != null) 'quick_protein': quickProtein,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (originalLineCount != null) 'original_line_count': originalLineCount,
    });
  }

  LogEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? date,
    Value<Slot>? slot,
    Value<String>? name,
    Value<int?>? sourceRecipeId,
    Value<double?>? quickKcal,
    Value<double?>? quickProtein,
    Value<int>? sortOrder,
    Value<int?>? originalLineCount,
  }) {
    return LogEntriesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      slot: slot ?? this.slot,
      name: name ?? this.name,
      sourceRecipeId: sourceRecipeId ?? this.sourceRecipeId,
      quickKcal: quickKcal ?? this.quickKcal,
      quickProtein: quickProtein ?? this.quickProtein,
      sortOrder: sortOrder ?? this.sortOrder,
      originalLineCount: originalLineCount ?? this.originalLineCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (slot.present) {
      map['slot'] = Variable<String>(
        $LogEntriesTable.$converterslot.toSql(slot.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sourceRecipeId.present) {
      map['source_recipe_id'] = Variable<int>(sourceRecipeId.value);
    }
    if (quickKcal.present) {
      map['quick_kcal'] = Variable<double>(quickKcal.value);
    }
    if (quickProtein.present) {
      map['quick_protein'] = Variable<double>(quickProtein.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (originalLineCount.present) {
      map['original_line_count'] = Variable<int>(originalLineCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogEntriesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('slot: $slot, ')
          ..write('name: $name, ')
          ..write('sourceRecipeId: $sourceRecipeId, ')
          ..write('quickKcal: $quickKcal, ')
          ..write('quickProtein: $quickProtein, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('originalLineCount: $originalLineCount')
          ..write(')'))
        .toString();
  }
}

class $LogLinesTable extends LogLines with TableInfo<$LogLinesTable, LogLine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogLinesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES log_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ingredientIdMeta = const VerificationMeta(
    'ingredientId',
  );
  @override
  late final GeneratedColumn<int> ingredientId = GeneratedColumn<int>(
    'ingredient_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ingredients (id) ON DELETE SET NULL',
    ),
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
  @override
  late final GeneratedColumnWithTypeConverter<Unit, String> unit =
      GeneratedColumn<String>(
        'unit',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Unit>($LogLinesTable.$converterunit);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalAmountMeta = const VerificationMeta(
    'originalAmount',
  );
  @override
  late final GeneratedColumn<double> originalAmount = GeneratedColumn<double>(
    'original_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refAmountMeta = const VerificationMeta(
    'refAmount',
  );
  @override
  late final GeneratedColumn<double> refAmount = GeneratedColumn<double>(
    'ref_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refKcalMeta = const VerificationMeta(
    'refKcal',
  );
  @override
  late final GeneratedColumn<double> refKcal = GeneratedColumn<double>(
    'ref_kcal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refProteinMeta = const VerificationMeta(
    'refProtein',
  );
  @override
  late final GeneratedColumn<double> refProtein = GeneratedColumn<double>(
    'ref_protein',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryId,
    ingredientId,
    name,
    unit,
    amount,
    originalAmount,
    refAmount,
    refKcal,
    refProtein,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_lines';
  @override
  VerificationContext validateIntegrity(
    Insertable<LogLine> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('ingredient_id')) {
      context.handle(
        _ingredientIdMeta,
        ingredientId.isAcceptableOrUnknown(
          data['ingredient_id']!,
          _ingredientIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('original_amount')) {
      context.handle(
        _originalAmountMeta,
        originalAmount.isAcceptableOrUnknown(
          data['original_amount']!,
          _originalAmountMeta,
        ),
      );
    }
    if (data.containsKey('ref_amount')) {
      context.handle(
        _refAmountMeta,
        refAmount.isAcceptableOrUnknown(data['ref_amount']!, _refAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_refAmountMeta);
    }
    if (data.containsKey('ref_kcal')) {
      context.handle(
        _refKcalMeta,
        refKcal.isAcceptableOrUnknown(data['ref_kcal']!, _refKcalMeta),
      );
    } else if (isInserting) {
      context.missing(_refKcalMeta);
    }
    if (data.containsKey('ref_protein')) {
      context.handle(
        _refProteinMeta,
        refProtein.isAcceptableOrUnknown(data['ref_protein']!, _refProteinMeta),
      );
    } else if (isInserting) {
      context.missing(_refProteinMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogLine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogLine(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      ingredientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ingredient_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      unit: $LogLinesTable.$converterunit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unit'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      originalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_amount'],
      ),
      refAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_amount'],
      )!,
      refKcal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_kcal'],
      )!,
      refProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ref_protein'],
      )!,
    );
  }

  @override
  $LogLinesTable createAlias(String alias) {
    return $LogLinesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Unit, String, String> $converterunit =
      const EnumNameConverter<Unit>(Unit.values);
}

class LogLine extends DataClass implements Insertable<LogLine> {
  final int id;
  final int entryId;
  final int? ingredientId;
  final String name;
  final Unit unit;
  final double amount;

  /// Amount when logged; null for a line added while editing.
  final double? originalAmount;
  final double refAmount;
  final double refKcal;
  final double refProtein;
  const LogLine({
    required this.id,
    required this.entryId,
    this.ingredientId,
    required this.name,
    required this.unit,
    required this.amount,
    this.originalAmount,
    required this.refAmount,
    required this.refKcal,
    required this.refProtein,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entry_id'] = Variable<int>(entryId);
    if (!nullToAbsent || ingredientId != null) {
      map['ingredient_id'] = Variable<int>(ingredientId);
    }
    map['name'] = Variable<String>(name);
    {
      map['unit'] = Variable<String>($LogLinesTable.$converterunit.toSql(unit));
    }
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || originalAmount != null) {
      map['original_amount'] = Variable<double>(originalAmount);
    }
    map['ref_amount'] = Variable<double>(refAmount);
    map['ref_kcal'] = Variable<double>(refKcal);
    map['ref_protein'] = Variable<double>(refProtein);
    return map;
  }

  LogLinesCompanion toCompanion(bool nullToAbsent) {
    return LogLinesCompanion(
      id: Value(id),
      entryId: Value(entryId),
      ingredientId: ingredientId == null && nullToAbsent
          ? const Value.absent()
          : Value(ingredientId),
      name: Value(name),
      unit: Value(unit),
      amount: Value(amount),
      originalAmount: originalAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(originalAmount),
      refAmount: Value(refAmount),
      refKcal: Value(refKcal),
      refProtein: Value(refProtein),
    );
  }

  factory LogLine.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogLine(
      id: serializer.fromJson<int>(json['id']),
      entryId: serializer.fromJson<int>(json['entryId']),
      ingredientId: serializer.fromJson<int?>(json['ingredientId']),
      name: serializer.fromJson<String>(json['name']),
      unit: $LogLinesTable.$converterunit.fromJson(
        serializer.fromJson<String>(json['unit']),
      ),
      amount: serializer.fromJson<double>(json['amount']),
      originalAmount: serializer.fromJson<double?>(json['originalAmount']),
      refAmount: serializer.fromJson<double>(json['refAmount']),
      refKcal: serializer.fromJson<double>(json['refKcal']),
      refProtein: serializer.fromJson<double>(json['refProtein']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entryId': serializer.toJson<int>(entryId),
      'ingredientId': serializer.toJson<int?>(ingredientId),
      'name': serializer.toJson<String>(name),
      'unit': serializer.toJson<String>(
        $LogLinesTable.$converterunit.toJson(unit),
      ),
      'amount': serializer.toJson<double>(amount),
      'originalAmount': serializer.toJson<double?>(originalAmount),
      'refAmount': serializer.toJson<double>(refAmount),
      'refKcal': serializer.toJson<double>(refKcal),
      'refProtein': serializer.toJson<double>(refProtein),
    };
  }

  LogLine copyWith({
    int? id,
    int? entryId,
    Value<int?> ingredientId = const Value.absent(),
    String? name,
    Unit? unit,
    double? amount,
    Value<double?> originalAmount = const Value.absent(),
    double? refAmount,
    double? refKcal,
    double? refProtein,
  }) => LogLine(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    ingredientId: ingredientId.present ? ingredientId.value : this.ingredientId,
    name: name ?? this.name,
    unit: unit ?? this.unit,
    amount: amount ?? this.amount,
    originalAmount: originalAmount.present
        ? originalAmount.value
        : this.originalAmount,
    refAmount: refAmount ?? this.refAmount,
    refKcal: refKcal ?? this.refKcal,
    refProtein: refProtein ?? this.refProtein,
  );
  LogLine copyWithCompanion(LogLinesCompanion data) {
    return LogLine(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      ingredientId: data.ingredientId.present
          ? data.ingredientId.value
          : this.ingredientId,
      name: data.name.present ? data.name.value : this.name,
      unit: data.unit.present ? data.unit.value : this.unit,
      amount: data.amount.present ? data.amount.value : this.amount,
      originalAmount: data.originalAmount.present
          ? data.originalAmount.value
          : this.originalAmount,
      refAmount: data.refAmount.present ? data.refAmount.value : this.refAmount,
      refKcal: data.refKcal.present ? data.refKcal.value : this.refKcal,
      refProtein: data.refProtein.present
          ? data.refProtein.value
          : this.refProtein,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogLine(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('amount: $amount, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('refAmount: $refAmount, ')
          ..write('refKcal: $refKcal, ')
          ..write('refProtein: $refProtein')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entryId,
    ingredientId,
    name,
    unit,
    amount,
    originalAmount,
    refAmount,
    refKcal,
    refProtein,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogLine &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.ingredientId == this.ingredientId &&
          other.name == this.name &&
          other.unit == this.unit &&
          other.amount == this.amount &&
          other.originalAmount == this.originalAmount &&
          other.refAmount == this.refAmount &&
          other.refKcal == this.refKcal &&
          other.refProtein == this.refProtein);
}

class LogLinesCompanion extends UpdateCompanion<LogLine> {
  final Value<int> id;
  final Value<int> entryId;
  final Value<int?> ingredientId;
  final Value<String> name;
  final Value<Unit> unit;
  final Value<double> amount;
  final Value<double?> originalAmount;
  final Value<double> refAmount;
  final Value<double> refKcal;
  final Value<double> refProtein;
  const LogLinesCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.ingredientId = const Value.absent(),
    this.name = const Value.absent(),
    this.unit = const Value.absent(),
    this.amount = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.refAmount = const Value.absent(),
    this.refKcal = const Value.absent(),
    this.refProtein = const Value.absent(),
  });
  LogLinesCompanion.insert({
    this.id = const Value.absent(),
    required int entryId,
    this.ingredientId = const Value.absent(),
    required String name,
    required Unit unit,
    required double amount,
    this.originalAmount = const Value.absent(),
    required double refAmount,
    required double refKcal,
    required double refProtein,
  }) : entryId = Value(entryId),
       name = Value(name),
       unit = Value(unit),
       amount = Value(amount),
       refAmount = Value(refAmount),
       refKcal = Value(refKcal),
       refProtein = Value(refProtein);
  static Insertable<LogLine> custom({
    Expression<int>? id,
    Expression<int>? entryId,
    Expression<int>? ingredientId,
    Expression<String>? name,
    Expression<String>? unit,
    Expression<double>? amount,
    Expression<double>? originalAmount,
    Expression<double>? refAmount,
    Expression<double>? refKcal,
    Expression<double>? refProtein,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (ingredientId != null) 'ingredient_id': ingredientId,
      if (name != null) 'name': name,
      if (unit != null) 'unit': unit,
      if (amount != null) 'amount': amount,
      if (originalAmount != null) 'original_amount': originalAmount,
      if (refAmount != null) 'ref_amount': refAmount,
      if (refKcal != null) 'ref_kcal': refKcal,
      if (refProtein != null) 'ref_protein': refProtein,
    });
  }

  LogLinesCompanion copyWith({
    Value<int>? id,
    Value<int>? entryId,
    Value<int?>? ingredientId,
    Value<String>? name,
    Value<Unit>? unit,
    Value<double>? amount,
    Value<double?>? originalAmount,
    Value<double>? refAmount,
    Value<double>? refKcal,
    Value<double>? refProtein,
  }) {
    return LogLinesCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      ingredientId: ingredientId ?? this.ingredientId,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      amount: amount ?? this.amount,
      originalAmount: originalAmount ?? this.originalAmount,
      refAmount: refAmount ?? this.refAmount,
      refKcal: refKcal ?? this.refKcal,
      refProtein: refProtein ?? this.refProtein,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (ingredientId.present) {
      map['ingredient_id'] = Variable<int>(ingredientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(
        $LogLinesTable.$converterunit.toSql(unit.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (originalAmount.present) {
      map['original_amount'] = Variable<double>(originalAmount.value);
    }
    if (refAmount.present) {
      map['ref_amount'] = Variable<double>(refAmount.value);
    }
    if (refKcal.present) {
      map['ref_kcal'] = Variable<double>(refKcal.value);
    }
    if (refProtein.present) {
      map['ref_protein'] = Variable<double>(refProtein.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogLinesCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('ingredientId: $ingredientId, ')
          ..write('name: $name, ')
          ..write('unit: $unit, ')
          ..write('amount: $amount, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('refAmount: $refAmount, ')
          ..write('refKcal: $refKcal, ')
          ..write('refProtein: $refProtein')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $IngredientsTable ingredients = $IngredientsTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeLinesTable recipeLines = $RecipeLinesTable(this);
  late final $LogEntriesTable logEntries = $LogEntriesTable(this);
  late final $LogLinesTable logLines = $LogLinesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    ingredients,
    recipes,
    recipeLines,
    logEntries,
    logLines,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_lines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('log_entries', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'log_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('log_lines', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ingredients',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('log_lines', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$IngredientsTableCreateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      required String name,
      required Unit unit,
      required double refAmount,
      required double refKcal,
      Value<double> refProtein,
      Value<bool> archived,
      Value<DateTime?> lastUsedAt,
    });
typedef $$IngredientsTableUpdateCompanionBuilder =
    IngredientsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Unit> unit,
      Value<double> refAmount,
      Value<double> refKcal,
      Value<double> refProtein,
      Value<bool> archived,
      Value<DateTime?> lastUsedAt,
    });

final class $$IngredientsTableReferences
    extends BaseReferences<_$AppDatabase, $IngredientsTable, Ingredient> {
  $$IngredientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeLinesTable, List<RecipeLine>>
  _recipeLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeLines,
    aliasName: 'ingredients__id__recipe_lines__ingredient_id',
  );

  $$RecipeLinesTableProcessedTableManager get recipeLinesRefs {
    final manager = $$RecipeLinesTableTableManager(
      $_db,
      $_db.recipeLines,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogLinesTable, List<LogLine>> _logLinesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.logLines,
    aliasName: 'ingredients__id__log_lines__ingredient_id',
  );

  $$LogLinesTableProcessedTableManager get logLinesRefs {
    final manager = $$LogLinesTableTableManager(
      $_db,
      $_db.logLines,
    ).filter((f) => f.ingredientId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$IngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Unit, Unit, String> get unit =>
      $composableBuilder(
        column: $table.unit,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get refAmount => $composableBuilder(
    column: $table.refAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refKcal => $composableBuilder(
    column: $table.refKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refProtein => $composableBuilder(
    column: $table.refProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeLinesRefs(
    Expression<bool> Function($$RecipeLinesTableFilterComposer f) f,
  ) {
    final $$RecipeLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeLines,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeLinesTableFilterComposer(
            $db: $db,
            $table: $db.recipeLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logLinesRefs(
    Expression<bool> Function($$LogLinesTableFilterComposer f) f,
  ) {
    final $$LogLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logLines,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogLinesTableFilterComposer(
            $db: $db,
            $table: $db.logLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refAmount => $composableBuilder(
    column: $table.refAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refKcal => $composableBuilder(
    column: $table.refKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refProtein => $composableBuilder(
    column: $table.refProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$IngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientsTable> {
  $$IngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Unit, String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get refAmount =>
      $composableBuilder(column: $table.refAmount, builder: (column) => column);

  GeneratedColumn<double> get refKcal =>
      $composableBuilder(column: $table.refKcal, builder: (column) => column);

  GeneratedColumn<double> get refProtein => $composableBuilder(
    column: $table.refProtein,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  Expression<T> recipeLinesRefs<T extends Object>(
    Expression<T> Function($$RecipeLinesTableAnnotationComposer a) f,
  ) {
    final $$RecipeLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeLines,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logLinesRefs<T extends Object>(
    Expression<T> Function($$LogLinesTableAnnotationComposer a) f,
  ) {
    final $$LogLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logLines,
      getReferencedColumn: (t) => t.ingredientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.logLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$IngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientsTable,
          Ingredient,
          $$IngredientsTableFilterComposer,
          $$IngredientsTableOrderingComposer,
          $$IngredientsTableAnnotationComposer,
          $$IngredientsTableCreateCompanionBuilder,
          $$IngredientsTableUpdateCompanionBuilder,
          (Ingredient, $$IngredientsTableReferences),
          Ingredient,
          PrefetchHooks Function({bool recipeLinesRefs, bool logLinesRefs})
        > {
  $$IngredientsTableTableManager(_$AppDatabase db, $IngredientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Unit> unit = const Value.absent(),
                Value<double> refAmount = const Value.absent(),
                Value<double> refKcal = const Value.absent(),
                Value<double> refProtein = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
              }) => IngredientsCompanion(
                id: id,
                name: name,
                unit: unit,
                refAmount: refAmount,
                refKcal: refKcal,
                refProtein: refProtein,
                archived: archived,
                lastUsedAt: lastUsedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required Unit unit,
                required double refAmount,
                required double refKcal,
                Value<double> refProtein = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
              }) => IngredientsCompanion.insert(
                id: id,
                name: name,
                unit: unit,
                refAmount: refAmount,
                refKcal: refKcal,
                refProtein: refProtein,
                archived: archived,
                lastUsedAt: lastUsedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$IngredientsTable, Ingredient>(table),
                  $$IngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recipeLinesRefs = false, logLinesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeLinesRefs) db.recipeLines,
                    if (logLinesRefs) db.logLines,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeLinesRefs)
                        await $_getPrefetchedDataByColumns<
                          Ingredient,
                          $IngredientsTable,
                          RecipeLine,
                          $RecipeLinesTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._recipeLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeLinesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                      if (logLinesRefs)
                        await $_getPrefetchedDataByColumns<
                          Ingredient,
                          $IngredientsTable,
                          LogLine,
                          $LogLinesTable
                        >(
                          currentTable: table,
                          referencedTable: $$IngredientsTableReferences
                              ._logLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$IngredientsTableReferences(
                                db,
                                table,
                                p0,
                              ).logLinesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'ingredient_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$IngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientsTable,
      Ingredient,
      $$IngredientsTableFilterComposer,
      $$IngredientsTableOrderingComposer,
      $$IngredientsTableAnnotationComposer,
      $$IngredientsTableCreateCompanionBuilder,
      $$IngredientsTableUpdateCompanionBuilder,
      (Ingredient, $$IngredientsTableReferences),
      Ingredient,
      PrefetchHooks Function({bool recipeLinesRefs, bool logLinesRefs})
    >;
typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      required String name,
      Value<Slot?> defaultSlot,
      Value<DateTime?> lastUsedAt,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Slot?> defaultSlot,
      Value<DateTime?> lastUsedAt,
    });

final class $$RecipesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipesTable, Recipe> {
  $$RecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeLinesTable, List<RecipeLine>>
  _recipeLinesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recipeLines,
    aliasName: 'recipes__id__recipe_lines__recipe_id',
  );

  $$RecipeLinesTableProcessedTableManager get recipeLinesRefs {
    final manager = $$RecipeLinesTableTableManager(
      $_db,
      $_db.recipeLines,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_recipeLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LogEntriesTable, List<LogEntry>>
  _logEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.logEntries,
    aliasName: 'recipes__id__log_entries__source_recipe_id',
  );

  $$LogEntriesTableProcessedTableManager get logEntriesRefs {
    final manager = $$LogEntriesTableTableManager(
      $_db,
      $_db.logEntries,
    ).filter((f) => f.sourceRecipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Slot?, Slot, String> get defaultSlot =>
      $composableBuilder(
        column: $table.defaultSlot,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeLinesRefs(
    Expression<bool> Function($$RecipeLinesTableFilterComposer f) f,
  ) {
    final $$RecipeLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeLines,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeLinesTableFilterComposer(
            $db: $db,
            $table: $db.recipeLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> logEntriesRefs(
    Expression<bool> Function($$LogEntriesTableFilterComposer f) f,
  ) {
    final $$LogEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.sourceRecipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableFilterComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultSlot => $composableBuilder(
    column: $table.defaultSlot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Slot?, String> get defaultSlot =>
      $composableBuilder(
        column: $table.defaultSlot,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get lastUsedAt => $composableBuilder(
    column: $table.lastUsedAt,
    builder: (column) => column,
  );

  Expression<T> recipeLinesRefs<T extends Object>(
    Expression<T> Function($$RecipeLinesTableAnnotationComposer a) f,
  ) {
    final $$RecipeLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeLines,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> logEntriesRefs<T extends Object>(
    Expression<T> Function($$LogEntriesTableAnnotationComposer a) f,
  ) {
    final $$LogEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.sourceRecipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, $$RecipesTableReferences),
          Recipe,
          PrefetchHooks Function({bool recipeLinesRefs, bool logEntriesRefs})
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Slot?> defaultSlot = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                name: name,
                defaultSlot: defaultSlot,
                lastUsedAt: lastUsedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<Slot?> defaultSlot = const Value.absent(),
                Value<DateTime?> lastUsedAt = const Value.absent(),
              }) => RecipesCompanion.insert(
                id: id,
                name: name,
                defaultSlot: defaultSlot,
                lastUsedAt: lastUsedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipesTable, Recipe>(table),
                  $$RecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({recipeLinesRefs = false, logEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeLinesRefs) db.recipeLines,
                    if (logEntriesRefs) db.logEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeLinesRefs)
                        await $_getPrefetchedDataByColumns<
                          Recipe,
                          $RecipesTable,
                          RecipeLine,
                          $RecipeLinesTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._recipeLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeLinesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'recipe_id',
                          typedResults: items,
                        ),
                      if (logEntriesRefs)
                        await $_getPrefetchedDataByColumns<
                          Recipe,
                          $RecipesTable,
                          LogEntry,
                          $LogEntriesTable
                        >(
                          currentTable: table,
                          referencedTable: $$RecipesTableReferences
                              ._logEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipesTableReferences(
                                db,
                                table,
                                p0,
                              ).logEntriesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'source_recipe_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, $$RecipesTableReferences),
      Recipe,
      PrefetchHooks Function({bool recipeLinesRefs, bool logEntriesRefs})
    >;
typedef $$RecipeLinesTableCreateCompanionBuilder =
    RecipeLinesCompanion Function({
      Value<int> id,
      required int recipeId,
      required int ingredientId,
      required double amount,
    });
typedef $$RecipeLinesTableUpdateCompanionBuilder =
    RecipeLinesCompanion Function({
      Value<int> id,
      Value<int> recipeId,
      Value<int> ingredientId,
      Value<double> amount,
    });

final class $$RecipeLinesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeLinesTable, RecipeLine> {
  $$RecipeLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('recipe_lines__recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) => db
      .ingredients
      .createAlias('recipe_lines__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id')!;

    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeLinesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeLinesTable> {
  $$RecipeLinesTableFilterComposer({
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

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeLinesTable> {
  $$RecipeLinesTableOrderingComposer({
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

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeLinesTable> {
  $$RecipeLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeLinesTable,
          RecipeLine,
          $$RecipeLinesTableFilterComposer,
          $$RecipeLinesTableOrderingComposer,
          $$RecipeLinesTableAnnotationComposer,
          $$RecipeLinesTableCreateCompanionBuilder,
          $$RecipeLinesTableUpdateCompanionBuilder,
          (RecipeLine, $$RecipeLinesTableReferences),
          RecipeLine,
          PrefetchHooks Function({bool recipeId, bool ingredientId})
        > {
  $$RecipeLinesTableTableManager(_$AppDatabase db, $RecipeLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> recipeId = const Value.absent(),
                Value<int> ingredientId = const Value.absent(),
                Value<double> amount = const Value.absent(),
              }) => RecipeLinesCompanion(
                id: id,
                recipeId: recipeId,
                ingredientId: ingredientId,
                amount: amount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int recipeId,
                required int ingredientId,
                required double amount,
              }) => RecipeLinesCompanion.insert(
                id: id,
                recipeId: recipeId,
                ingredientId: ingredientId,
                amount: amount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RecipeLinesTable, RecipeLine>(table),
                  $$RecipeLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, ingredientId = false}) {
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
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable: $$RecipeLinesTableReferences
                                    ._recipeIdTable(db),
                                referencedColumn: $$RecipeLinesTableReferences
                                    ._recipeIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable: $$RecipeLinesTableReferences
                                    ._ingredientIdTable(db),
                                referencedColumn: $$RecipeLinesTableReferences
                                    ._ingredientIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$RecipeLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeLinesTable,
      RecipeLine,
      $$RecipeLinesTableFilterComposer,
      $$RecipeLinesTableOrderingComposer,
      $$RecipeLinesTableAnnotationComposer,
      $$RecipeLinesTableCreateCompanionBuilder,
      $$RecipeLinesTableUpdateCompanionBuilder,
      (RecipeLine, $$RecipeLinesTableReferences),
      RecipeLine,
      PrefetchHooks Function({bool recipeId, bool ingredientId})
    >;
typedef $$LogEntriesTableCreateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      required String date,
      required Slot slot,
      required String name,
      Value<int?> sourceRecipeId,
      Value<double?> quickKcal,
      Value<double?> quickProtein,
      Value<int> sortOrder,
      Value<int?> originalLineCount,
    });
typedef $$LogEntriesTableUpdateCompanionBuilder =
    LogEntriesCompanion Function({
      Value<int> id,
      Value<String> date,
      Value<Slot> slot,
      Value<String> name,
      Value<int?> sourceRecipeId,
      Value<double?> quickKcal,
      Value<double?> quickProtein,
      Value<int> sortOrder,
      Value<int?> originalLineCount,
    });

final class $$LogEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $LogEntriesTable, LogEntry> {
  $$LogEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RecipesTable _sourceRecipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias('log_entries__source_recipe_id__recipes__id');

  $$RecipesTableProcessedTableManager? get sourceRecipeId {
    final $_column = $_itemColumn<int>('source_recipe_id');
    if ($_column == null) return null;
    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sourceRecipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LogLinesTable, List<LogLine>> _logLinesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.logLines,
    aliasName: 'log_entries__id__log_lines__entry_id',
  );

  $$LogLinesTableProcessedTableManager get logLinesRefs {
    final manager = $$LogLinesTableTableManager(
      $_db,
      $_db.logLines,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_logLinesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LogEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableFilterComposer({
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

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Slot, Slot, String> get slot =>
      $composableBuilder(
        column: $table.slot,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quickKcal => $composableBuilder(
    column: $table.quickKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quickProtein => $composableBuilder(
    column: $table.quickProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get originalLineCount => $composableBuilder(
    column: $table.originalLineCount,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get sourceRecipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceRecipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> logLinesRefs(
    Expression<bool> Function($$LogLinesTableFilterComposer f) f,
  ) {
    final $$LogLinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logLines,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogLinesTableFilterComposer(
            $db: $db,
            $table: $db.logLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LogEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slot => $composableBuilder(
    column: $table.slot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quickKcal => $composableBuilder(
    column: $table.quickKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quickProtein => $composableBuilder(
    column: $table.quickProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get originalLineCount => $composableBuilder(
    column: $table.originalLineCount,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get sourceRecipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceRecipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogEntriesTable> {
  $$LogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Slot, String> get slot =>
      $composableBuilder(column: $table.slot, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get quickKcal =>
      $composableBuilder(column: $table.quickKcal, builder: (column) => column);

  GeneratedColumn<double> get quickProtein => $composableBuilder(
    column: $table.quickProtein,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<int> get originalLineCount => $composableBuilder(
    column: $table.originalLineCount,
    builder: (column) => column,
  );

  $$RecipesTableAnnotationComposer get sourceRecipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sourceRecipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> logLinesRefs<T extends Object>(
    Expression<T> Function($$LogLinesTableAnnotationComposer a) f,
  ) {
    final $$LogLinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.logLines,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogLinesTableAnnotationComposer(
            $db: $db,
            $table: $db.logLines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LogEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogEntriesTable,
          LogEntry,
          $$LogEntriesTableFilterComposer,
          $$LogEntriesTableOrderingComposer,
          $$LogEntriesTableAnnotationComposer,
          $$LogEntriesTableCreateCompanionBuilder,
          $$LogEntriesTableUpdateCompanionBuilder,
          (LogEntry, $$LogEntriesTableReferences),
          LogEntry,
          PrefetchHooks Function({bool sourceRecipeId, bool logLinesRefs})
        > {
  $$LogEntriesTableTableManager(_$AppDatabase db, $LogEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> date = const Value.absent(),
                Value<Slot> slot = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> sourceRecipeId = const Value.absent(),
                Value<double?> quickKcal = const Value.absent(),
                Value<double?> quickProtein = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int?> originalLineCount = const Value.absent(),
              }) => LogEntriesCompanion(
                id: id,
                date: date,
                slot: slot,
                name: name,
                sourceRecipeId: sourceRecipeId,
                quickKcal: quickKcal,
                quickProtein: quickProtein,
                sortOrder: sortOrder,
                originalLineCount: originalLineCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String date,
                required Slot slot,
                required String name,
                Value<int?> sourceRecipeId = const Value.absent(),
                Value<double?> quickKcal = const Value.absent(),
                Value<double?> quickProtein = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int?> originalLineCount = const Value.absent(),
              }) => LogEntriesCompanion.insert(
                id: id,
                date: date,
                slot: slot,
                name: name,
                sourceRecipeId: sourceRecipeId,
                quickKcal: quickKcal,
                quickProtein: quickProtein,
                sortOrder: sortOrder,
                originalLineCount: originalLineCount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LogEntriesTable, LogEntry>(table),
                  $$LogEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({sourceRecipeId = false, logLinesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (logLinesRefs) db.logLines],
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
                        if (sourceRecipeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sourceRecipeId,
                                    referencedTable: $$LogEntriesTableReferences
                                        ._sourceRecipeIdTable(db),
                                    referencedColumn:
                                        $$LogEntriesTableReferences
                                            ._sourceRecipeIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (logLinesRefs)
                        await $_getPrefetchedDataByColumns<
                          LogEntry,
                          $LogEntriesTable,
                          LogLine,
                          $LogLinesTable
                        >(
                          currentTable: table,
                          referencedTable: $$LogEntriesTableReferences
                              ._logLinesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LogEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).logLinesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'entry_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogEntriesTable,
      LogEntry,
      $$LogEntriesTableFilterComposer,
      $$LogEntriesTableOrderingComposer,
      $$LogEntriesTableAnnotationComposer,
      $$LogEntriesTableCreateCompanionBuilder,
      $$LogEntriesTableUpdateCompanionBuilder,
      (LogEntry, $$LogEntriesTableReferences),
      LogEntry,
      PrefetchHooks Function({bool sourceRecipeId, bool logLinesRefs})
    >;
typedef $$LogLinesTableCreateCompanionBuilder =
    LogLinesCompanion Function({
      Value<int> id,
      required int entryId,
      Value<int?> ingredientId,
      required String name,
      required Unit unit,
      required double amount,
      Value<double?> originalAmount,
      required double refAmount,
      required double refKcal,
      required double refProtein,
    });
typedef $$LogLinesTableUpdateCompanionBuilder =
    LogLinesCompanion Function({
      Value<int> id,
      Value<int> entryId,
      Value<int?> ingredientId,
      Value<String> name,
      Value<Unit> unit,
      Value<double> amount,
      Value<double?> originalAmount,
      Value<double> refAmount,
      Value<double> refKcal,
      Value<double> refProtein,
    });

final class $$LogLinesTableReferences
    extends BaseReferences<_$AppDatabase, $LogLinesTable, LogLine> {
  $$LogLinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LogEntriesTable _entryIdTable(_$AppDatabase db) =>
      db.logEntries.createAlias('log_lines__entry_id__log_entries__id');

  $$LogEntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$LogEntriesTableTableManager(
      $_db,
      $_db.logEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $IngredientsTable _ingredientIdTable(_$AppDatabase db) =>
      db.ingredients.createAlias('log_lines__ingredient_id__ingredients__id');

  $$IngredientsTableProcessedTableManager? get ingredientId {
    final $_column = $_itemColumn<int>('ingredient_id');
    if ($_column == null) return null;
    final manager = $$IngredientsTableTableManager(
      $_db,
      $_db.ingredients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ingredientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LogLinesTableFilterComposer
    extends Composer<_$AppDatabase, $LogLinesTable> {
  $$LogLinesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Unit, Unit, String> get unit =>
      $composableBuilder(
        column: $table.unit,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refAmount => $composableBuilder(
    column: $table.refAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refKcal => $composableBuilder(
    column: $table.refKcal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get refProtein => $composableBuilder(
    column: $table.refProtein,
    builder: (column) => ColumnFilters(column),
  );

  $$LogEntriesTableFilterComposer get entryId {
    final $$LogEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableFilterComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableFilterComposer get ingredientId {
    final $$IngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableFilterComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogLinesTableOrderingComposer
    extends Composer<_$AppDatabase, $LogLinesTable> {
  $$LogLinesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refAmount => $composableBuilder(
    column: $table.refAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refKcal => $composableBuilder(
    column: $table.refKcal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get refProtein => $composableBuilder(
    column: $table.refProtein,
    builder: (column) => ColumnOrderings(column),
  );

  $$LogEntriesTableOrderingComposer get entryId {
    final $$LogEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableOrderingComposer get ingredientId {
    final $$IngredientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableOrderingComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogLinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LogLinesTable> {
  $$LogLinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Unit, String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<double> get originalAmount => $composableBuilder(
    column: $table.originalAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get refAmount =>
      $composableBuilder(column: $table.refAmount, builder: (column) => column);

  GeneratedColumn<double> get refKcal =>
      $composableBuilder(column: $table.refKcal, builder: (column) => column);

  GeneratedColumn<double> get refProtein => $composableBuilder(
    column: $table.refProtein,
    builder: (column) => column,
  );

  $$LogEntriesTableAnnotationComposer get entryId {
    final $$LogEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.logEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LogEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.logEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$IngredientsTableAnnotationComposer get ingredientId {
    final $$IngredientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ingredientId,
      referencedTable: $db.ingredients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientsTableAnnotationComposer(
            $db: $db,
            $table: $db.ingredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LogLinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LogLinesTable,
          LogLine,
          $$LogLinesTableFilterComposer,
          $$LogLinesTableOrderingComposer,
          $$LogLinesTableAnnotationComposer,
          $$LogLinesTableCreateCompanionBuilder,
          $$LogLinesTableUpdateCompanionBuilder,
          (LogLine, $$LogLinesTableReferences),
          LogLine,
          PrefetchHooks Function({bool entryId, bool ingredientId})
        > {
  $$LogLinesTableTableManager(_$AppDatabase db, $LogLinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogLinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogLinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogLinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<int?> ingredientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Unit> unit = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<double?> originalAmount = const Value.absent(),
                Value<double> refAmount = const Value.absent(),
                Value<double> refKcal = const Value.absent(),
                Value<double> refProtein = const Value.absent(),
              }) => LogLinesCompanion(
                id: id,
                entryId: entryId,
                ingredientId: ingredientId,
                name: name,
                unit: unit,
                amount: amount,
                originalAmount: originalAmount,
                refAmount: refAmount,
                refKcal: refKcal,
                refProtein: refProtein,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int entryId,
                Value<int?> ingredientId = const Value.absent(),
                required String name,
                required Unit unit,
                required double amount,
                Value<double?> originalAmount = const Value.absent(),
                required double refAmount,
                required double refKcal,
                required double refProtein,
              }) => LogLinesCompanion.insert(
                id: id,
                entryId: entryId,
                ingredientId: ingredientId,
                name: name,
                unit: unit,
                amount: amount,
                originalAmount: originalAmount,
                refAmount: refAmount,
                refKcal: refKcal,
                refProtein: refProtein,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LogLinesTable, LogLine>(table),
                  $$LogLinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false, ingredientId = false}) {
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
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$LogLinesTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$LogLinesTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (ingredientId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ingredientId,
                                referencedTable: $$LogLinesTableReferences
                                    ._ingredientIdTable(db),
                                referencedColumn: $$LogLinesTableReferences
                                    ._ingredientIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$LogLinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LogLinesTable,
      LogLine,
      $$LogLinesTableFilterComposer,
      $$LogLinesTableOrderingComposer,
      $$LogLinesTableAnnotationComposer,
      $$LogLinesTableCreateCompanionBuilder,
      $$LogLinesTableUpdateCompanionBuilder,
      (LogLine, $$LogLinesTableReferences),
      LogLine,
      PrefetchHooks Function({bool entryId, bool ingredientId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$IngredientsTableTableManager get ingredients =>
      $$IngredientsTableTableManager(_db, _db.ingredients);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeLinesTableTableManager get recipeLines =>
      $$RecipeLinesTableTableManager(_db, _db.recipeLines);
  $$LogEntriesTableTableManager get logEntries =>
      $$LogEntriesTableTableManager(_db, _db.logEntries);
  $$LogLinesTableTableManager get logLines =>
      $$LogLinesTableTableManager(_db, _db.logLines);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $MyListTable extends MyList with TableInfo<$MyListTable, MyListData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyListTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _showAllMeta = const VerificationMeta(
    'showAll',
  );
  @override
  late final GeneratedColumn<bool> showAll = GeneratedColumn<bool>(
    'show_all',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("show_all" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _todoListMeta = const VerificationMeta(
    'todoList',
  );
  @override
  late final GeneratedColumn<bool> todoList = GeneratedColumn<bool>(
    'todo_list',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("todo_list" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    showAll,
    lastModified,
    position,
    todoList,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_list';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyListData> instance, {
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
    if (data.containsKey('show_all')) {
      context.handle(
        _showAllMeta,
        showAll.isAcceptableOrUnknown(data['show_all']!, _showAllMeta),
      );
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('todo_list')) {
      context.handle(
        _todoListMeta,
        todoList.isAcceptableOrUnknown(data['todo_list']!, _todoListMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyListData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyListData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      showAll: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}show_all'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      todoList: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}todo_list'],
      )!,
    );
  }

  @override
  $MyListTable createAlias(String alias) {
    return $MyListTable(attachedDatabase, alias);
  }
}

class MyListData extends DataClass implements Insertable<MyListData> {
  final int id;
  final String name;
  final bool showAll;
  final String lastModified;
  final String position;
  final bool todoList;
  const MyListData({
    required this.id,
    required this.name,
    required this.showAll,
    required this.lastModified,
    required this.position,
    required this.todoList,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['show_all'] = Variable<bool>(showAll);
    map['last_modified'] = Variable<String>(lastModified);
    map['position'] = Variable<String>(position);
    map['todo_list'] = Variable<bool>(todoList);
    return map;
  }

  MyListCompanion toCompanion(bool nullToAbsent) {
    return MyListCompanion(
      id: Value(id),
      name: Value(name),
      showAll: Value(showAll),
      lastModified: Value(lastModified),
      position: Value(position),
      todoList: Value(todoList),
    );
  }

  factory MyListData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyListData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      showAll: serializer.fromJson<bool>(json['showAll']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      position: serializer.fromJson<String>(json['position']),
      todoList: serializer.fromJson<bool>(json['todoList']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'showAll': serializer.toJson<bool>(showAll),
      'lastModified': serializer.toJson<String>(lastModified),
      'position': serializer.toJson<String>(position),
      'todoList': serializer.toJson<bool>(todoList),
    };
  }

  MyListData copyWith({
    int? id,
    String? name,
    bool? showAll,
    String? lastModified,
    String? position,
    bool? todoList,
  }) => MyListData(
    id: id ?? this.id,
    name: name ?? this.name,
    showAll: showAll ?? this.showAll,
    lastModified: lastModified ?? this.lastModified,
    position: position ?? this.position,
    todoList: todoList ?? this.todoList,
  );
  MyListData copyWithCompanion(MyListCompanion data) {
    return MyListData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      showAll: data.showAll.present ? data.showAll.value : this.showAll,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      position: data.position.present ? data.position.value : this.position,
      todoList: data.todoList.present ? data.todoList.value : this.todoList,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyListData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('showAll: $showAll, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('todoList: $todoList')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, showAll, lastModified, position, todoList);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyListData &&
          other.id == this.id &&
          other.name == this.name &&
          other.showAll == this.showAll &&
          other.lastModified == this.lastModified &&
          other.position == this.position &&
          other.todoList == this.todoList);
}

class MyListCompanion extends UpdateCompanion<MyListData> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> showAll;
  final Value<String> lastModified;
  final Value<String> position;
  final Value<bool> todoList;
  const MyListCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.showAll = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.position = const Value.absent(),
    this.todoList = const Value.absent(),
  });
  MyListCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.showAll = const Value.absent(),
    required String lastModified,
    this.position = const Value.absent(),
    this.todoList = const Value.absent(),
  }) : name = Value(name),
       lastModified = Value(lastModified);
  static Insertable<MyListData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? showAll,
    Expression<String>? lastModified,
    Expression<String>? position,
    Expression<bool>? todoList,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (showAll != null) 'show_all': showAll,
      if (lastModified != null) 'last_modified': lastModified,
      if (position != null) 'position': position,
      if (todoList != null) 'todo_list': todoList,
    });
  }

  MyListCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? showAll,
    Value<String>? lastModified,
    Value<String>? position,
    Value<bool>? todoList,
  }) {
    return MyListCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      showAll: showAll ?? this.showAll,
      lastModified: lastModified ?? this.lastModified,
      position: position ?? this.position,
      todoList: todoList ?? this.todoList,
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
    if (showAll.present) {
      map['show_all'] = Variable<bool>(showAll.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<String>(lastModified.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (todoList.present) {
      map['todo_list'] = Variable<bool>(todoList.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyListCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('showAll: $showAll, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('todoList: $todoList')
          ..write(')'))
        .toString();
  }
}

class $MySublistTable extends MySublist
    with TableInfo<$MySublistTable, MySublistData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MySublistTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ancestorIdMeta = const VerificationMeta(
    'ancestorId',
  );
  @override
  late final GeneratedColumn<int> ancestorId = GeneratedColumn<int>(
    'ancestor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
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
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasListParentMeta = const VerificationMeta(
    'hasListParent',
  );
  @override
  late final GeneratedColumn<bool> hasListParent = GeneratedColumn<bool>(
    'has_list_parent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_list_parent" IN (0, 1))',
    ),
  );
  static const VerificationMeta _listParentMeta = const VerificationMeta(
    'listParent',
  );
  @override
  late final GeneratedColumn<int> listParent = GeneratedColumn<int>(
    'list_parent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES my_list (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sublistParentMeta = const VerificationMeta(
    'sublistParent',
  );
  @override
  late final GeneratedColumn<int> sublistParent = GeneratedColumn<int>(
    'sublist_parent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES my_sublist (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isShrinkedMeta = const VerificationMeta(
    'isShrinked',
  );
  @override
  late final GeneratedColumn<bool> isShrinked = GeneratedColumn<bool>(
    'is_shrinked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_shrinked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    ancestorId,
    id,
    name,
    lastModified,
    position,
    hasListParent,
    listParent,
    sublistParent,
    isShrinked,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_sublist';
  @override
  VerificationContext validateIntegrity(
    Insertable<MySublistData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ancestor_id')) {
      context.handle(
        _ancestorIdMeta,
        ancestorId.isAcceptableOrUnknown(data['ancestor_id']!, _ancestorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ancestorIdMeta);
    }
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
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('has_list_parent')) {
      context.handle(
        _hasListParentMeta,
        hasListParent.isAcceptableOrUnknown(
          data['has_list_parent']!,
          _hasListParentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasListParentMeta);
    }
    if (data.containsKey('list_parent')) {
      context.handle(
        _listParentMeta,
        listParent.isAcceptableOrUnknown(data['list_parent']!, _listParentMeta),
      );
    }
    if (data.containsKey('sublist_parent')) {
      context.handle(
        _sublistParentMeta,
        sublistParent.isAcceptableOrUnknown(
          data['sublist_parent']!,
          _sublistParentMeta,
        ),
      );
    }
    if (data.containsKey('is_shrinked')) {
      context.handle(
        _isShrinkedMeta,
        isShrinked.isAcceptableOrUnknown(data['is_shrinked']!, _isShrinkedMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MySublistData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MySublistData(
      ancestorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ancestor_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      hasListParent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_list_parent'],
      )!,
      listParent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_parent'],
      ),
      sublistParent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sublist_parent'],
      ),
      isShrinked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_shrinked'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
    );
  }

  @override
  $MySublistTable createAlias(String alias) {
    return $MySublistTable(attachedDatabase, alias);
  }
}

class MySublistData extends DataClass
    implements Insertable<MySublistData>, ElementBase {
  final int ancestorId;
  @override
  final int id;
  @override
  final String name;
  final String lastModified;
  @override
  final String position;
  @override
  final bool hasListParent;
  @override
  final int? listParent;
  @override
  final int? sublistParent;
  final bool isShrinked;
  @override
  final String notes;
  const MySublistData({
    required this.ancestorId,
    required this.id,
    required this.name,
    required this.lastModified,
    required this.position,
    required this.hasListParent,
    this.listParent,
    this.sublistParent,
    required this.isShrinked,
    required this.notes,
  });
  @override
  int getParentId() {
    if (hasListParent)
      return listParent!;
    else
      return sublistParent!;
  }

  @override
  bool hasRelatedItem() {
    return false;
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ancestor_id'] = Variable<int>(ancestorId);
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_modified'] = Variable<String>(lastModified);
    map['position'] = Variable<String>(position);
    map['has_list_parent'] = Variable<bool>(hasListParent);
    if (!nullToAbsent || listParent != null) {
      map['list_parent'] = Variable<int>(listParent);
    }
    if (!nullToAbsent || sublistParent != null) {
      map['sublist_parent'] = Variable<int>(sublistParent);
    }
    map['is_shrinked'] = Variable<bool>(isShrinked);
    map['notes'] = Variable<String>(notes);
    return map;
  }

  MySublistCompanion toCompanion(bool nullToAbsent) {
    return MySublistCompanion(
      ancestorId: Value(ancestorId),
      id: Value(id),
      name: Value(name),
      lastModified: Value(lastModified),
      position: Value(position),
      hasListParent: Value(hasListParent),
      listParent: listParent == null && nullToAbsent
          ? const Value.absent()
          : Value(listParent),
      sublistParent: sublistParent == null && nullToAbsent
          ? const Value.absent()
          : Value(sublistParent),
      isShrinked: Value(isShrinked),
      notes: Value(notes),
    );
  }

  factory MySublistData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MySublistData(
      ancestorId: serializer.fromJson<int>(json['ancestorId']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      position: serializer.fromJson<String>(json['position']),
      hasListParent: serializer.fromJson<bool>(json['hasListParent']),
      listParent: serializer.fromJson<int?>(json['listParent']),
      sublistParent: serializer.fromJson<int?>(json['sublistParent']),
      isShrinked: serializer.fromJson<bool>(json['isShrinked']),
      notes: serializer.fromJson<String>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ancestorId': serializer.toJson<int>(ancestorId),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastModified': serializer.toJson<String>(lastModified),
      'position': serializer.toJson<String>(position),
      'hasListParent': serializer.toJson<bool>(hasListParent),
      'listParent': serializer.toJson<int?>(listParent),
      'sublistParent': serializer.toJson<int?>(sublistParent),
      'isShrinked': serializer.toJson<bool>(isShrinked),
      'notes': serializer.toJson<String>(notes),
    };
  }

  MySublistData copyWith({
    int? ancestorId,
    int? id,
    String? name,
    String? lastModified,
    String? position,
    bool? hasListParent,
    Value<int?> listParent = const Value.absent(),
    Value<int?> sublistParent = const Value.absent(),
    bool? isShrinked,
    String? notes,
  }) => MySublistData(
    ancestorId: ancestorId ?? this.ancestorId,
    id: id ?? this.id,
    name: name ?? this.name,
    lastModified: lastModified ?? this.lastModified,
    position: position ?? this.position,
    hasListParent: hasListParent ?? this.hasListParent,
    listParent: listParent.present ? listParent.value : this.listParent,
    sublistParent: sublistParent.present
        ? sublistParent.value
        : this.sublistParent,
    isShrinked: isShrinked ?? this.isShrinked,
    notes: notes ?? this.notes,
  );
  MySublistData copyWithCompanion(MySublistCompanion data) {
    return MySublistData(
      ancestorId: data.ancestorId.present
          ? data.ancestorId.value
          : this.ancestorId,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      position: data.position.present ? data.position.value : this.position,
      hasListParent: data.hasListParent.present
          ? data.hasListParent.value
          : this.hasListParent,
      listParent: data.listParent.present
          ? data.listParent.value
          : this.listParent,
      sublistParent: data.sublistParent.present
          ? data.sublistParent.value
          : this.sublistParent,
      isShrinked: data.isShrinked.present
          ? data.isShrinked.value
          : this.isShrinked,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MySublistData(')
          ..write('ancestorId: $ancestorId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('hasListParent: $hasListParent, ')
          ..write('listParent: $listParent, ')
          ..write('sublistParent: $sublistParent, ')
          ..write('isShrinked: $isShrinked, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ancestorId,
    id,
    name,
    lastModified,
    position,
    hasListParent,
    listParent,
    sublistParent,
    isShrinked,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MySublistData &&
          other.ancestorId == this.ancestorId &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastModified == this.lastModified &&
          other.position == this.position &&
          other.hasListParent == this.hasListParent &&
          other.listParent == this.listParent &&
          other.sublistParent == this.sublistParent &&
          other.isShrinked == this.isShrinked &&
          other.notes == this.notes);
}

class MySublistCompanion extends UpdateCompanion<MySublistData> {
  final Value<int> ancestorId;
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastModified;
  final Value<String> position;
  final Value<bool> hasListParent;
  final Value<int?> listParent;
  final Value<int?> sublistParent;
  final Value<bool> isShrinked;
  final Value<String> notes;
  const MySublistCompanion({
    this.ancestorId = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.position = const Value.absent(),
    this.hasListParent = const Value.absent(),
    this.listParent = const Value.absent(),
    this.sublistParent = const Value.absent(),
    this.isShrinked = const Value.absent(),
    this.notes = const Value.absent(),
  });
  MySublistCompanion.insert({
    required int ancestorId,
    this.id = const Value.absent(),
    required String name,
    required String lastModified,
    required String position,
    required bool hasListParent,
    this.listParent = const Value.absent(),
    this.sublistParent = const Value.absent(),
    this.isShrinked = const Value.absent(),
    required String notes,
  }) : ancestorId = Value(ancestorId),
       name = Value(name),
       lastModified = Value(lastModified),
       position = Value(position),
       hasListParent = Value(hasListParent),
       notes = Value(notes);
  static Insertable<MySublistData> custom({
    Expression<int>? ancestorId,
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? lastModified,
    Expression<String>? position,
    Expression<bool>? hasListParent,
    Expression<int>? listParent,
    Expression<int>? sublistParent,
    Expression<bool>? isShrinked,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (ancestorId != null) 'ancestor_id': ancestorId,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastModified != null) 'last_modified': lastModified,
      if (position != null) 'position': position,
      if (hasListParent != null) 'has_list_parent': hasListParent,
      if (listParent != null) 'list_parent': listParent,
      if (sublistParent != null) 'sublist_parent': sublistParent,
      if (isShrinked != null) 'is_shrinked': isShrinked,
      if (notes != null) 'notes': notes,
    });
  }

  MySublistCompanion copyWith({
    Value<int>? ancestorId,
    Value<int>? id,
    Value<String>? name,
    Value<String>? lastModified,
    Value<String>? position,
    Value<bool>? hasListParent,
    Value<int?>? listParent,
    Value<int?>? sublistParent,
    Value<bool>? isShrinked,
    Value<String>? notes,
  }) {
    return MySublistCompanion(
      ancestorId: ancestorId ?? this.ancestorId,
      id: id ?? this.id,
      name: name ?? this.name,
      lastModified: lastModified ?? this.lastModified,
      position: position ?? this.position,
      hasListParent: hasListParent ?? this.hasListParent,
      listParent: listParent ?? this.listParent,
      sublistParent: sublistParent ?? this.sublistParent,
      isShrinked: isShrinked ?? this.isShrinked,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ancestorId.present) {
      map['ancestor_id'] = Variable<int>(ancestorId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<String>(lastModified.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (hasListParent.present) {
      map['has_list_parent'] = Variable<bool>(hasListParent.value);
    }
    if (listParent.present) {
      map['list_parent'] = Variable<int>(listParent.value);
    }
    if (sublistParent.present) {
      map['sublist_parent'] = Variable<int>(sublistParent.value);
    }
    if (isShrinked.present) {
      map['is_shrinked'] = Variable<bool>(isShrinked.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MySublistCompanion(')
          ..write('ancestorId: $ancestorId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('hasListParent: $hasListParent, ')
          ..write('listParent: $listParent, ')
          ..write('sublistParent: $sublistParent, ')
          ..write('isShrinked: $isShrinked, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $MyElementTable extends MyElement
    with TableInfo<$MyElementTable, MyElementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MyElementTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _ancestorIdMeta = const VerificationMeta(
    'ancestorId',
  );
  @override
  late final GeneratedColumn<int> ancestorId = GeneratedColumn<int>(
    'ancestor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
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
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hasListParentMeta = const VerificationMeta(
    'hasListParent',
  );
  @override
  late final GeneratedColumn<bool> hasListParent = GeneratedColumn<bool>(
    'has_list_parent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_list_parent" IN (0, 1))',
    ),
  );
  static const VerificationMeta _listParentMeta = const VerificationMeta(
    'listParent',
  );
  @override
  late final GeneratedColumn<int> listParent = GeneratedColumn<int>(
    'list_parent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES my_list (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sublistParentMeta = const VerificationMeta(
    'sublistParent',
  );
  @override
  late final GeneratedColumn<int> sublistParent = GeneratedColumn<int>(
    'sublist_parent',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES my_sublist (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isCheckedMeta = const VerificationMeta(
    'isChecked',
  );
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
    'is_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskIdRelatedMeta = const VerificationMeta(
    'taskIdRelated',
  );
  @override
  late final GeneratedColumn<int> taskIdRelated = GeneratedColumn<int>(
    'task_id_related',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _todoitemIdRelatedMeta = const VerificationMeta(
    'todoitemIdRelated',
  );
  @override
  late final GeneratedColumn<int> todoitemIdRelated = GeneratedColumn<int>(
    'todoitem_id_related',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  @override
  List<GeneratedColumn> get $columns => [
    ancestorId,
    id,
    name,
    lastModified,
    position,
    hasListParent,
    listParent,
    sublistParent,
    isChecked,
    notes,
    taskIdRelated,
    todoitemIdRelated,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_element';
  @override
  VerificationContext validateIntegrity(
    Insertable<MyElementData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('ancestor_id')) {
      context.handle(
        _ancestorIdMeta,
        ancestorId.isAcceptableOrUnknown(data['ancestor_id']!, _ancestorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ancestorIdMeta);
    }
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
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('has_list_parent')) {
      context.handle(
        _hasListParentMeta,
        hasListParent.isAcceptableOrUnknown(
          data['has_list_parent']!,
          _hasListParentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hasListParentMeta);
    }
    if (data.containsKey('list_parent')) {
      context.handle(
        _listParentMeta,
        listParent.isAcceptableOrUnknown(data['list_parent']!, _listParentMeta),
      );
    }
    if (data.containsKey('sublist_parent')) {
      context.handle(
        _sublistParentMeta,
        sublistParent.isAcceptableOrUnknown(
          data['sublist_parent']!,
          _sublistParentMeta,
        ),
      );
    }
    if (data.containsKey('is_checked')) {
      context.handle(
        _isCheckedMeta,
        isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('task_id_related')) {
      context.handle(
        _taskIdRelatedMeta,
        taskIdRelated.isAcceptableOrUnknown(
          data['task_id_related']!,
          _taskIdRelatedMeta,
        ),
      );
    }
    if (data.containsKey('todoitem_id_related')) {
      context.handle(
        _todoitemIdRelatedMeta,
        todoitemIdRelated.isAcceptableOrUnknown(
          data['todoitem_id_related']!,
          _todoitemIdRelatedMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MyElementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MyElementData(
      ancestorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ancestor_id'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      hasListParent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_list_parent'],
      )!,
      listParent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_parent'],
      ),
      sublistParent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sublist_parent'],
      ),
      isChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_checked'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      taskIdRelated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}task_id_related'],
      ),
      todoitemIdRelated: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}todoitem_id_related'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $MyElementTable createAlias(String alias) {
    return $MyElementTable(attachedDatabase, alias);
  }
}

class MyElementData extends DataClass
    implements Insertable<MyElementData>, ElementBase {
  @override
  final int ancestorId;
  @override
  final int id;
  @override
  final String name;
  final String lastModified;
  @override
  final String position;
  @override
  final bool hasListParent;
  @override
  final int? listParent;
  @override
  final int? sublistParent;
  final bool isChecked;
  @override
  final String notes;
  final int? taskIdRelated;
  final int? todoitemIdRelated;
  final String tags;
  const MyElementData({
    required this.ancestorId,
    required this.id,
    required this.name,
    required this.lastModified,
    required this.position,
    required this.hasListParent,
    this.listParent,
    this.sublistParent,
    required this.isChecked,
    required this.notes,
    this.taskIdRelated,
    this.todoitemIdRelated,
    required this.tags,
  });
  @override
  int getParentId() {
    if (hasListParent)
      return listParent!;
    else
      return sublistParent!;
  }

  @override
  bool hasRelatedItem() {
    return (taskIdRelated != null || todoitemIdRelated != null);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['ancestor_id'] = Variable<int>(ancestorId);
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_modified'] = Variable<String>(lastModified);
    map['position'] = Variable<String>(position);
    map['has_list_parent'] = Variable<bool>(hasListParent);
    if (!nullToAbsent || listParent != null) {
      map['list_parent'] = Variable<int>(listParent);
    }
    if (!nullToAbsent || sublistParent != null) {
      map['sublist_parent'] = Variable<int>(sublistParent);
    }
    map['is_checked'] = Variable<bool>(isChecked);
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || taskIdRelated != null) {
      map['task_id_related'] = Variable<int>(taskIdRelated);
    }
    if (!nullToAbsent || todoitemIdRelated != null) {
      map['todoitem_id_related'] = Variable<int>(todoitemIdRelated);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  MyElementCompanion toCompanion(bool nullToAbsent) {
    return MyElementCompanion(
      ancestorId: Value(ancestorId),
      id: Value(id),
      name: Value(name),
      lastModified: Value(lastModified),
      position: Value(position),
      hasListParent: Value(hasListParent),
      listParent: listParent == null && nullToAbsent
          ? const Value.absent()
          : Value(listParent),
      sublistParent: sublistParent == null && nullToAbsent
          ? const Value.absent()
          : Value(sublistParent),
      isChecked: Value(isChecked),
      notes: Value(notes),
      taskIdRelated: taskIdRelated == null && nullToAbsent
          ? const Value.absent()
          : Value(taskIdRelated),
      todoitemIdRelated: todoitemIdRelated == null && nullToAbsent
          ? const Value.absent()
          : Value(todoitemIdRelated),
      tags: Value(tags),
    );
  }

  factory MyElementData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MyElementData(
      ancestorId: serializer.fromJson<int>(json['ancestorId']),
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      position: serializer.fromJson<String>(json['position']),
      hasListParent: serializer.fromJson<bool>(json['hasListParent']),
      listParent: serializer.fromJson<int?>(json['listParent']),
      sublistParent: serializer.fromJson<int?>(json['sublistParent']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      notes: serializer.fromJson<String>(json['notes']),
      taskIdRelated: serializer.fromJson<int?>(json['taskIdRelated']),
      todoitemIdRelated: serializer.fromJson<int?>(json['todoitemIdRelated']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'ancestorId': serializer.toJson<int>(ancestorId),
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastModified': serializer.toJson<String>(lastModified),
      'position': serializer.toJson<String>(position),
      'hasListParent': serializer.toJson<bool>(hasListParent),
      'listParent': serializer.toJson<int?>(listParent),
      'sublistParent': serializer.toJson<int?>(sublistParent),
      'isChecked': serializer.toJson<bool>(isChecked),
      'notes': serializer.toJson<String>(notes),
      'taskIdRelated': serializer.toJson<int?>(taskIdRelated),
      'todoitemIdRelated': serializer.toJson<int?>(todoitemIdRelated),
      'tags': serializer.toJson<String>(tags),
    };
  }

  MyElementData copyWith({
    int? ancestorId,
    int? id,
    String? name,
    String? lastModified,
    String? position,
    bool? hasListParent,
    Value<int?> listParent = const Value.absent(),
    Value<int?> sublistParent = const Value.absent(),
    bool? isChecked,
    String? notes,
    Value<int?> taskIdRelated = const Value.absent(),
    Value<int?> todoitemIdRelated = const Value.absent(),
    String? tags,
  }) => MyElementData(
    ancestorId: ancestorId ?? this.ancestorId,
    id: id ?? this.id,
    name: name ?? this.name,
    lastModified: lastModified ?? this.lastModified,
    position: position ?? this.position,
    hasListParent: hasListParent ?? this.hasListParent,
    listParent: listParent.present ? listParent.value : this.listParent,
    sublistParent: sublistParent.present
        ? sublistParent.value
        : this.sublistParent,
    isChecked: isChecked ?? this.isChecked,
    notes: notes ?? this.notes,
    taskIdRelated: taskIdRelated.present
        ? taskIdRelated.value
        : this.taskIdRelated,
    todoitemIdRelated: todoitemIdRelated.present
        ? todoitemIdRelated.value
        : this.todoitemIdRelated,
    tags: tags ?? this.tags,
  );
  MyElementData copyWithCompanion(MyElementCompanion data) {
    return MyElementData(
      ancestorId: data.ancestorId.present
          ? data.ancestorId.value
          : this.ancestorId,
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      position: data.position.present ? data.position.value : this.position,
      hasListParent: data.hasListParent.present
          ? data.hasListParent.value
          : this.hasListParent,
      listParent: data.listParent.present
          ? data.listParent.value
          : this.listParent,
      sublistParent: data.sublistParent.present
          ? data.sublistParent.value
          : this.sublistParent,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      notes: data.notes.present ? data.notes.value : this.notes,
      taskIdRelated: data.taskIdRelated.present
          ? data.taskIdRelated.value
          : this.taskIdRelated,
      todoitemIdRelated: data.todoitemIdRelated.present
          ? data.todoitemIdRelated.value
          : this.todoitemIdRelated,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MyElementData(')
          ..write('ancestorId: $ancestorId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('hasListParent: $hasListParent, ')
          ..write('listParent: $listParent, ')
          ..write('sublistParent: $sublistParent, ')
          ..write('isChecked: $isChecked, ')
          ..write('notes: $notes, ')
          ..write('taskIdRelated: $taskIdRelated, ')
          ..write('todoitemIdRelated: $todoitemIdRelated, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    ancestorId,
    id,
    name,
    lastModified,
    position,
    hasListParent,
    listParent,
    sublistParent,
    isChecked,
    notes,
    taskIdRelated,
    todoitemIdRelated,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MyElementData &&
          other.ancestorId == this.ancestorId &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastModified == this.lastModified &&
          other.position == this.position &&
          other.hasListParent == this.hasListParent &&
          other.listParent == this.listParent &&
          other.sublistParent == this.sublistParent &&
          other.isChecked == this.isChecked &&
          other.notes == this.notes &&
          other.taskIdRelated == this.taskIdRelated &&
          other.todoitemIdRelated == this.todoitemIdRelated &&
          other.tags == this.tags);
}

class MyElementCompanion extends UpdateCompanion<MyElementData> {
  final Value<int> ancestorId;
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastModified;
  final Value<String> position;
  final Value<bool> hasListParent;
  final Value<int?> listParent;
  final Value<int?> sublistParent;
  final Value<bool> isChecked;
  final Value<String> notes;
  final Value<int?> taskIdRelated;
  final Value<int?> todoitemIdRelated;
  final Value<String> tags;
  const MyElementCompanion({
    this.ancestorId = const Value.absent(),
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.position = const Value.absent(),
    this.hasListParent = const Value.absent(),
    this.listParent = const Value.absent(),
    this.sublistParent = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.notes = const Value.absent(),
    this.taskIdRelated = const Value.absent(),
    this.todoitemIdRelated = const Value.absent(),
    this.tags = const Value.absent(),
  });
  MyElementCompanion.insert({
    required int ancestorId,
    this.id = const Value.absent(),
    required String name,
    required String lastModified,
    required String position,
    required bool hasListParent,
    this.listParent = const Value.absent(),
    this.sublistParent = const Value.absent(),
    this.isChecked = const Value.absent(),
    required String notes,
    this.taskIdRelated = const Value.absent(),
    this.todoitemIdRelated = const Value.absent(),
    this.tags = const Value.absent(),
  }) : ancestorId = Value(ancestorId),
       name = Value(name),
       lastModified = Value(lastModified),
       position = Value(position),
       hasListParent = Value(hasListParent),
       notes = Value(notes);
  static Insertable<MyElementData> custom({
    Expression<int>? ancestorId,
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? lastModified,
    Expression<String>? position,
    Expression<bool>? hasListParent,
    Expression<int>? listParent,
    Expression<int>? sublistParent,
    Expression<bool>? isChecked,
    Expression<String>? notes,
    Expression<int>? taskIdRelated,
    Expression<int>? todoitemIdRelated,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (ancestorId != null) 'ancestor_id': ancestorId,
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastModified != null) 'last_modified': lastModified,
      if (position != null) 'position': position,
      if (hasListParent != null) 'has_list_parent': hasListParent,
      if (listParent != null) 'list_parent': listParent,
      if (sublistParent != null) 'sublist_parent': sublistParent,
      if (isChecked != null) 'is_checked': isChecked,
      if (notes != null) 'notes': notes,
      if (taskIdRelated != null) 'task_id_related': taskIdRelated,
      if (todoitemIdRelated != null) 'todoitem_id_related': todoitemIdRelated,
      if (tags != null) 'tags': tags,
    });
  }

  MyElementCompanion copyWith({
    Value<int>? ancestorId,
    Value<int>? id,
    Value<String>? name,
    Value<String>? lastModified,
    Value<String>? position,
    Value<bool>? hasListParent,
    Value<int?>? listParent,
    Value<int?>? sublistParent,
    Value<bool>? isChecked,
    Value<String>? notes,
    Value<int?>? taskIdRelated,
    Value<int?>? todoitemIdRelated,
    Value<String>? tags,
  }) {
    return MyElementCompanion(
      ancestorId: ancestorId ?? this.ancestorId,
      id: id ?? this.id,
      name: name ?? this.name,
      lastModified: lastModified ?? this.lastModified,
      position: position ?? this.position,
      hasListParent: hasListParent ?? this.hasListParent,
      listParent: listParent ?? this.listParent,
      sublistParent: sublistParent ?? this.sublistParent,
      isChecked: isChecked ?? this.isChecked,
      notes: notes ?? this.notes,
      taskIdRelated: taskIdRelated ?? this.taskIdRelated,
      todoitemIdRelated: todoitemIdRelated ?? this.todoitemIdRelated,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (ancestorId.present) {
      map['ancestor_id'] = Variable<int>(ancestorId.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<String>(lastModified.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (hasListParent.present) {
      map['has_list_parent'] = Variable<bool>(hasListParent.value);
    }
    if (listParent.present) {
      map['list_parent'] = Variable<int>(listParent.value);
    }
    if (sublistParent.present) {
      map['sublist_parent'] = Variable<int>(sublistParent.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (taskIdRelated.present) {
      map['task_id_related'] = Variable<int>(taskIdRelated.value);
    }
    if (todoitemIdRelated.present) {
      map['todoitem_id_related'] = Variable<int>(todoitemIdRelated.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MyElementCompanion(')
          ..write('ancestorId: $ancestorId, ')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('hasListParent: $hasListParent, ')
          ..write('listParent: $listParent, ')
          ..write('sublistParent: $sublistParent, ')
          ..write('isChecked: $isChecked, ')
          ..write('notes: $notes, ')
          ..write('taskIdRelated: $taskIdRelated, ')
          ..write('todoitemIdRelated: $todoitemIdRelated, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $DbSettingsTable extends DbSettings
    with TableInfo<$DbSettingsTable, DbSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbSettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _maxListIdMeta = const VerificationMeta(
    'maxListId',
  );
  @override
  late final GeneratedColumn<int> maxListId = GeneratedColumn<int>(
    'max_list_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxElementIdMeta = const VerificationMeta(
    'maxElementId',
  );
  @override
  late final GeneratedColumn<int> maxElementId = GeneratedColumn<int>(
    'max_element_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxTodoListIdMeta = const VerificationMeta(
    'maxTodoListId',
  );
  @override
  late final GeneratedColumn<int> maxTodoListId = GeneratedColumn<int>(
    'max_todo_list_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxTodoItemIdMeta = const VerificationMeta(
    'maxTodoItemId',
  );
  @override
  late final GeneratedColumn<int> maxTodoItemId = GeneratedColumn<int>(
    'max_todo_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannerShowAllMeta = const VerificationMeta(
    'plannerShowAll',
  );
  @override
  late final GeneratedColumn<bool> plannerShowAll = GeneratedColumn<bool>(
    'planner_show_all',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("planner_show_all" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    maxListId,
    maxElementId,
    maxTodoListId,
    maxTodoItemId,
    plannerShowAll,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<DbSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('max_list_id')) {
      context.handle(
        _maxListIdMeta,
        maxListId.isAcceptableOrUnknown(data['max_list_id']!, _maxListIdMeta),
      );
    } else if (isInserting) {
      context.missing(_maxListIdMeta);
    }
    if (data.containsKey('max_element_id')) {
      context.handle(
        _maxElementIdMeta,
        maxElementId.isAcceptableOrUnknown(
          data['max_element_id']!,
          _maxElementIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxElementIdMeta);
    }
    if (data.containsKey('max_todo_list_id')) {
      context.handle(
        _maxTodoListIdMeta,
        maxTodoListId.isAcceptableOrUnknown(
          data['max_todo_list_id']!,
          _maxTodoListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxTodoListIdMeta);
    }
    if (data.containsKey('max_todo_item_id')) {
      context.handle(
        _maxTodoItemIdMeta,
        maxTodoItemId.isAcceptableOrUnknown(
          data['max_todo_item_id']!,
          _maxTodoItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maxTodoItemIdMeta);
    }
    if (data.containsKey('planner_show_all')) {
      context.handle(
        _plannerShowAllMeta,
        plannerShowAll.isAcceptableOrUnknown(
          data['planner_show_all']!,
          _plannerShowAllMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_plannerShowAllMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      maxListId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_list_id'],
      )!,
      maxElementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_element_id'],
      )!,
      maxTodoListId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_todo_list_id'],
      )!,
      maxTodoItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_todo_item_id'],
      )!,
      plannerShowAll: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}planner_show_all'],
      )!,
    );
  }

  @override
  $DbSettingsTable createAlias(String alias) {
    return $DbSettingsTable(attachedDatabase, alias);
  }
}

class DbSetting extends DataClass implements Insertable<DbSetting> {
  final int id;
  final int maxListId;
  final int maxElementId;
  final int maxTodoListId;
  final int maxTodoItemId;
  final bool plannerShowAll;
  const DbSetting({
    required this.id,
    required this.maxListId,
    required this.maxElementId,
    required this.maxTodoListId,
    required this.maxTodoItemId,
    required this.plannerShowAll,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['max_list_id'] = Variable<int>(maxListId);
    map['max_element_id'] = Variable<int>(maxElementId);
    map['max_todo_list_id'] = Variable<int>(maxTodoListId);
    map['max_todo_item_id'] = Variable<int>(maxTodoItemId);
    map['planner_show_all'] = Variable<bool>(plannerShowAll);
    return map;
  }

  DbSettingsCompanion toCompanion(bool nullToAbsent) {
    return DbSettingsCompanion(
      id: Value(id),
      maxListId: Value(maxListId),
      maxElementId: Value(maxElementId),
      maxTodoListId: Value(maxTodoListId),
      maxTodoItemId: Value(maxTodoItemId),
      plannerShowAll: Value(plannerShowAll),
    );
  }

  factory DbSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbSetting(
      id: serializer.fromJson<int>(json['id']),
      maxListId: serializer.fromJson<int>(json['maxListId']),
      maxElementId: serializer.fromJson<int>(json['maxElementId']),
      maxTodoListId: serializer.fromJson<int>(json['maxTodoListId']),
      maxTodoItemId: serializer.fromJson<int>(json['maxTodoItemId']),
      plannerShowAll: serializer.fromJson<bool>(json['plannerShowAll']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'maxListId': serializer.toJson<int>(maxListId),
      'maxElementId': serializer.toJson<int>(maxElementId),
      'maxTodoListId': serializer.toJson<int>(maxTodoListId),
      'maxTodoItemId': serializer.toJson<int>(maxTodoItemId),
      'plannerShowAll': serializer.toJson<bool>(plannerShowAll),
    };
  }

  DbSetting copyWith({
    int? id,
    int? maxListId,
    int? maxElementId,
    int? maxTodoListId,
    int? maxTodoItemId,
    bool? plannerShowAll,
  }) => DbSetting(
    id: id ?? this.id,
    maxListId: maxListId ?? this.maxListId,
    maxElementId: maxElementId ?? this.maxElementId,
    maxTodoListId: maxTodoListId ?? this.maxTodoListId,
    maxTodoItemId: maxTodoItemId ?? this.maxTodoItemId,
    plannerShowAll: plannerShowAll ?? this.plannerShowAll,
  );
  DbSetting copyWithCompanion(DbSettingsCompanion data) {
    return DbSetting(
      id: data.id.present ? data.id.value : this.id,
      maxListId: data.maxListId.present ? data.maxListId.value : this.maxListId,
      maxElementId: data.maxElementId.present
          ? data.maxElementId.value
          : this.maxElementId,
      maxTodoListId: data.maxTodoListId.present
          ? data.maxTodoListId.value
          : this.maxTodoListId,
      maxTodoItemId: data.maxTodoItemId.present
          ? data.maxTodoItemId.value
          : this.maxTodoItemId,
      plannerShowAll: data.plannerShowAll.present
          ? data.plannerShowAll.value
          : this.plannerShowAll,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbSetting(')
          ..write('id: $id, ')
          ..write('maxListId: $maxListId, ')
          ..write('maxElementId: $maxElementId, ')
          ..write('maxTodoListId: $maxTodoListId, ')
          ..write('maxTodoItemId: $maxTodoItemId, ')
          ..write('plannerShowAll: $plannerShowAll')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    maxListId,
    maxElementId,
    maxTodoListId,
    maxTodoItemId,
    plannerShowAll,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbSetting &&
          other.id == this.id &&
          other.maxListId == this.maxListId &&
          other.maxElementId == this.maxElementId &&
          other.maxTodoListId == this.maxTodoListId &&
          other.maxTodoItemId == this.maxTodoItemId &&
          other.plannerShowAll == this.plannerShowAll);
}

class DbSettingsCompanion extends UpdateCompanion<DbSetting> {
  final Value<int> id;
  final Value<int> maxListId;
  final Value<int> maxElementId;
  final Value<int> maxTodoListId;
  final Value<int> maxTodoItemId;
  final Value<bool> plannerShowAll;
  const DbSettingsCompanion({
    this.id = const Value.absent(),
    this.maxListId = const Value.absent(),
    this.maxElementId = const Value.absent(),
    this.maxTodoListId = const Value.absent(),
    this.maxTodoItemId = const Value.absent(),
    this.plannerShowAll = const Value.absent(),
  });
  DbSettingsCompanion.insert({
    this.id = const Value.absent(),
    required int maxListId,
    required int maxElementId,
    required int maxTodoListId,
    required int maxTodoItemId,
    required bool plannerShowAll,
  }) : maxListId = Value(maxListId),
       maxElementId = Value(maxElementId),
       maxTodoListId = Value(maxTodoListId),
       maxTodoItemId = Value(maxTodoItemId),
       plannerShowAll = Value(plannerShowAll);
  static Insertable<DbSetting> custom({
    Expression<int>? id,
    Expression<int>? maxListId,
    Expression<int>? maxElementId,
    Expression<int>? maxTodoListId,
    Expression<int>? maxTodoItemId,
    Expression<bool>? plannerShowAll,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (maxListId != null) 'max_list_id': maxListId,
      if (maxElementId != null) 'max_element_id': maxElementId,
      if (maxTodoListId != null) 'max_todo_list_id': maxTodoListId,
      if (maxTodoItemId != null) 'max_todo_item_id': maxTodoItemId,
      if (plannerShowAll != null) 'planner_show_all': plannerShowAll,
    });
  }

  DbSettingsCompanion copyWith({
    Value<int>? id,
    Value<int>? maxListId,
    Value<int>? maxElementId,
    Value<int>? maxTodoListId,
    Value<int>? maxTodoItemId,
    Value<bool>? plannerShowAll,
  }) {
    return DbSettingsCompanion(
      id: id ?? this.id,
      maxListId: maxListId ?? this.maxListId,
      maxElementId: maxElementId ?? this.maxElementId,
      maxTodoListId: maxTodoListId ?? this.maxTodoListId,
      maxTodoItemId: maxTodoItemId ?? this.maxTodoItemId,
      plannerShowAll: plannerShowAll ?? this.plannerShowAll,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (maxListId.present) {
      map['max_list_id'] = Variable<int>(maxListId.value);
    }
    if (maxElementId.present) {
      map['max_element_id'] = Variable<int>(maxElementId.value);
    }
    if (maxTodoListId.present) {
      map['max_todo_list_id'] = Variable<int>(maxTodoListId.value);
    }
    if (maxTodoItemId.present) {
      map['max_todo_item_id'] = Variable<int>(maxTodoItemId.value);
    }
    if (plannerShowAll.present) {
      map['planner_show_all'] = Variable<bool>(plannerShowAll.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbSettingsCompanion(')
          ..write('id: $id, ')
          ..write('maxListId: $maxListId, ')
          ..write('maxElementId: $maxElementId, ')
          ..write('maxTodoListId: $maxTodoListId, ')
          ..write('maxTodoItemId: $maxTodoItemId, ')
          ..write('plannerShowAll: $plannerShowAll')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _isBackupNeededMeta = const VerificationMeta(
    'isBackupNeeded',
  );
  @override
  late final GeneratedColumn<bool> isBackupNeeded = GeneratedColumn<bool>(
    'is_backup_needed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_backup_needed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _lastBackupMeta = const VerificationMeta(
    'lastBackup',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackup = GeneratedColumn<DateTime>(
    'last_backup',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _loginMeta = const VerificationMeta('login');
  @override
  late final GeneratedColumn<int> login = GeneratedColumn<int>(
    'login',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deleteRelatedThingsMeta =
      const VerificationMeta('deleteRelatedThings');
  @override
  late final GeneratedColumn<bool> deleteRelatedThings = GeneratedColumn<bool>(
    'delete_related_things',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("delete_related_things" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    isBackupNeeded,
    lastBackup,
    login,
    deleteRelatedThings,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('is_backup_needed')) {
      context.handle(
        _isBackupNeededMeta,
        isBackupNeeded.isAcceptableOrUnknown(
          data['is_backup_needed']!,
          _isBackupNeededMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isBackupNeededMeta);
    }
    if (data.containsKey('last_backup')) {
      context.handle(
        _lastBackupMeta,
        lastBackup.isAcceptableOrUnknown(data['last_backup']!, _lastBackupMeta),
      );
    } else if (isInserting) {
      context.missing(_lastBackupMeta);
    }
    if (data.containsKey('login')) {
      context.handle(
        _loginMeta,
        login.isAcceptableOrUnknown(data['login']!, _loginMeta),
      );
    } else if (isInserting) {
      context.missing(_loginMeta);
    }
    if (data.containsKey('delete_related_things')) {
      context.handle(
        _deleteRelatedThingsMeta,
        deleteRelatedThings.isAcceptableOrUnknown(
          data['delete_related_things']!,
          _deleteRelatedThingsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deleteRelatedThingsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      isBackupNeeded: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_backup_needed'],
      )!,
      lastBackup: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup'],
      )!,
      login: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}login'],
      )!,
      deleteRelatedThings: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}delete_related_things'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final int id;
  final bool isBackupNeeded;
  final DateTime lastBackup;
  final int login;
  final bool deleteRelatedThings;
  const Setting({
    required this.id,
    required this.isBackupNeeded,
    required this.lastBackup,
    required this.login,
    required this.deleteRelatedThings,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['is_backup_needed'] = Variable<bool>(isBackupNeeded);
    map['last_backup'] = Variable<DateTime>(lastBackup);
    map['login'] = Variable<int>(login);
    map['delete_related_things'] = Variable<bool>(deleteRelatedThings);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      isBackupNeeded: Value(isBackupNeeded),
      lastBackup: Value(lastBackup),
      login: Value(login),
      deleteRelatedThings: Value(deleteRelatedThings),
    );
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      id: serializer.fromJson<int>(json['id']),
      isBackupNeeded: serializer.fromJson<bool>(json['isBackupNeeded']),
      lastBackup: serializer.fromJson<DateTime>(json['lastBackup']),
      login: serializer.fromJson<int>(json['login']),
      deleteRelatedThings: serializer.fromJson<bool>(
        json['deleteRelatedThings'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'isBackupNeeded': serializer.toJson<bool>(isBackupNeeded),
      'lastBackup': serializer.toJson<DateTime>(lastBackup),
      'login': serializer.toJson<int>(login),
      'deleteRelatedThings': serializer.toJson<bool>(deleteRelatedThings),
    };
  }

  Setting copyWith({
    int? id,
    bool? isBackupNeeded,
    DateTime? lastBackup,
    int? login,
    bool? deleteRelatedThings,
  }) => Setting(
    id: id ?? this.id,
    isBackupNeeded: isBackupNeeded ?? this.isBackupNeeded,
    lastBackup: lastBackup ?? this.lastBackup,
    login: login ?? this.login,
    deleteRelatedThings: deleteRelatedThings ?? this.deleteRelatedThings,
  );
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      id: data.id.present ? data.id.value : this.id,
      isBackupNeeded: data.isBackupNeeded.present
          ? data.isBackupNeeded.value
          : this.isBackupNeeded,
      lastBackup: data.lastBackup.present
          ? data.lastBackup.value
          : this.lastBackup,
      login: data.login.present ? data.login.value : this.login,
      deleteRelatedThings: data.deleteRelatedThings.present
          ? data.deleteRelatedThings.value
          : this.deleteRelatedThings,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('id: $id, ')
          ..write('isBackupNeeded: $isBackupNeeded, ')
          ..write('lastBackup: $lastBackup, ')
          ..write('login: $login, ')
          ..write('deleteRelatedThings: $deleteRelatedThings')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, isBackupNeeded, lastBackup, login, deleteRelatedThings);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting &&
          other.id == this.id &&
          other.isBackupNeeded == this.isBackupNeeded &&
          other.lastBackup == this.lastBackup &&
          other.login == this.login &&
          other.deleteRelatedThings == this.deleteRelatedThings);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<int> id;
  final Value<bool> isBackupNeeded;
  final Value<DateTime> lastBackup;
  final Value<int> login;
  final Value<bool> deleteRelatedThings;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.isBackupNeeded = const Value.absent(),
    this.lastBackup = const Value.absent(),
    this.login = const Value.absent(),
    this.deleteRelatedThings = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    required bool isBackupNeeded,
    required DateTime lastBackup,
    required int login,
    required bool deleteRelatedThings,
  }) : isBackupNeeded = Value(isBackupNeeded),
       lastBackup = Value(lastBackup),
       login = Value(login),
       deleteRelatedThings = Value(deleteRelatedThings);
  static Insertable<Setting> custom({
    Expression<int>? id,
    Expression<bool>? isBackupNeeded,
    Expression<DateTime>? lastBackup,
    Expression<int>? login,
    Expression<bool>? deleteRelatedThings,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (isBackupNeeded != null) 'is_backup_needed': isBackupNeeded,
      if (lastBackup != null) 'last_backup': lastBackup,
      if (login != null) 'login': login,
      if (deleteRelatedThings != null)
        'delete_related_things': deleteRelatedThings,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? isBackupNeeded,
    Value<DateTime>? lastBackup,
    Value<int>? login,
    Value<bool>? deleteRelatedThings,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      isBackupNeeded: isBackupNeeded ?? this.isBackupNeeded,
      lastBackup: lastBackup ?? this.lastBackup,
      login: login ?? this.login,
      deleteRelatedThings: deleteRelatedThings ?? this.deleteRelatedThings,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (isBackupNeeded.present) {
      map['is_backup_needed'] = Variable<bool>(isBackupNeeded.value);
    }
    if (lastBackup.present) {
      map['last_backup'] = Variable<DateTime>(lastBackup.value);
    }
    if (login.present) {
      map['login'] = Variable<int>(login.value);
    }
    if (deleteRelatedThings.present) {
      map['delete_related_things'] = Variable<bool>(deleteRelatedThings.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('isBackupNeeded: $isBackupNeeded, ')
          ..write('lastBackup: $lastBackup, ')
          ..write('login: $login, ')
          ..write('deleteRelatedThings: $deleteRelatedThings')
          ..write(')'))
        .toString();
  }
}

class $TodoElementTable extends TodoElement
    with TableInfo<$TodoElementTable, TodoElementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodoElementTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _listParentMeta = const VerificationMeta(
    'listParent',
  );
  @override
  late final GeneratedColumn<int> listParent = GeneratedColumn<int>(
    'list_parent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES my_list (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _isCheckedMeta = const VerificationMeta(
    'isChecked',
  );
  @override
  late final GeneratedColumn<bool> isChecked = GeneratedColumn<bool>(
    'is_checked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_checked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relatedElementIdMeta = const VerificationMeta(
    'relatedElementId',
  );
  @override
  late final GeneratedColumn<int> relatedElementId = GeneratedColumn<int>(
    'related_element_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    lastModified,
    position,
    listParent,
    isChecked,
    notes,
    relatedElementId,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'todo_element';
  @override
  VerificationContext validateIntegrity(
    Insertable<TodoElementData> instance, {
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
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('list_parent')) {
      context.handle(
        _listParentMeta,
        listParent.isAcceptableOrUnknown(data['list_parent']!, _listParentMeta),
      );
    } else if (isInserting) {
      context.missing(_listParentMeta);
    }
    if (data.containsKey('is_checked')) {
      context.handle(
        _isCheckedMeta,
        isChecked.isAcceptableOrUnknown(data['is_checked']!, _isCheckedMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('related_element_id')) {
      context.handle(
        _relatedElementIdMeta,
        relatedElementId.isAcceptableOrUnknown(
          data['related_element_id']!,
          _relatedElementIdMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TodoElementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TodoElementData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      listParent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}list_parent'],
      )!,
      isChecked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_checked'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      relatedElementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_element_id'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $TodoElementTable createAlias(String alias) {
    return $TodoElementTable(attachedDatabase, alias);
  }
}

class TodoElementData extends DataClass
    implements Insertable<TodoElementData>, ElementBase {
  @override
  final int id;
  @override
  final String name;
  final String lastModified;
  @override
  final String position;
  @override
  final int listParent;
  final bool isChecked;
  @override
  final String notes;
  final int? relatedElementId;
  final String tags;
  const TodoElementData({
    required this.id,
    required this.name,
    required this.lastModified,
    required this.position,
    required this.listParent,
    required this.isChecked,
    required this.notes,
    this.relatedElementId,
    required this.tags,
  });
  @override
  bool get hasListParent => true;
  @override
  bool hasRelatedItem() => false;
  @override
  int getParentId() => listParent;
  @override
  int get ancestorId => listParent;
  @override
  int? get sublistParent => null;
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['last_modified'] = Variable<String>(lastModified);
    map['position'] = Variable<String>(position);
    map['list_parent'] = Variable<int>(listParent);
    map['is_checked'] = Variable<bool>(isChecked);
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || relatedElementId != null) {
      map['related_element_id'] = Variable<int>(relatedElementId);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  TodoElementCompanion toCompanion(bool nullToAbsent) {
    return TodoElementCompanion(
      id: Value(id),
      name: Value(name),
      lastModified: Value(lastModified),
      position: Value(position),
      listParent: Value(listParent),
      isChecked: Value(isChecked),
      notes: Value(notes),
      relatedElementId: relatedElementId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedElementId),
      tags: Value(tags),
    );
  }

  factory TodoElementData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TodoElementData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      position: serializer.fromJson<String>(json['position']),
      listParent: serializer.fromJson<int>(json['listParent']),
      isChecked: serializer.fromJson<bool>(json['isChecked']),
      notes: serializer.fromJson<String>(json['notes']),
      relatedElementId: serializer.fromJson<int?>(json['relatedElementId']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'lastModified': serializer.toJson<String>(lastModified),
      'position': serializer.toJson<String>(position),
      'listParent': serializer.toJson<int>(listParent),
      'isChecked': serializer.toJson<bool>(isChecked),
      'notes': serializer.toJson<String>(notes),
      'relatedElementId': serializer.toJson<int?>(relatedElementId),
      'tags': serializer.toJson<String>(tags),
    };
  }

  TodoElementData copyWith({
    int? id,
    String? name,
    String? lastModified,
    String? position,
    int? listParent,
    bool? isChecked,
    String? notes,
    Value<int?> relatedElementId = const Value.absent(),
    String? tags,
  }) => TodoElementData(
    id: id ?? this.id,
    name: name ?? this.name,
    lastModified: lastModified ?? this.lastModified,
    position: position ?? this.position,
    listParent: listParent ?? this.listParent,
    isChecked: isChecked ?? this.isChecked,
    notes: notes ?? this.notes,
    relatedElementId: relatedElementId.present
        ? relatedElementId.value
        : this.relatedElementId,
    tags: tags ?? this.tags,
  );
  TodoElementData copyWithCompanion(TodoElementCompanion data) {
    return TodoElementData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      position: data.position.present ? data.position.value : this.position,
      listParent: data.listParent.present
          ? data.listParent.value
          : this.listParent,
      isChecked: data.isChecked.present ? data.isChecked.value : this.isChecked,
      notes: data.notes.present ? data.notes.value : this.notes,
      relatedElementId: data.relatedElementId.present
          ? data.relatedElementId.value
          : this.relatedElementId,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TodoElementData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('listParent: $listParent, ')
          ..write('isChecked: $isChecked, ')
          ..write('notes: $notes, ')
          ..write('relatedElementId: $relatedElementId, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    lastModified,
    position,
    listParent,
    isChecked,
    notes,
    relatedElementId,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoElementData &&
          other.id == this.id &&
          other.name == this.name &&
          other.lastModified == this.lastModified &&
          other.position == this.position &&
          other.listParent == this.listParent &&
          other.isChecked == this.isChecked &&
          other.notes == this.notes &&
          other.relatedElementId == this.relatedElementId &&
          other.tags == this.tags);
}

class TodoElementCompanion extends UpdateCompanion<TodoElementData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> lastModified;
  final Value<String> position;
  final Value<int> listParent;
  final Value<bool> isChecked;
  final Value<String> notes;
  final Value<int?> relatedElementId;
  final Value<String> tags;
  const TodoElementCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.position = const Value.absent(),
    this.listParent = const Value.absent(),
    this.isChecked = const Value.absent(),
    this.notes = const Value.absent(),
    this.relatedElementId = const Value.absent(),
    this.tags = const Value.absent(),
  });
  TodoElementCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String lastModified,
    required String position,
    required int listParent,
    this.isChecked = const Value.absent(),
    required String notes,
    this.relatedElementId = const Value.absent(),
    this.tags = const Value.absent(),
  }) : name = Value(name),
       lastModified = Value(lastModified),
       position = Value(position),
       listParent = Value(listParent),
       notes = Value(notes);
  static Insertable<TodoElementData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? lastModified,
    Expression<String>? position,
    Expression<int>? listParent,
    Expression<bool>? isChecked,
    Expression<String>? notes,
    Expression<int>? relatedElementId,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (lastModified != null) 'last_modified': lastModified,
      if (position != null) 'position': position,
      if (listParent != null) 'list_parent': listParent,
      if (isChecked != null) 'is_checked': isChecked,
      if (notes != null) 'notes': notes,
      if (relatedElementId != null) 'related_element_id': relatedElementId,
      if (tags != null) 'tags': tags,
    });
  }

  TodoElementCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? lastModified,
    Value<String>? position,
    Value<int>? listParent,
    Value<bool>? isChecked,
    Value<String>? notes,
    Value<int?>? relatedElementId,
    Value<String>? tags,
  }) {
    return TodoElementCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      lastModified: lastModified ?? this.lastModified,
      position: position ?? this.position,
      listParent: listParent ?? this.listParent,
      isChecked: isChecked ?? this.isChecked,
      notes: notes ?? this.notes,
      relatedElementId: relatedElementId ?? this.relatedElementId,
      tags: tags ?? this.tags,
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
    if (lastModified.present) {
      map['last_modified'] = Variable<String>(lastModified.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (listParent.present) {
      map['list_parent'] = Variable<int>(listParent.value);
    }
    if (isChecked.present) {
      map['is_checked'] = Variable<bool>(isChecked.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (relatedElementId.present) {
      map['related_element_id'] = Variable<int>(relatedElementId.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodoElementCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('lastModified: $lastModified, ')
          ..write('position: $position, ')
          ..write('listParent: $listParent, ')
          ..write('isChecked: $isChecked, ')
          ..write('notes: $notes, ')
          ..write('relatedElementId: $relatedElementId, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $TaskTable extends Task with TableInfo<$TaskTable, TaskData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _creationTimeMeta = const VerificationMeta(
    'creationTime',
  );
  @override
  late final GeneratedColumn<String> creationTime = GeneratedColumn<String>(
    'creation_time',
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
  static const VerificationMeta _startingDayMeta = const VerificationMeta(
    'startingDay',
  );
  @override
  late final GeneratedColumn<String> startingDay = GeneratedColumn<String>(
    'starting_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishDayMeta = const VerificationMeta(
    'finishDay',
  );
  @override
  late final GeneratedColumn<String> finishDay = GeneratedColumn<String>(
    'finish_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flexibleTimeMeta = const VerificationMeta(
    'flexibleTime',
  );
  @override
  late final GeneratedColumn<bool> flexibleTime = GeneratedColumn<bool>(
    'flexible_time',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("flexible_time" IN (0, 1))',
    ),
  );
  static const VerificationMeta _beginningTimeMeta = const VerificationMeta(
    'beginningTime',
  );
  @override
  late final GeneratedColumn<String> beginningTime = GeneratedColumn<String>(
    'beginning_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endingTimeMeta = const VerificationMeta(
    'endingTime',
  );
  @override
  late final GeneratedColumn<String> endingTime = GeneratedColumn<String>(
    'ending_time',
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repeatTypeMeta = const VerificationMeta(
    'repeatType',
  );
  @override
  late final GeneratedColumn<int> repeatType = GeneratedColumn<int>(
    'repeat_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customRepeatMeta = const VerificationMeta(
    'customRepeat',
  );
  @override
  late final GeneratedColumn<bool> customRepeat = GeneratedColumn<bool>(
    'custom_repeat',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("custom_repeat" IN (0, 1))',
    ),
  );
  static const VerificationMeta _dailyMeta = const VerificationMeta('daily');
  @override
  late final GeneratedColumn<int> daily = GeneratedColumn<int>(
    'daily',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weeklyMeta = const VerificationMeta('weekly');
  @override
  late final GeneratedColumn<String> weekly = GeneratedColumn<String>(
    'weekly',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _monthlyMeta = const VerificationMeta(
    'monthly',
  );
  @override
  late final GeneratedColumn<int> monthly = GeneratedColumn<int>(
    'monthly',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yearlyMeta = const VerificationMeta('yearly');
  @override
  late final GeneratedColumn<int> yearly = GeneratedColumn<int>(
    'yearly',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _checkDaysMeta = const VerificationMeta(
    'checkDays',
  );
  @override
  late final GeneratedColumn<String> checkDays = GeneratedColumn<String>(
    'check_days',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  static const VerificationMeta _finishedMeta = const VerificationMeta(
    'finished',
  );
  @override
  late final GeneratedColumn<bool> finished = GeneratedColumn<bool>(
    'finished',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("finished" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _relatedElementIdMeta = const VerificationMeta(
    'relatedElementId',
  );
  @override
  late final GeneratedColumn<int> relatedElementId = GeneratedColumn<int>(
    'related_element_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(""),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    creationTime,
    name,
    startingDay,
    finishDay,
    flexibleTime,
    beginningTime,
    endingTime,
    notes,
    repeatType,
    customRepeat,
    daily,
    weekly,
    monthly,
    yearly,
    active,
    checkDays,
    finished,
    lastModified,
    relatedElementId,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('creation_time')) {
      context.handle(
        _creationTimeMeta,
        creationTime.isAcceptableOrUnknown(
          data['creation_time']!,
          _creationTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationTimeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('starting_day')) {
      context.handle(
        _startingDayMeta,
        startingDay.isAcceptableOrUnknown(
          data['starting_day']!,
          _startingDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startingDayMeta);
    }
    if (data.containsKey('finish_day')) {
      context.handle(
        _finishDayMeta,
        finishDay.isAcceptableOrUnknown(data['finish_day']!, _finishDayMeta),
      );
    }
    if (data.containsKey('flexible_time')) {
      context.handle(
        _flexibleTimeMeta,
        flexibleTime.isAcceptableOrUnknown(
          data['flexible_time']!,
          _flexibleTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_flexibleTimeMeta);
    }
    if (data.containsKey('beginning_time')) {
      context.handle(
        _beginningTimeMeta,
        beginningTime.isAcceptableOrUnknown(
          data['beginning_time']!,
          _beginningTimeMeta,
        ),
      );
    }
    if (data.containsKey('ending_time')) {
      context.handle(
        _endingTimeMeta,
        endingTime.isAcceptableOrUnknown(data['ending_time']!, _endingTimeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('repeat_type')) {
      context.handle(
        _repeatTypeMeta,
        repeatType.isAcceptableOrUnknown(data['repeat_type']!, _repeatTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_repeatTypeMeta);
    }
    if (data.containsKey('custom_repeat')) {
      context.handle(
        _customRepeatMeta,
        customRepeat.isAcceptableOrUnknown(
          data['custom_repeat']!,
          _customRepeatMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customRepeatMeta);
    }
    if (data.containsKey('daily')) {
      context.handle(
        _dailyMeta,
        daily.isAcceptableOrUnknown(data['daily']!, _dailyMeta),
      );
    }
    if (data.containsKey('weekly')) {
      context.handle(
        _weeklyMeta,
        weekly.isAcceptableOrUnknown(data['weekly']!, _weeklyMeta),
      );
    }
    if (data.containsKey('monthly')) {
      context.handle(
        _monthlyMeta,
        monthly.isAcceptableOrUnknown(data['monthly']!, _monthlyMeta),
      );
    }
    if (data.containsKey('yearly')) {
      context.handle(
        _yearlyMeta,
        yearly.isAcceptableOrUnknown(data['yearly']!, _yearlyMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(
        _activeMeta,
        active.isAcceptableOrUnknown(data['active']!, _activeMeta),
      );
    }
    if (data.containsKey('check_days')) {
      context.handle(
        _checkDaysMeta,
        checkDays.isAcceptableOrUnknown(data['check_days']!, _checkDaysMeta),
      );
    }
    if (data.containsKey('finished')) {
      context.handle(
        _finishedMeta,
        finished.isAcceptableOrUnknown(data['finished']!, _finishedMeta),
      );
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('related_element_id')) {
      context.handle(
        _relatedElementIdMeta,
        relatedElementId.isAcceptableOrUnknown(
          data['related_element_id']!,
          _relatedElementIdMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      creationTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creation_time'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startingDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}starting_day'],
      )!,
      finishDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}finish_day'],
      ),
      flexibleTime: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}flexible_time'],
      )!,
      beginningTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}beginning_time'],
      ),
      endingTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ending_time'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      repeatType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repeat_type'],
      )!,
      customRepeat: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}custom_repeat'],
      )!,
      daily: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily'],
      ),
      weekly: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weekly'],
      ),
      monthly: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly'],
      ),
      yearly: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}yearly'],
      ),
      active: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}active'],
      )!,
      checkDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_days'],
      )!,
      finished: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}finished'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified'],
      )!,
      relatedElementId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}related_element_id'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $TaskTable createAlias(String alias) {
    return $TaskTable(attachedDatabase, alias);
  }
}

class TaskData extends DataClass implements Insertable<TaskData> {
  final int id;
  final String creationTime;
  final String name;
  final String startingDay;
  final String? finishDay;
  final bool flexibleTime;
  final String? beginningTime;
  final String? endingTime;
  final String notes;
  final int repeatType;
  final bool customRepeat;
  final int? daily;
  final String? weekly;
  final int? monthly;
  final int? yearly;
  final bool active;
  final String checkDays;
  final bool finished;
  final String lastModified;
  final int? relatedElementId;
  final String tags;
  const TaskData({
    required this.id,
    required this.creationTime,
    required this.name,
    required this.startingDay,
    this.finishDay,
    required this.flexibleTime,
    this.beginningTime,
    this.endingTime,
    required this.notes,
    required this.repeatType,
    required this.customRepeat,
    this.daily,
    this.weekly,
    this.monthly,
    this.yearly,
    required this.active,
    required this.checkDays,
    required this.finished,
    required this.lastModified,
    this.relatedElementId,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['creation_time'] = Variable<String>(creationTime);
    map['name'] = Variable<String>(name);
    map['starting_day'] = Variable<String>(startingDay);
    if (!nullToAbsent || finishDay != null) {
      map['finish_day'] = Variable<String>(finishDay);
    }
    map['flexible_time'] = Variable<bool>(flexibleTime);
    if (!nullToAbsent || beginningTime != null) {
      map['beginning_time'] = Variable<String>(beginningTime);
    }
    if (!nullToAbsent || endingTime != null) {
      map['ending_time'] = Variable<String>(endingTime);
    }
    map['notes'] = Variable<String>(notes);
    map['repeat_type'] = Variable<int>(repeatType);
    map['custom_repeat'] = Variable<bool>(customRepeat);
    if (!nullToAbsent || daily != null) {
      map['daily'] = Variable<int>(daily);
    }
    if (!nullToAbsent || weekly != null) {
      map['weekly'] = Variable<String>(weekly);
    }
    if (!nullToAbsent || monthly != null) {
      map['monthly'] = Variable<int>(monthly);
    }
    if (!nullToAbsent || yearly != null) {
      map['yearly'] = Variable<int>(yearly);
    }
    map['active'] = Variable<bool>(active);
    map['check_days'] = Variable<String>(checkDays);
    map['finished'] = Variable<bool>(finished);
    map['last_modified'] = Variable<String>(lastModified);
    if (!nullToAbsent || relatedElementId != null) {
      map['related_element_id'] = Variable<int>(relatedElementId);
    }
    map['tags'] = Variable<String>(tags);
    return map;
  }

  TaskCompanion toCompanion(bool nullToAbsent) {
    return TaskCompanion(
      id: Value(id),
      creationTime: Value(creationTime),
      name: Value(name),
      startingDay: Value(startingDay),
      finishDay: finishDay == null && nullToAbsent
          ? const Value.absent()
          : Value(finishDay),
      flexibleTime: Value(flexibleTime),
      beginningTime: beginningTime == null && nullToAbsent
          ? const Value.absent()
          : Value(beginningTime),
      endingTime: endingTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endingTime),
      notes: Value(notes),
      repeatType: Value(repeatType),
      customRepeat: Value(customRepeat),
      daily: daily == null && nullToAbsent
          ? const Value.absent()
          : Value(daily),
      weekly: weekly == null && nullToAbsent
          ? const Value.absent()
          : Value(weekly),
      monthly: monthly == null && nullToAbsent
          ? const Value.absent()
          : Value(monthly),
      yearly: yearly == null && nullToAbsent
          ? const Value.absent()
          : Value(yearly),
      active: Value(active),
      checkDays: Value(checkDays),
      finished: Value(finished),
      lastModified: Value(lastModified),
      relatedElementId: relatedElementId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedElementId),
      tags: Value(tags),
    );
  }

  factory TaskData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskData(
      id: serializer.fromJson<int>(json['id']),
      creationTime: serializer.fromJson<String>(json['creationTime']),
      name: serializer.fromJson<String>(json['name']),
      startingDay: serializer.fromJson<String>(json['startingDay']),
      finishDay: serializer.fromJson<String?>(json['finishDay']),
      flexibleTime: serializer.fromJson<bool>(json['flexibleTime']),
      beginningTime: serializer.fromJson<String?>(json['beginningTime']),
      endingTime: serializer.fromJson<String?>(json['endingTime']),
      notes: serializer.fromJson<String>(json['notes']),
      repeatType: serializer.fromJson<int>(json['repeatType']),
      customRepeat: serializer.fromJson<bool>(json['customRepeat']),
      daily: serializer.fromJson<int?>(json['daily']),
      weekly: serializer.fromJson<String?>(json['weekly']),
      monthly: serializer.fromJson<int?>(json['monthly']),
      yearly: serializer.fromJson<int?>(json['yearly']),
      active: serializer.fromJson<bool>(json['active']),
      checkDays: serializer.fromJson<String>(json['checkDays']),
      finished: serializer.fromJson<bool>(json['finished']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      relatedElementId: serializer.fromJson<int?>(json['relatedElementId']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'creationTime': serializer.toJson<String>(creationTime),
      'name': serializer.toJson<String>(name),
      'startingDay': serializer.toJson<String>(startingDay),
      'finishDay': serializer.toJson<String?>(finishDay),
      'flexibleTime': serializer.toJson<bool>(flexibleTime),
      'beginningTime': serializer.toJson<String?>(beginningTime),
      'endingTime': serializer.toJson<String?>(endingTime),
      'notes': serializer.toJson<String>(notes),
      'repeatType': serializer.toJson<int>(repeatType),
      'customRepeat': serializer.toJson<bool>(customRepeat),
      'daily': serializer.toJson<int?>(daily),
      'weekly': serializer.toJson<String?>(weekly),
      'monthly': serializer.toJson<int?>(monthly),
      'yearly': serializer.toJson<int?>(yearly),
      'active': serializer.toJson<bool>(active),
      'checkDays': serializer.toJson<String>(checkDays),
      'finished': serializer.toJson<bool>(finished),
      'lastModified': serializer.toJson<String>(lastModified),
      'relatedElementId': serializer.toJson<int?>(relatedElementId),
      'tags': serializer.toJson<String>(tags),
    };
  }

  TaskData copyWith({
    int? id,
    String? creationTime,
    String? name,
    String? startingDay,
    Value<String?> finishDay = const Value.absent(),
    bool? flexibleTime,
    Value<String?> beginningTime = const Value.absent(),
    Value<String?> endingTime = const Value.absent(),
    String? notes,
    int? repeatType,
    bool? customRepeat,
    Value<int?> daily = const Value.absent(),
    Value<String?> weekly = const Value.absent(),
    Value<int?> monthly = const Value.absent(),
    Value<int?> yearly = const Value.absent(),
    bool? active,
    String? checkDays,
    bool? finished,
    String? lastModified,
    Value<int?> relatedElementId = const Value.absent(),
    String? tags,
  }) => TaskData(
    id: id ?? this.id,
    creationTime: creationTime ?? this.creationTime,
    name: name ?? this.name,
    startingDay: startingDay ?? this.startingDay,
    finishDay: finishDay.present ? finishDay.value : this.finishDay,
    flexibleTime: flexibleTime ?? this.flexibleTime,
    beginningTime: beginningTime.present
        ? beginningTime.value
        : this.beginningTime,
    endingTime: endingTime.present ? endingTime.value : this.endingTime,
    notes: notes ?? this.notes,
    repeatType: repeatType ?? this.repeatType,
    customRepeat: customRepeat ?? this.customRepeat,
    daily: daily.present ? daily.value : this.daily,
    weekly: weekly.present ? weekly.value : this.weekly,
    monthly: monthly.present ? monthly.value : this.monthly,
    yearly: yearly.present ? yearly.value : this.yearly,
    active: active ?? this.active,
    checkDays: checkDays ?? this.checkDays,
    finished: finished ?? this.finished,
    lastModified: lastModified ?? this.lastModified,
    relatedElementId: relatedElementId.present
        ? relatedElementId.value
        : this.relatedElementId,
    tags: tags ?? this.tags,
  );
  TaskData copyWithCompanion(TaskCompanion data) {
    return TaskData(
      id: data.id.present ? data.id.value : this.id,
      creationTime: data.creationTime.present
          ? data.creationTime.value
          : this.creationTime,
      name: data.name.present ? data.name.value : this.name,
      startingDay: data.startingDay.present
          ? data.startingDay.value
          : this.startingDay,
      finishDay: data.finishDay.present ? data.finishDay.value : this.finishDay,
      flexibleTime: data.flexibleTime.present
          ? data.flexibleTime.value
          : this.flexibleTime,
      beginningTime: data.beginningTime.present
          ? data.beginningTime.value
          : this.beginningTime,
      endingTime: data.endingTime.present
          ? data.endingTime.value
          : this.endingTime,
      notes: data.notes.present ? data.notes.value : this.notes,
      repeatType: data.repeatType.present
          ? data.repeatType.value
          : this.repeatType,
      customRepeat: data.customRepeat.present
          ? data.customRepeat.value
          : this.customRepeat,
      daily: data.daily.present ? data.daily.value : this.daily,
      weekly: data.weekly.present ? data.weekly.value : this.weekly,
      monthly: data.monthly.present ? data.monthly.value : this.monthly,
      yearly: data.yearly.present ? data.yearly.value : this.yearly,
      active: data.active.present ? data.active.value : this.active,
      checkDays: data.checkDays.present ? data.checkDays.value : this.checkDays,
      finished: data.finished.present ? data.finished.value : this.finished,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      relatedElementId: data.relatedElementId.present
          ? data.relatedElementId.value
          : this.relatedElementId,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskData(')
          ..write('id: $id, ')
          ..write('creationTime: $creationTime, ')
          ..write('name: $name, ')
          ..write('startingDay: $startingDay, ')
          ..write('finishDay: $finishDay, ')
          ..write('flexibleTime: $flexibleTime, ')
          ..write('beginningTime: $beginningTime, ')
          ..write('endingTime: $endingTime, ')
          ..write('notes: $notes, ')
          ..write('repeatType: $repeatType, ')
          ..write('customRepeat: $customRepeat, ')
          ..write('daily: $daily, ')
          ..write('weekly: $weekly, ')
          ..write('monthly: $monthly, ')
          ..write('yearly: $yearly, ')
          ..write('active: $active, ')
          ..write('checkDays: $checkDays, ')
          ..write('finished: $finished, ')
          ..write('lastModified: $lastModified, ')
          ..write('relatedElementId: $relatedElementId, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    creationTime,
    name,
    startingDay,
    finishDay,
    flexibleTime,
    beginningTime,
    endingTime,
    notes,
    repeatType,
    customRepeat,
    daily,
    weekly,
    monthly,
    yearly,
    active,
    checkDays,
    finished,
    lastModified,
    relatedElementId,
    tags,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskData &&
          other.id == this.id &&
          other.creationTime == this.creationTime &&
          other.name == this.name &&
          other.startingDay == this.startingDay &&
          other.finishDay == this.finishDay &&
          other.flexibleTime == this.flexibleTime &&
          other.beginningTime == this.beginningTime &&
          other.endingTime == this.endingTime &&
          other.notes == this.notes &&
          other.repeatType == this.repeatType &&
          other.customRepeat == this.customRepeat &&
          other.daily == this.daily &&
          other.weekly == this.weekly &&
          other.monthly == this.monthly &&
          other.yearly == this.yearly &&
          other.active == this.active &&
          other.checkDays == this.checkDays &&
          other.finished == this.finished &&
          other.lastModified == this.lastModified &&
          other.relatedElementId == this.relatedElementId &&
          other.tags == this.tags);
}

class TaskCompanion extends UpdateCompanion<TaskData> {
  final Value<int> id;
  final Value<String> creationTime;
  final Value<String> name;
  final Value<String> startingDay;
  final Value<String?> finishDay;
  final Value<bool> flexibleTime;
  final Value<String?> beginningTime;
  final Value<String?> endingTime;
  final Value<String> notes;
  final Value<int> repeatType;
  final Value<bool> customRepeat;
  final Value<int?> daily;
  final Value<String?> weekly;
  final Value<int?> monthly;
  final Value<int?> yearly;
  final Value<bool> active;
  final Value<String> checkDays;
  final Value<bool> finished;
  final Value<String> lastModified;
  final Value<int?> relatedElementId;
  final Value<String> tags;
  const TaskCompanion({
    this.id = const Value.absent(),
    this.creationTime = const Value.absent(),
    this.name = const Value.absent(),
    this.startingDay = const Value.absent(),
    this.finishDay = const Value.absent(),
    this.flexibleTime = const Value.absent(),
    this.beginningTime = const Value.absent(),
    this.endingTime = const Value.absent(),
    this.notes = const Value.absent(),
    this.repeatType = const Value.absent(),
    this.customRepeat = const Value.absent(),
    this.daily = const Value.absent(),
    this.weekly = const Value.absent(),
    this.monthly = const Value.absent(),
    this.yearly = const Value.absent(),
    this.active = const Value.absent(),
    this.checkDays = const Value.absent(),
    this.finished = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.relatedElementId = const Value.absent(),
    this.tags = const Value.absent(),
  });
  TaskCompanion.insert({
    this.id = const Value.absent(),
    required String creationTime,
    required String name,
    required String startingDay,
    this.finishDay = const Value.absent(),
    required bool flexibleTime,
    this.beginningTime = const Value.absent(),
    this.endingTime = const Value.absent(),
    required String notes,
    required int repeatType,
    required bool customRepeat,
    this.daily = const Value.absent(),
    this.weekly = const Value.absent(),
    this.monthly = const Value.absent(),
    this.yearly = const Value.absent(),
    this.active = const Value.absent(),
    this.checkDays = const Value.absent(),
    this.finished = const Value.absent(),
    required String lastModified,
    this.relatedElementId = const Value.absent(),
    this.tags = const Value.absent(),
  }) : creationTime = Value(creationTime),
       name = Value(name),
       startingDay = Value(startingDay),
       flexibleTime = Value(flexibleTime),
       notes = Value(notes),
       repeatType = Value(repeatType),
       customRepeat = Value(customRepeat),
       lastModified = Value(lastModified);
  static Insertable<TaskData> custom({
    Expression<int>? id,
    Expression<String>? creationTime,
    Expression<String>? name,
    Expression<String>? startingDay,
    Expression<String>? finishDay,
    Expression<bool>? flexibleTime,
    Expression<String>? beginningTime,
    Expression<String>? endingTime,
    Expression<String>? notes,
    Expression<int>? repeatType,
    Expression<bool>? customRepeat,
    Expression<int>? daily,
    Expression<String>? weekly,
    Expression<int>? monthly,
    Expression<int>? yearly,
    Expression<bool>? active,
    Expression<String>? checkDays,
    Expression<bool>? finished,
    Expression<String>? lastModified,
    Expression<int>? relatedElementId,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (creationTime != null) 'creation_time': creationTime,
      if (name != null) 'name': name,
      if (startingDay != null) 'starting_day': startingDay,
      if (finishDay != null) 'finish_day': finishDay,
      if (flexibleTime != null) 'flexible_time': flexibleTime,
      if (beginningTime != null) 'beginning_time': beginningTime,
      if (endingTime != null) 'ending_time': endingTime,
      if (notes != null) 'notes': notes,
      if (repeatType != null) 'repeat_type': repeatType,
      if (customRepeat != null) 'custom_repeat': customRepeat,
      if (daily != null) 'daily': daily,
      if (weekly != null) 'weekly': weekly,
      if (monthly != null) 'monthly': monthly,
      if (yearly != null) 'yearly': yearly,
      if (active != null) 'active': active,
      if (checkDays != null) 'check_days': checkDays,
      if (finished != null) 'finished': finished,
      if (lastModified != null) 'last_modified': lastModified,
      if (relatedElementId != null) 'related_element_id': relatedElementId,
      if (tags != null) 'tags': tags,
    });
  }

  TaskCompanion copyWith({
    Value<int>? id,
    Value<String>? creationTime,
    Value<String>? name,
    Value<String>? startingDay,
    Value<String?>? finishDay,
    Value<bool>? flexibleTime,
    Value<String?>? beginningTime,
    Value<String?>? endingTime,
    Value<String>? notes,
    Value<int>? repeatType,
    Value<bool>? customRepeat,
    Value<int?>? daily,
    Value<String?>? weekly,
    Value<int?>? monthly,
    Value<int?>? yearly,
    Value<bool>? active,
    Value<String>? checkDays,
    Value<bool>? finished,
    Value<String>? lastModified,
    Value<int?>? relatedElementId,
    Value<String>? tags,
  }) {
    return TaskCompanion(
      id: id ?? this.id,
      creationTime: creationTime ?? this.creationTime,
      name: name ?? this.name,
      startingDay: startingDay ?? this.startingDay,
      finishDay: finishDay ?? this.finishDay,
      flexibleTime: flexibleTime ?? this.flexibleTime,
      beginningTime: beginningTime ?? this.beginningTime,
      endingTime: endingTime ?? this.endingTime,
      notes: notes ?? this.notes,
      repeatType: repeatType ?? this.repeatType,
      customRepeat: customRepeat ?? this.customRepeat,
      daily: daily ?? this.daily,
      weekly: weekly ?? this.weekly,
      monthly: monthly ?? this.monthly,
      yearly: yearly ?? this.yearly,
      active: active ?? this.active,
      checkDays: checkDays ?? this.checkDays,
      finished: finished ?? this.finished,
      lastModified: lastModified ?? this.lastModified,
      relatedElementId: relatedElementId ?? this.relatedElementId,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (creationTime.present) {
      map['creation_time'] = Variable<String>(creationTime.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startingDay.present) {
      map['starting_day'] = Variable<String>(startingDay.value);
    }
    if (finishDay.present) {
      map['finish_day'] = Variable<String>(finishDay.value);
    }
    if (flexibleTime.present) {
      map['flexible_time'] = Variable<bool>(flexibleTime.value);
    }
    if (beginningTime.present) {
      map['beginning_time'] = Variable<String>(beginningTime.value);
    }
    if (endingTime.present) {
      map['ending_time'] = Variable<String>(endingTime.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (repeatType.present) {
      map['repeat_type'] = Variable<int>(repeatType.value);
    }
    if (customRepeat.present) {
      map['custom_repeat'] = Variable<bool>(customRepeat.value);
    }
    if (daily.present) {
      map['daily'] = Variable<int>(daily.value);
    }
    if (weekly.present) {
      map['weekly'] = Variable<String>(weekly.value);
    }
    if (monthly.present) {
      map['monthly'] = Variable<int>(monthly.value);
    }
    if (yearly.present) {
      map['yearly'] = Variable<int>(yearly.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (checkDays.present) {
      map['check_days'] = Variable<String>(checkDays.value);
    }
    if (finished.present) {
      map['finished'] = Variable<bool>(finished.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<String>(lastModified.value);
    }
    if (relatedElementId.present) {
      map['related_element_id'] = Variable<int>(relatedElementId.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskCompanion(')
          ..write('id: $id, ')
          ..write('creationTime: $creationTime, ')
          ..write('name: $name, ')
          ..write('startingDay: $startingDay, ')
          ..write('finishDay: $finishDay, ')
          ..write('flexibleTime: $flexibleTime, ')
          ..write('beginningTime: $beginningTime, ')
          ..write('endingTime: $endingTime, ')
          ..write('notes: $notes, ')
          ..write('repeatType: $repeatType, ')
          ..write('customRepeat: $customRepeat, ')
          ..write('daily: $daily, ')
          ..write('weekly: $weekly, ')
          ..write('monthly: $monthly, ')
          ..write('yearly: $yearly, ')
          ..write('active: $active, ')
          ..write('checkDays: $checkDays, ')
          ..write('finished: $finished, ')
          ..write('lastModified: $lastModified, ')
          ..write('relatedElementId: $relatedElementId, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyEncryptedDatabase extends GeneratedDatabase {
  _$MyEncryptedDatabase(QueryExecutor e) : super(e);
  $MyEncryptedDatabaseManager get managers => $MyEncryptedDatabaseManager(this);
  late final $MyListTable myList = $MyListTable(this);
  late final $MySublistTable mySublist = $MySublistTable(this);
  late final $MyElementTable myElement = $MyElementTable(this);
  late final $DbSettingsTable dbSettings = $DbSettingsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $TodoElementTable todoElement = $TodoElementTable(this);
  late final $TaskTable task = $TaskTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    myList,
    mySublist,
    myElement,
    dbSettings,
    settings,
    todoElement,
    task,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'my_list',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('my_sublist', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'my_sublist',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('my_sublist', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'my_list',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('my_element', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'my_sublist',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('my_element', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'my_list',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('todo_element', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MyListTableCreateCompanionBuilder =
    MyListCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> showAll,
      required String lastModified,
      Value<String> position,
      Value<bool> todoList,
    });
typedef $$MyListTableUpdateCompanionBuilder =
    MyListCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> showAll,
      Value<String> lastModified,
      Value<String> position,
      Value<bool> todoList,
    });

final class $$MyListTableReferences
    extends BaseReferences<_$MyEncryptedDatabase, $MyListTable, MyListData> {
  $$MyListTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MySublistTable, List<MySublistData>>
  _mySublistRefsTable(_$MyEncryptedDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mySublist,
        aliasName: 'my_list__id__my_sublist__list_parent',
      );

  $$MySublistTableProcessedTableManager get mySublistRefs {
    final manager = $$MySublistTableTableManager(
      $_db,
      $_db.mySublist,
    ).filter((f) => f.listParent.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_mySublistRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MyElementTable, List<MyElementData>>
  _myElementRefsTable(_$MyEncryptedDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.myElement,
        aliasName: 'my_list__id__my_element__list_parent',
      );

  $$MyElementTableProcessedTableManager get myElementRefs {
    final manager = $$MyElementTableTableManager(
      $_db,
      $_db.myElement,
    ).filter((f) => f.listParent.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_myElementRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TodoElementTable, List<TodoElementData>>
  _todoElementRefsTable(_$MyEncryptedDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.todoElement,
        aliasName: 'my_list__id__todo_element__list_parent',
      );

  $$TodoElementTableProcessedTableManager get todoElementRefs {
    final manager = $$TodoElementTableTableManager(
      $_db,
      $_db.todoElement,
    ).filter((f) => f.listParent.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_todoElementRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MyListTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $MyListTable> {
  $$MyListTableFilterComposer({
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

  ColumnFilters<bool> get showAll => $composableBuilder(
    column: $table.showAll,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get todoList => $composableBuilder(
    column: $table.todoList,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> mySublistRefs(
    Expression<bool> Function($$MySublistTableFilterComposer f) f,
  ) {
    final $$MySublistTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.listParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableFilterComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> myElementRefs(
    Expression<bool> Function($$MyElementTableFilterComposer f) f,
  ) {
    final $$MyElementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.myElement,
      getReferencedColumn: (t) => t.listParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyElementTableFilterComposer(
            $db: $db,
            $table: $db.myElement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> todoElementRefs(
    Expression<bool> Function($$TodoElementTableFilterComposer f) f,
  ) {
    final $$TodoElementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.todoElement,
      getReferencedColumn: (t) => t.listParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoElementTableFilterComposer(
            $db: $db,
            $table: $db.todoElement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MyListTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $MyListTable> {
  $$MyListTableOrderingComposer({
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

  ColumnOrderings<bool> get showAll => $composableBuilder(
    column: $table.showAll,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get todoList => $composableBuilder(
    column: $table.todoList,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MyListTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $MyListTable> {
  $$MyListTableAnnotationComposer({
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

  GeneratedColumn<bool> get showAll =>
      $composableBuilder(column: $table.showAll, builder: (column) => column);

  GeneratedColumn<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get todoList =>
      $composableBuilder(column: $table.todoList, builder: (column) => column);

  Expression<T> mySublistRefs<T extends Object>(
    Expression<T> Function($$MySublistTableAnnotationComposer a) f,
  ) {
    final $$MySublistTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.listParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableAnnotationComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> myElementRefs<T extends Object>(
    Expression<T> Function($$MyElementTableAnnotationComposer a) f,
  ) {
    final $$MyElementTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.myElement,
      getReferencedColumn: (t) => t.listParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyElementTableAnnotationComposer(
            $db: $db,
            $table: $db.myElement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> todoElementRefs<T extends Object>(
    Expression<T> Function($$TodoElementTableAnnotationComposer a) f,
  ) {
    final $$TodoElementTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.todoElement,
      getReferencedColumn: (t) => t.listParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TodoElementTableAnnotationComposer(
            $db: $db,
            $table: $db.todoElement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MyListTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $MyListTable,
          MyListData,
          $$MyListTableFilterComposer,
          $$MyListTableOrderingComposer,
          $$MyListTableAnnotationComposer,
          $$MyListTableCreateCompanionBuilder,
          $$MyListTableUpdateCompanionBuilder,
          (MyListData, $$MyListTableReferences),
          MyListData,
          PrefetchHooks Function({
            bool mySublistRefs,
            bool myElementRefs,
            bool todoElementRefs,
          })
        > {
  $$MyListTableTableManager(_$MyEncryptedDatabase db, $MyListTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MyListTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MyListTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MyListTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> showAll = const Value.absent(),
                Value<String> lastModified = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<bool> todoList = const Value.absent(),
              }) => MyListCompanion(
                id: id,
                name: name,
                showAll: showAll,
                lastModified: lastModified,
                position: position,
                todoList: todoList,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> showAll = const Value.absent(),
                required String lastModified,
                Value<String> position = const Value.absent(),
                Value<bool> todoList = const Value.absent(),
              }) => MyListCompanion.insert(
                id: id,
                name: name,
                showAll: showAll,
                lastModified: lastModified,
                position: position,
                todoList: todoList,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$MyListTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                mySublistRefs = false,
                myElementRefs = false,
                todoElementRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (mySublistRefs) db.mySublist,
                    if (myElementRefs) db.myElement,
                    if (todoElementRefs) db.todoElement,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (mySublistRefs)
                        await $_getPrefetchedData<
                          MyListData,
                          $MyListTable,
                          MySublistData
                        >(
                          currentTable: table,
                          referencedTable: $$MyListTableReferences
                              ._mySublistRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MyListTableReferences(
                                db,
                                table,
                                p0,
                              ).mySublistRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listParent == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (myElementRefs)
                        await $_getPrefetchedData<
                          MyListData,
                          $MyListTable,
                          MyElementData
                        >(
                          currentTable: table,
                          referencedTable: $$MyListTableReferences
                              ._myElementRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MyListTableReferences(
                                db,
                                table,
                                p0,
                              ).myElementRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listParent == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (todoElementRefs)
                        await $_getPrefetchedData<
                          MyListData,
                          $MyListTable,
                          TodoElementData
                        >(
                          currentTable: table,
                          referencedTable: $$MyListTableReferences
                              ._todoElementRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MyListTableReferences(
                                db,
                                table,
                                p0,
                              ).todoElementRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.listParent == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MyListTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $MyListTable,
      MyListData,
      $$MyListTableFilterComposer,
      $$MyListTableOrderingComposer,
      $$MyListTableAnnotationComposer,
      $$MyListTableCreateCompanionBuilder,
      $$MyListTableUpdateCompanionBuilder,
      (MyListData, $$MyListTableReferences),
      MyListData,
      PrefetchHooks Function({
        bool mySublistRefs,
        bool myElementRefs,
        bool todoElementRefs,
      })
    >;
typedef $$MySublistTableCreateCompanionBuilder =
    MySublistCompanion Function({
      required int ancestorId,
      Value<int> id,
      required String name,
      required String lastModified,
      required String position,
      required bool hasListParent,
      Value<int?> listParent,
      Value<int?> sublistParent,
      Value<bool> isShrinked,
      required String notes,
    });
typedef $$MySublistTableUpdateCompanionBuilder =
    MySublistCompanion Function({
      Value<int> ancestorId,
      Value<int> id,
      Value<String> name,
      Value<String> lastModified,
      Value<String> position,
      Value<bool> hasListParent,
      Value<int?> listParent,
      Value<int?> sublistParent,
      Value<bool> isShrinked,
      Value<String> notes,
    });

final class $$MySublistTableReferences
    extends
        BaseReferences<_$MyEncryptedDatabase, $MySublistTable, MySublistData> {
  $$MySublistTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MyListTable _listParentTable(_$MyEncryptedDatabase db) =>
      db.myList.createAlias('my_sublist__list_parent__my_list__id');

  $$MyListTableProcessedTableManager? get listParent {
    final $_column = $_itemColumn<int>('list_parent');
    if ($_column == null) return null;
    final manager = $$MyListTableTableManager(
      $_db,
      $_db.myList,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listParentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MySublistTable _sublistParentTable(_$MyEncryptedDatabase db) =>
      db.mySublist.createAlias('my_sublist__sublist_parent__my_sublist__id');

  $$MySublistTableProcessedTableManager? get sublistParent {
    final $_column = $_itemColumn<int>('sublist_parent');
    if ($_column == null) return null;
    final manager = $$MySublistTableTableManager(
      $_db,
      $_db.mySublist,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sublistParentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MyElementTable, List<MyElementData>>
  _myElementRefsTable(_$MyEncryptedDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.myElement,
        aliasName: 'my_sublist__id__my_element__sublist_parent',
      );

  $$MyElementTableProcessedTableManager get myElementRefs {
    final manager = $$MyElementTableTableManager(
      $_db,
      $_db.myElement,
    ).filter((f) => f.sublistParent.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_myElementRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MySublistTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $MySublistTable> {
  $$MySublistTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ancestorId => $composableBuilder(
    column: $table.ancestorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasListParent => $composableBuilder(
    column: $table.hasListParent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isShrinked => $composableBuilder(
    column: $table.isShrinked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$MyListTableFilterComposer get listParent {
    final $$MyListTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableFilterComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MySublistTableFilterComposer get sublistParent {
    final $$MySublistTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sublistParent,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableFilterComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> myElementRefs(
    Expression<bool> Function($$MyElementTableFilterComposer f) f,
  ) {
    final $$MyElementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.myElement,
      getReferencedColumn: (t) => t.sublistParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyElementTableFilterComposer(
            $db: $db,
            $table: $db.myElement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MySublistTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $MySublistTable> {
  $$MySublistTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ancestorId => $composableBuilder(
    column: $table.ancestorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasListParent => $composableBuilder(
    column: $table.hasListParent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isShrinked => $composableBuilder(
    column: $table.isShrinked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$MyListTableOrderingComposer get listParent {
    final $$MyListTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableOrderingComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MySublistTableOrderingComposer get sublistParent {
    final $$MySublistTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sublistParent,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableOrderingComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MySublistTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $MySublistTable> {
  $$MySublistTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ancestorId => $composableBuilder(
    column: $table.ancestorId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get hasListParent => $composableBuilder(
    column: $table.hasListParent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isShrinked => $composableBuilder(
    column: $table.isShrinked,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$MyListTableAnnotationComposer get listParent {
    final $$MyListTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableAnnotationComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MySublistTableAnnotationComposer get sublistParent {
    final $$MySublistTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sublistParent,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableAnnotationComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> myElementRefs<T extends Object>(
    Expression<T> Function($$MyElementTableAnnotationComposer a) f,
  ) {
    final $$MyElementTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.myElement,
      getReferencedColumn: (t) => t.sublistParent,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyElementTableAnnotationComposer(
            $db: $db,
            $table: $db.myElement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MySublistTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $MySublistTable,
          MySublistData,
          $$MySublistTableFilterComposer,
          $$MySublistTableOrderingComposer,
          $$MySublistTableAnnotationComposer,
          $$MySublistTableCreateCompanionBuilder,
          $$MySublistTableUpdateCompanionBuilder,
          (MySublistData, $$MySublistTableReferences),
          MySublistData,
          PrefetchHooks Function({
            bool listParent,
            bool sublistParent,
            bool myElementRefs,
          })
        > {
  $$MySublistTableTableManager(_$MyEncryptedDatabase db, $MySublistTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MySublistTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MySublistTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MySublistTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ancestorId = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> lastModified = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<bool> hasListParent = const Value.absent(),
                Value<int?> listParent = const Value.absent(),
                Value<int?> sublistParent = const Value.absent(),
                Value<bool> isShrinked = const Value.absent(),
                Value<String> notes = const Value.absent(),
              }) => MySublistCompanion(
                ancestorId: ancestorId,
                id: id,
                name: name,
                lastModified: lastModified,
                position: position,
                hasListParent: hasListParent,
                listParent: listParent,
                sublistParent: sublistParent,
                isShrinked: isShrinked,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                required int ancestorId,
                Value<int> id = const Value.absent(),
                required String name,
                required String lastModified,
                required String position,
                required bool hasListParent,
                Value<int?> listParent = const Value.absent(),
                Value<int?> sublistParent = const Value.absent(),
                Value<bool> isShrinked = const Value.absent(),
                required String notes,
              }) => MySublistCompanion.insert(
                ancestorId: ancestorId,
                id: id,
                name: name,
                lastModified: lastModified,
                position: position,
                hasListParent: hasListParent,
                listParent: listParent,
                sublistParent: sublistParent,
                isShrinked: isShrinked,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MySublistTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                listParent = false,
                sublistParent = false,
                myElementRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (myElementRefs) db.myElement],
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
                        if (listParent) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.listParent,
                                    referencedTable: $$MySublistTableReferences
                                        ._listParentTable(db),
                                    referencedColumn: $$MySublistTableReferences
                                        ._listParentTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (sublistParent) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.sublistParent,
                                    referencedTable: $$MySublistTableReferences
                                        ._sublistParentTable(db),
                                    referencedColumn: $$MySublistTableReferences
                                        ._sublistParentTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (myElementRefs)
                        await $_getPrefetchedData<
                          MySublistData,
                          $MySublistTable,
                          MyElementData
                        >(
                          currentTable: table,
                          referencedTable: $$MySublistTableReferences
                              ._myElementRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MySublistTableReferences(
                                db,
                                table,
                                p0,
                              ).myElementRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sublistParent == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MySublistTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $MySublistTable,
      MySublistData,
      $$MySublistTableFilterComposer,
      $$MySublistTableOrderingComposer,
      $$MySublistTableAnnotationComposer,
      $$MySublistTableCreateCompanionBuilder,
      $$MySublistTableUpdateCompanionBuilder,
      (MySublistData, $$MySublistTableReferences),
      MySublistData,
      PrefetchHooks Function({
        bool listParent,
        bool sublistParent,
        bool myElementRefs,
      })
    >;
typedef $$MyElementTableCreateCompanionBuilder =
    MyElementCompanion Function({
      required int ancestorId,
      Value<int> id,
      required String name,
      required String lastModified,
      required String position,
      required bool hasListParent,
      Value<int?> listParent,
      Value<int?> sublistParent,
      Value<bool> isChecked,
      required String notes,
      Value<int?> taskIdRelated,
      Value<int?> todoitemIdRelated,
      Value<String> tags,
    });
typedef $$MyElementTableUpdateCompanionBuilder =
    MyElementCompanion Function({
      Value<int> ancestorId,
      Value<int> id,
      Value<String> name,
      Value<String> lastModified,
      Value<String> position,
      Value<bool> hasListParent,
      Value<int?> listParent,
      Value<int?> sublistParent,
      Value<bool> isChecked,
      Value<String> notes,
      Value<int?> taskIdRelated,
      Value<int?> todoitemIdRelated,
      Value<String> tags,
    });

final class $$MyElementTableReferences
    extends
        BaseReferences<_$MyEncryptedDatabase, $MyElementTable, MyElementData> {
  $$MyElementTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MyListTable _listParentTable(_$MyEncryptedDatabase db) =>
      db.myList.createAlias('my_element__list_parent__my_list__id');

  $$MyListTableProcessedTableManager? get listParent {
    final $_column = $_itemColumn<int>('list_parent');
    if ($_column == null) return null;
    final manager = $$MyListTableTableManager(
      $_db,
      $_db.myList,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listParentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MySublistTable _sublistParentTable(_$MyEncryptedDatabase db) =>
      db.mySublist.createAlias('my_element__sublist_parent__my_sublist__id');

  $$MySublistTableProcessedTableManager? get sublistParent {
    final $_column = $_itemColumn<int>('sublist_parent');
    if ($_column == null) return null;
    final manager = $$MySublistTableTableManager(
      $_db,
      $_db.mySublist,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sublistParentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MyElementTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $MyElementTable> {
  $$MyElementTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get ancestorId => $composableBuilder(
    column: $table.ancestorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasListParent => $composableBuilder(
    column: $table.hasListParent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taskIdRelated => $composableBuilder(
    column: $table.taskIdRelated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get todoitemIdRelated => $composableBuilder(
    column: $table.todoitemIdRelated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  $$MyListTableFilterComposer get listParent {
    final $$MyListTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableFilterComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MySublistTableFilterComposer get sublistParent {
    final $$MySublistTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sublistParent,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableFilterComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MyElementTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $MyElementTable> {
  $$MyElementTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get ancestorId => $composableBuilder(
    column: $table.ancestorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasListParent => $composableBuilder(
    column: $table.hasListParent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taskIdRelated => $composableBuilder(
    column: $table.taskIdRelated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get todoitemIdRelated => $composableBuilder(
    column: $table.todoitemIdRelated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  $$MyListTableOrderingComposer get listParent {
    final $$MyListTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableOrderingComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MySublistTableOrderingComposer get sublistParent {
    final $$MySublistTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sublistParent,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableOrderingComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MyElementTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $MyElementTable> {
  $$MyElementTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get ancestorId => $composableBuilder(
    column: $table.ancestorId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get hasListParent => $composableBuilder(
    column: $table.hasListParent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get taskIdRelated => $composableBuilder(
    column: $table.taskIdRelated,
    builder: (column) => column,
  );

  GeneratedColumn<int> get todoitemIdRelated => $composableBuilder(
    column: $table.todoitemIdRelated,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  $$MyListTableAnnotationComposer get listParent {
    final $$MyListTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableAnnotationComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MySublistTableAnnotationComposer get sublistParent {
    final $$MySublistTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sublistParent,
      referencedTable: $db.mySublist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MySublistTableAnnotationComposer(
            $db: $db,
            $table: $db.mySublist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MyElementTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $MyElementTable,
          MyElementData,
          $$MyElementTableFilterComposer,
          $$MyElementTableOrderingComposer,
          $$MyElementTableAnnotationComposer,
          $$MyElementTableCreateCompanionBuilder,
          $$MyElementTableUpdateCompanionBuilder,
          (MyElementData, $$MyElementTableReferences),
          MyElementData,
          PrefetchHooks Function({bool listParent, bool sublistParent})
        > {
  $$MyElementTableTableManager(_$MyEncryptedDatabase db, $MyElementTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MyElementTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MyElementTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MyElementTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> ancestorId = const Value.absent(),
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> lastModified = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<bool> hasListParent = const Value.absent(),
                Value<int?> listParent = const Value.absent(),
                Value<int?> sublistParent = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int?> taskIdRelated = const Value.absent(),
                Value<int?> todoitemIdRelated = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => MyElementCompanion(
                ancestorId: ancestorId,
                id: id,
                name: name,
                lastModified: lastModified,
                position: position,
                hasListParent: hasListParent,
                listParent: listParent,
                sublistParent: sublistParent,
                isChecked: isChecked,
                notes: notes,
                taskIdRelated: taskIdRelated,
                todoitemIdRelated: todoitemIdRelated,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                required int ancestorId,
                Value<int> id = const Value.absent(),
                required String name,
                required String lastModified,
                required String position,
                required bool hasListParent,
                Value<int?> listParent = const Value.absent(),
                Value<int?> sublistParent = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                required String notes,
                Value<int?> taskIdRelated = const Value.absent(),
                Value<int?> todoitemIdRelated = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => MyElementCompanion.insert(
                ancestorId: ancestorId,
                id: id,
                name: name,
                lastModified: lastModified,
                position: position,
                hasListParent: hasListParent,
                listParent: listParent,
                sublistParent: sublistParent,
                isChecked: isChecked,
                notes: notes,
                taskIdRelated: taskIdRelated,
                todoitemIdRelated: todoitemIdRelated,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MyElementTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({listParent = false, sublistParent = false}) {
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
                    if (listParent) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.listParent,
                                referencedTable: $$MyElementTableReferences
                                    ._listParentTable(db),
                                referencedColumn: $$MyElementTableReferences
                                    ._listParentTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (sublistParent) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sublistParent,
                                referencedTable: $$MyElementTableReferences
                                    ._sublistParentTable(db),
                                referencedColumn: $$MyElementTableReferences
                                    ._sublistParentTable(db)
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

typedef $$MyElementTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $MyElementTable,
      MyElementData,
      $$MyElementTableFilterComposer,
      $$MyElementTableOrderingComposer,
      $$MyElementTableAnnotationComposer,
      $$MyElementTableCreateCompanionBuilder,
      $$MyElementTableUpdateCompanionBuilder,
      (MyElementData, $$MyElementTableReferences),
      MyElementData,
      PrefetchHooks Function({bool listParent, bool sublistParent})
    >;
typedef $$DbSettingsTableCreateCompanionBuilder =
    DbSettingsCompanion Function({
      Value<int> id,
      required int maxListId,
      required int maxElementId,
      required int maxTodoListId,
      required int maxTodoItemId,
      required bool plannerShowAll,
    });
typedef $$DbSettingsTableUpdateCompanionBuilder =
    DbSettingsCompanion Function({
      Value<int> id,
      Value<int> maxListId,
      Value<int> maxElementId,
      Value<int> maxTodoListId,
      Value<int> maxTodoItemId,
      Value<bool> plannerShowAll,
    });

class $$DbSettingsTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $DbSettingsTable> {
  $$DbSettingsTableFilterComposer({
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

  ColumnFilters<int> get maxListId => $composableBuilder(
    column: $table.maxListId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxElementId => $composableBuilder(
    column: $table.maxElementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTodoListId => $composableBuilder(
    column: $table.maxTodoListId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTodoItemId => $composableBuilder(
    column: $table.maxTodoItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get plannerShowAll => $composableBuilder(
    column: $table.plannerShowAll,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DbSettingsTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $DbSettingsTable> {
  $$DbSettingsTableOrderingComposer({
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

  ColumnOrderings<int> get maxListId => $composableBuilder(
    column: $table.maxListId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxElementId => $composableBuilder(
    column: $table.maxElementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTodoListId => $composableBuilder(
    column: $table.maxTodoListId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTodoItemId => $composableBuilder(
    column: $table.maxTodoItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get plannerShowAll => $composableBuilder(
    column: $table.plannerShowAll,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DbSettingsTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $DbSettingsTable> {
  $$DbSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get maxListId =>
      $composableBuilder(column: $table.maxListId, builder: (column) => column);

  GeneratedColumn<int> get maxElementId => $composableBuilder(
    column: $table.maxElementId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxTodoListId => $composableBuilder(
    column: $table.maxTodoListId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxTodoItemId => $composableBuilder(
    column: $table.maxTodoItemId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get plannerShowAll => $composableBuilder(
    column: $table.plannerShowAll,
    builder: (column) => column,
  );
}

class $$DbSettingsTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $DbSettingsTable,
          DbSetting,
          $$DbSettingsTableFilterComposer,
          $$DbSettingsTableOrderingComposer,
          $$DbSettingsTableAnnotationComposer,
          $$DbSettingsTableCreateCompanionBuilder,
          $$DbSettingsTableUpdateCompanionBuilder,
          (
            DbSetting,
            BaseReferences<_$MyEncryptedDatabase, $DbSettingsTable, DbSetting>,
          ),
          DbSetting,
          PrefetchHooks Function()
        > {
  $$DbSettingsTableTableManager(
    _$MyEncryptedDatabase db,
    $DbSettingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> maxListId = const Value.absent(),
                Value<int> maxElementId = const Value.absent(),
                Value<int> maxTodoListId = const Value.absent(),
                Value<int> maxTodoItemId = const Value.absent(),
                Value<bool> plannerShowAll = const Value.absent(),
              }) => DbSettingsCompanion(
                id: id,
                maxListId: maxListId,
                maxElementId: maxElementId,
                maxTodoListId: maxTodoListId,
                maxTodoItemId: maxTodoItemId,
                plannerShowAll: plannerShowAll,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int maxListId,
                required int maxElementId,
                required int maxTodoListId,
                required int maxTodoItemId,
                required bool plannerShowAll,
              }) => DbSettingsCompanion.insert(
                id: id,
                maxListId: maxListId,
                maxElementId: maxElementId,
                maxTodoListId: maxTodoListId,
                maxTodoItemId: maxTodoItemId,
                plannerShowAll: plannerShowAll,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DbSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $DbSettingsTable,
      DbSetting,
      $$DbSettingsTableFilterComposer,
      $$DbSettingsTableOrderingComposer,
      $$DbSettingsTableAnnotationComposer,
      $$DbSettingsTableCreateCompanionBuilder,
      $$DbSettingsTableUpdateCompanionBuilder,
      (
        DbSetting,
        BaseReferences<_$MyEncryptedDatabase, $DbSettingsTable, DbSetting>,
      ),
      DbSetting,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      required bool isBackupNeeded,
      required DateTime lastBackup,
      required int login,
      required bool deleteRelatedThings,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<bool> isBackupNeeded,
      Value<DateTime> lastBackup,
      Value<int> login,
      Value<bool> deleteRelatedThings,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
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

  ColumnFilters<bool> get isBackupNeeded => $composableBuilder(
    column: $table.isBackupNeeded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackup => $composableBuilder(
    column: $table.lastBackup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get deleteRelatedThings => $composableBuilder(
    column: $table.deleteRelatedThings,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
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

  ColumnOrderings<bool> get isBackupNeeded => $composableBuilder(
    column: $table.isBackupNeeded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackup => $composableBuilder(
    column: $table.lastBackup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get login => $composableBuilder(
    column: $table.login,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get deleteRelatedThings => $composableBuilder(
    column: $table.deleteRelatedThings,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get isBackupNeeded => $composableBuilder(
    column: $table.isBackupNeeded,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackup => $composableBuilder(
    column: $table.lastBackup,
    builder: (column) => column,
  );

  GeneratedColumn<int> get login =>
      $composableBuilder(column: $table.login, builder: (column) => column);

  GeneratedColumn<bool> get deleteRelatedThings => $composableBuilder(
    column: $table.deleteRelatedThings,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            Setting,
            BaseReferences<_$MyEncryptedDatabase, $SettingsTable, Setting>,
          ),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$MyEncryptedDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> isBackupNeeded = const Value.absent(),
                Value<DateTime> lastBackup = const Value.absent(),
                Value<int> login = const Value.absent(),
                Value<bool> deleteRelatedThings = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                isBackupNeeded: isBackupNeeded,
                lastBackup: lastBackup,
                login: login,
                deleteRelatedThings: deleteRelatedThings,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required bool isBackupNeeded,
                required DateTime lastBackup,
                required int login,
                required bool deleteRelatedThings,
              }) => SettingsCompanion.insert(
                id: id,
                isBackupNeeded: isBackupNeeded,
                lastBackup: lastBackup,
                login: login,
                deleteRelatedThings: deleteRelatedThings,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$MyEncryptedDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$TodoElementTableCreateCompanionBuilder =
    TodoElementCompanion Function({
      Value<int> id,
      required String name,
      required String lastModified,
      required String position,
      required int listParent,
      Value<bool> isChecked,
      required String notes,
      Value<int?> relatedElementId,
      Value<String> tags,
    });
typedef $$TodoElementTableUpdateCompanionBuilder =
    TodoElementCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> lastModified,
      Value<String> position,
      Value<int> listParent,
      Value<bool> isChecked,
      Value<String> notes,
      Value<int?> relatedElementId,
      Value<String> tags,
    });

final class $$TodoElementTableReferences
    extends
        BaseReferences<
          _$MyEncryptedDatabase,
          $TodoElementTable,
          TodoElementData
        > {
  $$TodoElementTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MyListTable _listParentTable(_$MyEncryptedDatabase db) =>
      db.myList.createAlias('todo_element__list_parent__my_list__id');

  $$MyListTableProcessedTableManager get listParent {
    final $_column = $_itemColumn<int>('list_parent')!;

    final manager = $$MyListTableTableManager(
      $_db,
      $_db.myList,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_listParentTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TodoElementTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $TodoElementTable> {
  $$TodoElementTableFilterComposer({
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

  ColumnFilters<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get relatedElementId => $composableBuilder(
    column: $table.relatedElementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  $$MyListTableFilterComposer get listParent {
    final $$MyListTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableFilterComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoElementTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $TodoElementTable> {
  $$TodoElementTableOrderingComposer({
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

  ColumnOrderings<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isChecked => $composableBuilder(
    column: $table.isChecked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get relatedElementId => $composableBuilder(
    column: $table.relatedElementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  $$MyListTableOrderingComposer get listParent {
    final $$MyListTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableOrderingComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoElementTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $TodoElementTable> {
  $$TodoElementTableAnnotationComposer({
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

  GeneratedColumn<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get isChecked =>
      $composableBuilder(column: $table.isChecked, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get relatedElementId => $composableBuilder(
    column: $table.relatedElementId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  $$MyListTableAnnotationComposer get listParent {
    final $$MyListTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.listParent,
      referencedTable: $db.myList,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MyListTableAnnotationComposer(
            $db: $db,
            $table: $db.myList,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TodoElementTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $TodoElementTable,
          TodoElementData,
          $$TodoElementTableFilterComposer,
          $$TodoElementTableOrderingComposer,
          $$TodoElementTableAnnotationComposer,
          $$TodoElementTableCreateCompanionBuilder,
          $$TodoElementTableUpdateCompanionBuilder,
          (TodoElementData, $$TodoElementTableReferences),
          TodoElementData,
          PrefetchHooks Function({bool listParent})
        > {
  $$TodoElementTableTableManager(
    _$MyEncryptedDatabase db,
    $TodoElementTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TodoElementTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TodoElementTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TodoElementTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> lastModified = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<int> listParent = const Value.absent(),
                Value<bool> isChecked = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int?> relatedElementId = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => TodoElementCompanion(
                id: id,
                name: name,
                lastModified: lastModified,
                position: position,
                listParent: listParent,
                isChecked: isChecked,
                notes: notes,
                relatedElementId: relatedElementId,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String lastModified,
                required String position,
                required int listParent,
                Value<bool> isChecked = const Value.absent(),
                required String notes,
                Value<int?> relatedElementId = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => TodoElementCompanion.insert(
                id: id,
                name: name,
                lastModified: lastModified,
                position: position,
                listParent: listParent,
                isChecked: isChecked,
                notes: notes,
                relatedElementId: relatedElementId,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TodoElementTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({listParent = false}) {
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
                    if (listParent) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.listParent,
                                referencedTable: $$TodoElementTableReferences
                                    ._listParentTable(db),
                                referencedColumn: $$TodoElementTableReferences
                                    ._listParentTable(db)
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

typedef $$TodoElementTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $TodoElementTable,
      TodoElementData,
      $$TodoElementTableFilterComposer,
      $$TodoElementTableOrderingComposer,
      $$TodoElementTableAnnotationComposer,
      $$TodoElementTableCreateCompanionBuilder,
      $$TodoElementTableUpdateCompanionBuilder,
      (TodoElementData, $$TodoElementTableReferences),
      TodoElementData,
      PrefetchHooks Function({bool listParent})
    >;
typedef $$TaskTableCreateCompanionBuilder =
    TaskCompanion Function({
      Value<int> id,
      required String creationTime,
      required String name,
      required String startingDay,
      Value<String?> finishDay,
      required bool flexibleTime,
      Value<String?> beginningTime,
      Value<String?> endingTime,
      required String notes,
      required int repeatType,
      required bool customRepeat,
      Value<int?> daily,
      Value<String?> weekly,
      Value<int?> monthly,
      Value<int?> yearly,
      Value<bool> active,
      Value<String> checkDays,
      Value<bool> finished,
      required String lastModified,
      Value<int?> relatedElementId,
      Value<String> tags,
    });
typedef $$TaskTableUpdateCompanionBuilder =
    TaskCompanion Function({
      Value<int> id,
      Value<String> creationTime,
      Value<String> name,
      Value<String> startingDay,
      Value<String?> finishDay,
      Value<bool> flexibleTime,
      Value<String?> beginningTime,
      Value<String?> endingTime,
      Value<String> notes,
      Value<int> repeatType,
      Value<bool> customRepeat,
      Value<int?> daily,
      Value<String?> weekly,
      Value<int?> monthly,
      Value<int?> yearly,
      Value<bool> active,
      Value<String> checkDays,
      Value<bool> finished,
      Value<String> lastModified,
      Value<int?> relatedElementId,
      Value<String> tags,
    });

class $$TaskTableFilterComposer
    extends Composer<_$MyEncryptedDatabase, $TaskTable> {
  $$TaskTableFilterComposer({
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

  ColumnFilters<String> get creationTime => $composableBuilder(
    column: $table.creationTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startingDay => $composableBuilder(
    column: $table.startingDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get finishDay => $composableBuilder(
    column: $table.finishDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get flexibleTime => $composableBuilder(
    column: $table.flexibleTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get beginningTime => $composableBuilder(
    column: $table.beginningTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get endingTime => $composableBuilder(
    column: $table.endingTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get repeatType => $composableBuilder(
    column: $table.repeatType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get customRepeat => $composableBuilder(
    column: $table.customRepeat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get daily => $composableBuilder(
    column: $table.daily,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weekly => $composableBuilder(
    column: $table.weekly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get monthly => $composableBuilder(
    column: $table.monthly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get yearly => $composableBuilder(
    column: $table.yearly,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkDays => $composableBuilder(
    column: $table.checkDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get finished => $composableBuilder(
    column: $table.finished,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get relatedElementId => $composableBuilder(
    column: $table.relatedElementId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TaskTableOrderingComposer
    extends Composer<_$MyEncryptedDatabase, $TaskTable> {
  $$TaskTableOrderingComposer({
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

  ColumnOrderings<String> get creationTime => $composableBuilder(
    column: $table.creationTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startingDay => $composableBuilder(
    column: $table.startingDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get finishDay => $composableBuilder(
    column: $table.finishDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get flexibleTime => $composableBuilder(
    column: $table.flexibleTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get beginningTime => $composableBuilder(
    column: $table.beginningTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get endingTime => $composableBuilder(
    column: $table.endingTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get repeatType => $composableBuilder(
    column: $table.repeatType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get customRepeat => $composableBuilder(
    column: $table.customRepeat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get daily => $composableBuilder(
    column: $table.daily,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weekly => $composableBuilder(
    column: $table.weekly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get monthly => $composableBuilder(
    column: $table.monthly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get yearly => $composableBuilder(
    column: $table.yearly,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get active => $composableBuilder(
    column: $table.active,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkDays => $composableBuilder(
    column: $table.checkDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get finished => $composableBuilder(
    column: $table.finished,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get relatedElementId => $composableBuilder(
    column: $table.relatedElementId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TaskTableAnnotationComposer
    extends Composer<_$MyEncryptedDatabase, $TaskTable> {
  $$TaskTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get creationTime => $composableBuilder(
    column: $table.creationTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get startingDay => $composableBuilder(
    column: $table.startingDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get finishDay =>
      $composableBuilder(column: $table.finishDay, builder: (column) => column);

  GeneratedColumn<bool> get flexibleTime => $composableBuilder(
    column: $table.flexibleTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get beginningTime => $composableBuilder(
    column: $table.beginningTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get endingTime => $composableBuilder(
    column: $table.endingTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get repeatType => $composableBuilder(
    column: $table.repeatType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get customRepeat => $composableBuilder(
    column: $table.customRepeat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get daily =>
      $composableBuilder(column: $table.daily, builder: (column) => column);

  GeneratedColumn<String> get weekly =>
      $composableBuilder(column: $table.weekly, builder: (column) => column);

  GeneratedColumn<int> get monthly =>
      $composableBuilder(column: $table.monthly, builder: (column) => column);

  GeneratedColumn<int> get yearly =>
      $composableBuilder(column: $table.yearly, builder: (column) => column);

  GeneratedColumn<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get checkDays =>
      $composableBuilder(column: $table.checkDays, builder: (column) => column);

  GeneratedColumn<bool> get finished =>
      $composableBuilder(column: $table.finished, builder: (column) => column);

  GeneratedColumn<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<int> get relatedElementId => $composableBuilder(
    column: $table.relatedElementId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);
}

class $$TaskTableTableManager
    extends
        RootTableManager<
          _$MyEncryptedDatabase,
          $TaskTable,
          TaskData,
          $$TaskTableFilterComposer,
          $$TaskTableOrderingComposer,
          $$TaskTableAnnotationComposer,
          $$TaskTableCreateCompanionBuilder,
          $$TaskTableUpdateCompanionBuilder,
          (
            TaskData,
            BaseReferences<_$MyEncryptedDatabase, $TaskTable, TaskData>,
          ),
          TaskData,
          PrefetchHooks Function()
        > {
  $$TaskTableTableManager(_$MyEncryptedDatabase db, $TaskTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> creationTime = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> startingDay = const Value.absent(),
                Value<String?> finishDay = const Value.absent(),
                Value<bool> flexibleTime = const Value.absent(),
                Value<String?> beginningTime = const Value.absent(),
                Value<String?> endingTime = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int> repeatType = const Value.absent(),
                Value<bool> customRepeat = const Value.absent(),
                Value<int?> daily = const Value.absent(),
                Value<String?> weekly = const Value.absent(),
                Value<int?> monthly = const Value.absent(),
                Value<int?> yearly = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String> checkDays = const Value.absent(),
                Value<bool> finished = const Value.absent(),
                Value<String> lastModified = const Value.absent(),
                Value<int?> relatedElementId = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => TaskCompanion(
                id: id,
                creationTime: creationTime,
                name: name,
                startingDay: startingDay,
                finishDay: finishDay,
                flexibleTime: flexibleTime,
                beginningTime: beginningTime,
                endingTime: endingTime,
                notes: notes,
                repeatType: repeatType,
                customRepeat: customRepeat,
                daily: daily,
                weekly: weekly,
                monthly: monthly,
                yearly: yearly,
                active: active,
                checkDays: checkDays,
                finished: finished,
                lastModified: lastModified,
                relatedElementId: relatedElementId,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String creationTime,
                required String name,
                required String startingDay,
                Value<String?> finishDay = const Value.absent(),
                required bool flexibleTime,
                Value<String?> beginningTime = const Value.absent(),
                Value<String?> endingTime = const Value.absent(),
                required String notes,
                required int repeatType,
                required bool customRepeat,
                Value<int?> daily = const Value.absent(),
                Value<String?> weekly = const Value.absent(),
                Value<int?> monthly = const Value.absent(),
                Value<int?> yearly = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String> checkDays = const Value.absent(),
                Value<bool> finished = const Value.absent(),
                required String lastModified,
                Value<int?> relatedElementId = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => TaskCompanion.insert(
                id: id,
                creationTime: creationTime,
                name: name,
                startingDay: startingDay,
                finishDay: finishDay,
                flexibleTime: flexibleTime,
                beginningTime: beginningTime,
                endingTime: endingTime,
                notes: notes,
                repeatType: repeatType,
                customRepeat: customRepeat,
                daily: daily,
                weekly: weekly,
                monthly: monthly,
                yearly: yearly,
                active: active,
                checkDays: checkDays,
                finished: finished,
                lastModified: lastModified,
                relatedElementId: relatedElementId,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TaskTableProcessedTableManager =
    ProcessedTableManager<
      _$MyEncryptedDatabase,
      $TaskTable,
      TaskData,
      $$TaskTableFilterComposer,
      $$TaskTableOrderingComposer,
      $$TaskTableAnnotationComposer,
      $$TaskTableCreateCompanionBuilder,
      $$TaskTableUpdateCompanionBuilder,
      (TaskData, BaseReferences<_$MyEncryptedDatabase, $TaskTable, TaskData>),
      TaskData,
      PrefetchHooks Function()
    >;

class $MyEncryptedDatabaseManager {
  final _$MyEncryptedDatabase _db;
  $MyEncryptedDatabaseManager(this._db);
  $$MyListTableTableManager get myList =>
      $$MyListTableTableManager(_db, _db.myList);
  $$MySublistTableTableManager get mySublist =>
      $$MySublistTableTableManager(_db, _db.mySublist);
  $$MyElementTableTableManager get myElement =>
      $$MyElementTableTableManager(_db, _db.myElement);
  $$DbSettingsTableTableManager get dbSettings =>
      $$DbSettingsTableTableManager(_db, _db.dbSettings);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
  $$TodoElementTableTableManager get todoElement =>
      $$TodoElementTableTableManager(_db, _db.todoElement);
  $$TaskTableTableManager get task => $$TaskTableTableManager(_db, _db.task);
}

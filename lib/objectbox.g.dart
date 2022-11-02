// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'core/entities/account_entity.dart';
import 'core/entities/category_entity.dart';
import 'core/entities/setting_entity.dart';
import 'core/entities/transaction_entity.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8296679817524583314),
      name: 'Account',
      lastPropertyId: const IdUid(4, 7369415057554100201),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2822742064893531904),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3213445006787576109),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5434269270498639034),
            name: 'emoji',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7369415057554100201),
            name: 'active',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(
            name: 'transactions', srcEntity: 'Transaction', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 2501090390936674867),
      name: 'Category',
      lastPropertyId: const IdUid(4, 3090261778419142496),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5084259698215639852),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3623395876573443641),
            name: 'emoji',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2868528120517405448),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3090261778419142496),
            name: 'active',
            type: 1,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(
            name: 'transactions', srcEntity: 'Transaction', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(3, 3459246968913548694),
      name: 'Transaction',
      lastPropertyId: const IdUid(10, 2873775516735302974),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5401636147686944087),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(3, 4911400077816523896),
            name: 'dateTime',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5661597679151332792),
            name: 'categoryId',
            type: 11,
            flags: 520,
            indexId: const IdUid(4, 1894448582879584189),
            relationTarget: 'Category'),
        ModelProperty(
            id: const IdUid(6, 8867703229074338613),
            name: 'accountId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 5021386532645676386),
            relationTarget: 'Account'),
        ModelProperty(
            id: const IdUid(7, 1124505379606616695),
            name: 'amount',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 4915966211244098468),
            name: 'dbType',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 2873775516735302974),
            name: 'note',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 2996561069980989109),
      name: 'SettingEntity',
      lastPropertyId: const IdUid(3, 5450406603083700164),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7393416565991210114),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2215641050921343010),
            name: 'dbLanguage',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5450406603083700164),
            name: 'dbThemeMode',
            type: 6,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 2996561069980989109),
      lastIndexId: const IdUid(4, 1894448582879584189),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [4779389994422262847, 7056461475385909954],
      retiredPropertyUids: const [
        2060229492095202932,
        9080673135740415875,
        1463201996194926459
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Account: EntityDefinition<Account>(
        model: _entities[0],
        toOneRelations: (Account object) => [],
        toManyRelations: (Account object) => {
              RelInfo<Transaction>.toOneBacklink(6, object.id,
                      (Transaction srcObject) => srcObject.account):
                  object.transactions
            },
        getId: (Account object) => object.id,
        setId: (Account object, int id) {
          object.id = id;
        },
        objectToFB: (Account object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final emojiOffset = fbb.writeString(object.emoji);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, emojiOffset);
          fbb.addBool(3, object.active);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Account(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              emoji: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              active: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false));
          InternalToManyAccess.setRelInfo(
              object.transactions,
              store,
              RelInfo<Transaction>.toOneBacklink(
                  6, object.id, (Transaction srcObject) => srcObject.account),
              store.box<Account>());
          return object;
        }),
    Category: EntityDefinition<Category>(
        model: _entities[1],
        toOneRelations: (Category object) => [],
        toManyRelations: (Category object) => {
              RelInfo<Transaction>.toOneBacklink(5, object.id,
                      (Transaction srcObject) => srcObject.category):
                  object.transactions
            },
        getId: (Category object) => object.id,
        setId: (Category object, int id) {
          object.id = id;
        },
        objectToFB: (Category object, fb.Builder fbb) {
          final emojiOffset = fbb.writeString(object.emoji);
          final nameOffset = fbb.writeString(object.name);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, emojiOffset);
          fbb.addOffset(2, nameOffset);
          fbb.addBool(3, object.active);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Category(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              emoji: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              active: const fb.BoolReader()
                  .vTableGet(buffer, rootOffset, 10, false));
          InternalToManyAccess.setRelInfo(
              object.transactions,
              store,
              RelInfo<Transaction>.toOneBacklink(
                  5, object.id, (Transaction srcObject) => srcObject.category),
              store.box<Category>());
          return object;
        }),
    Transaction: EntityDefinition<Transaction>(
        model: _entities[2],
        toOneRelations: (Transaction object) =>
            [object.category, object.account],
        toManyRelations: (Transaction object) => {},
        getId: (Transaction object) => object.id,
        setId: (Transaction object, int id) {
          object.id = id;
        },
        objectToFB: (Transaction object, fb.Builder fbb) {
          final noteOffset = fbb.writeString(object.note);
          fbb.startTable(11);
          fbb.addInt64(0, object.id);
          fbb.addInt64(2, object.dateTime.millisecondsSinceEpoch);
          fbb.addInt64(4, object.category.targetId);
          fbb.addInt64(5, object.account.targetId);
          fbb.addInt64(6, object.amount);
          fbb.addInt64(8, object.dbType);
          fbb.addOffset(9, noteOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Transaction(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              note: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 22, ''),
              dateTime: DateTime.fromMillisecondsSinceEpoch(
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0)),
              amount:
                  const fb.Int64Reader().vTableGet(buffer, rootOffset, 16, 0))
            ..dbType =
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0);
          object.category.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.category.attach(store);
          object.account.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
          object.account.attach(store);
          return object;
        }),
    SettingEntity: EntityDefinition<SettingEntity>(
        model: _entities[3],
        toOneRelations: (SettingEntity object) => [],
        toManyRelations: (SettingEntity object) => {},
        getId: (SettingEntity object) => object.id,
        setId: (SettingEntity object, int id) {
          object.id = id;
        },
        objectToFB: (SettingEntity object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id);
          fbb.addInt64(1, object.dbLanguage);
          fbb.addInt64(2, object.dbThemeMode);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = SettingEntity(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0))
            ..dbLanguage =
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0)
            ..dbThemeMode =
                const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Account] entity fields to define ObjectBox queries.
class Account_ {
  /// see [Account.id]
  static final id = QueryIntegerProperty<Account>(_entities[0].properties[0]);

  /// see [Account.name]
  static final name = QueryStringProperty<Account>(_entities[0].properties[1]);

  /// see [Account.emoji]
  static final emoji = QueryStringProperty<Account>(_entities[0].properties[2]);

  /// see [Account.active]
  static final active =
      QueryBooleanProperty<Account>(_entities[0].properties[3]);
}

/// [Category] entity fields to define ObjectBox queries.
class Category_ {
  /// see [Category.id]
  static final id = QueryIntegerProperty<Category>(_entities[1].properties[0]);

  /// see [Category.emoji]
  static final emoji =
      QueryStringProperty<Category>(_entities[1].properties[1]);

  /// see [Category.name]
  static final name = QueryStringProperty<Category>(_entities[1].properties[2]);

  /// see [Category.active]
  static final active =
      QueryBooleanProperty<Category>(_entities[1].properties[3]);
}

/// [Transaction] entity fields to define ObjectBox queries.
class Transaction_ {
  /// see [Transaction.id]
  static final id =
      QueryIntegerProperty<Transaction>(_entities[2].properties[0]);

  /// see [Transaction.dateTime]
  static final dateTime =
      QueryIntegerProperty<Transaction>(_entities[2].properties[1]);

  /// see [Transaction.category]
  static final category =
      QueryRelationToOne<Transaction, Category>(_entities[2].properties[2]);

  /// see [Transaction.account]
  static final account =
      QueryRelationToOne<Transaction, Account>(_entities[2].properties[3]);

  /// see [Transaction.amount]
  static final amount =
      QueryIntegerProperty<Transaction>(_entities[2].properties[4]);

  /// see [Transaction.dbType]
  static final dbType =
      QueryIntegerProperty<Transaction>(_entities[2].properties[5]);

  /// see [Transaction.note]
  static final note =
      QueryStringProperty<Transaction>(_entities[2].properties[6]);
}

/// [SettingEntity] entity fields to define ObjectBox queries.
class SettingEntity_ {
  /// see [SettingEntity.id]
  static final id =
      QueryIntegerProperty<SettingEntity>(_entities[3].properties[0]);

  /// see [SettingEntity.dbLanguage]
  static final dbLanguage =
      QueryIntegerProperty<SettingEntity>(_entities[3].properties[1]);

  /// see [SettingEntity.dbThemeMode]
  static final dbThemeMode =
      QueryIntegerProperty<SettingEntity>(_entities[3].properties[2]);
}

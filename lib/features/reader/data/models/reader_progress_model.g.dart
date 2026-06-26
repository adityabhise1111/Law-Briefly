// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_progress_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetReaderProgressModelCollection on Isar {
  IsarCollection<ReaderProgressModel> get readerProgressModels =>
      this.collection();
}

const ReaderProgressModelSchema = CollectionSchema(
  name: r'reader_progress',
  id: 5866434735897975621,
  properties: {
    r'contentId': PropertySchema(
      id: 0,
      name: r'contentId',
      type: IsarType.string,
    ),
    r'contentType': PropertySchema(
      id: 1,
      name: r'contentType',
      type: IsarType.string,
      enumMap: _ReaderProgressModelcontentTypeEnumValueMap,
    ),
    r'firstOpenedAt': PropertySchema(
      id: 2,
      name: r'firstOpenedAt',
      type: IsarType.dateTime,
    ),
    r'lastOpenedAt': PropertySchema(
      id: 3,
      name: r'lastOpenedAt',
      type: IsarType.dateTime,
    ),
    r'number': PropertySchema(
      id: 4,
      name: r'number',
      type: IsarType.string,
    ),
    r'scrollOffset': PropertySchema(
      id: 5,
      name: r'scrollOffset',
      type: IsarType.double,
    ),
    r'sourceName': PropertySchema(
      id: 6,
      name: r'sourceName',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 7,
      name: r'title',
      type: IsarType.string,
    ),
    r'totalReadSeconds': PropertySchema(
      id: 8,
      name: r'totalReadSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _readerProgressModelEstimateSize,
  serialize: _readerProgressModelSerialize,
  deserialize: _readerProgressModelDeserialize,
  deserializeProp: _readerProgressModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'contentId': IndexSchema(
      id: -332487537278013663,
      name: r'contentId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'contentId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'lastOpenedAt': IndexSchema(
      id: -3498580983902171062,
      name: r'lastOpenedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastOpenedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _readerProgressModelGetId,
  getLinks: _readerProgressModelGetLinks,
  attach: _readerProgressModelAttach,
  version: '3.1.0+1',
);

int _readerProgressModelEstimateSize(
  ReaderProgressModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.contentId.length * 3;
  bytesCount += 3 + object.contentType.name.length * 3;
  bytesCount += 3 + object.number.length * 3;
  bytesCount += 3 + object.sourceName.length * 3;
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _readerProgressModelSerialize(
  ReaderProgressModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.contentId);
  writer.writeString(offsets[1], object.contentType.name);
  writer.writeDateTime(offsets[2], object.firstOpenedAt);
  writer.writeDateTime(offsets[3], object.lastOpenedAt);
  writer.writeString(offsets[4], object.number);
  writer.writeDouble(offsets[5], object.scrollOffset);
  writer.writeString(offsets[6], object.sourceName);
  writer.writeString(offsets[7], object.title);
  writer.writeLong(offsets[8], object.totalReadSeconds);
}

ReaderProgressModel _readerProgressModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReaderProgressModel();
  object.contentId = reader.readString(offsets[0]);
  object.contentType = _ReaderProgressModelcontentTypeValueEnumMap[
          reader.readStringOrNull(offsets[1])] ??
      ReaderContentType.actSection;
  object.firstOpenedAt = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.lastOpenedAt = reader.readDateTime(offsets[3]);
  object.number = reader.readString(offsets[4]);
  object.scrollOffset = reader.readDouble(offsets[5]);
  object.sourceName = reader.readString(offsets[6]);
  object.title = reader.readString(offsets[7]);
  object.totalReadSeconds = reader.readLong(offsets[8]);
  return object;
}

P _readerProgressModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_ReaderProgressModelcontentTypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          ReaderContentType.actSection) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _ReaderProgressModelcontentTypeEnumValueMap = {
  r'actSection': r'actSection',
  r'constitutionArticle': r'constitutionArticle',
};
const _ReaderProgressModelcontentTypeValueEnumMap = {
  r'actSection': ReaderContentType.actSection,
  r'constitutionArticle': ReaderContentType.constitutionArticle,
};

Id _readerProgressModelGetId(ReaderProgressModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _readerProgressModelGetLinks(
    ReaderProgressModel object) {
  return [];
}

void _readerProgressModelAttach(
    IsarCollection<dynamic> col, Id id, ReaderProgressModel object) {
  object.id = id;
}

extension ReaderProgressModelByIndex on IsarCollection<ReaderProgressModel> {
  Future<ReaderProgressModel?> getByContentId(String contentId) {
    return getByIndex(r'contentId', [contentId]);
  }

  ReaderProgressModel? getByContentIdSync(String contentId) {
    return getByIndexSync(r'contentId', [contentId]);
  }

  Future<bool> deleteByContentId(String contentId) {
    return deleteByIndex(r'contentId', [contentId]);
  }

  bool deleteByContentIdSync(String contentId) {
    return deleteByIndexSync(r'contentId', [contentId]);
  }

  Future<List<ReaderProgressModel?>> getAllByContentId(
      List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'contentId', values);
  }

  List<ReaderProgressModel?> getAllByContentIdSync(
      List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'contentId', values);
  }

  Future<int> deleteAllByContentId(List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'contentId', values);
  }

  int deleteAllByContentIdSync(List<String> contentIdValues) {
    final values = contentIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'contentId', values);
  }

  Future<Id> putByContentId(ReaderProgressModel object) {
    return putByIndex(r'contentId', object);
  }

  Id putByContentIdSync(ReaderProgressModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'contentId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByContentId(List<ReaderProgressModel> objects) {
    return putAllByIndex(r'contentId', objects);
  }

  List<Id> putAllByContentIdSync(List<ReaderProgressModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'contentId', objects, saveLinks: saveLinks);
  }
}

extension ReaderProgressModelQueryWhereSort
    on QueryBuilder<ReaderProgressModel, ReaderProgressModel, QWhere> {
  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhere>
      anyLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lastOpenedAt'),
      );
    });
  }
}

extension ReaderProgressModelQueryWhere
    on QueryBuilder<ReaderProgressModel, ReaderProgressModel, QWhereClause> {
  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      contentIdEqualTo(String contentId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'contentId',
        value: [contentId],
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      contentIdNotEqualTo(String contentId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [],
              upper: [contentId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [contentId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [contentId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'contentId',
              lower: [],
              upper: [contentId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      lastOpenedAtEqualTo(DateTime lastOpenedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastOpenedAt',
        value: [lastOpenedAt],
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      lastOpenedAtNotEqualTo(DateTime lastOpenedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [],
              upper: [lastOpenedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [lastOpenedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [lastOpenedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastOpenedAt',
              lower: [],
              upper: [lastOpenedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      lastOpenedAtGreaterThan(
    DateTime lastOpenedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [lastOpenedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      lastOpenedAtLessThan(
    DateTime lastOpenedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [],
        upper: [lastOpenedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterWhereClause>
      lastOpenedAtBetween(
    DateTime lowerLastOpenedAt,
    DateTime upperLastOpenedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastOpenedAt',
        lower: [lowerLastOpenedAt],
        includeLower: includeLower,
        upper: [upperLastOpenedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReaderProgressModelQueryFilter on QueryBuilder<ReaderProgressModel,
    ReaderProgressModel, QFilterCondition> {
  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentId',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeEqualTo(
    ReaderContentType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeGreaterThan(
    ReaderContentType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeLessThan(
    ReaderContentType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeBetween(
    ReaderContentType lower,
    ReaderContentType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contentType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contentType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contentType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      contentTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contentType',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      firstOpenedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firstOpenedAt',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      firstOpenedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firstOpenedAt',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      firstOpenedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firstOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      firstOpenedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firstOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      firstOpenedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firstOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      firstOpenedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firstOpenedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      lastOpenedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      lastOpenedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      lastOpenedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastOpenedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      lastOpenedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastOpenedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      numberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      scrollOffsetEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scrollOffset',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      scrollOffsetGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scrollOffset',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      scrollOffsetLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scrollOffset',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      scrollOffsetBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scrollOffset',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      sourceNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceName',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      totalReadSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalReadSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      totalReadSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalReadSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      totalReadSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalReadSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterFilterCondition>
      totalReadSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalReadSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ReaderProgressModelQueryObject on QueryBuilder<ReaderProgressModel,
    ReaderProgressModel, QFilterCondition> {}

extension ReaderProgressModelQueryLinks on QueryBuilder<ReaderProgressModel,
    ReaderProgressModel, QFilterCondition> {}

extension ReaderProgressModelQuerySortBy
    on QueryBuilder<ReaderProgressModel, ReaderProgressModel, QSortBy> {
  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByFirstOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstOpenedAt', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByFirstOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstOpenedAt', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByLastOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByScrollOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scrollOffset', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByScrollOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scrollOffset', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByTotalReadSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadSeconds', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      sortByTotalReadSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadSeconds', Sort.desc);
    });
  }
}

extension ReaderProgressModelQuerySortThenBy
    on QueryBuilder<ReaderProgressModel, ReaderProgressModel, QSortThenBy> {
  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByContentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByContentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentId', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByContentType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByContentTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contentType', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByFirstOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstOpenedAt', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByFirstOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firstOpenedAt', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByLastOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastOpenedAt', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByScrollOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scrollOffset', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByScrollOffsetDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scrollOffset', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenBySourceName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenBySourceNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceName', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByTotalReadSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadSeconds', Sort.asc);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QAfterSortBy>
      thenByTotalReadSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalReadSeconds', Sort.desc);
    });
  }
}

extension ReaderProgressModelQueryWhereDistinct
    on QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct> {
  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByContentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByContentType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contentType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByFirstOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firstOpenedAt');
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByLastOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastOpenedAt');
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByNumber({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'number', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByScrollOffset() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scrollOffset');
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctBySourceName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByTitle({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderProgressModel, QDistinct>
      distinctByTotalReadSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalReadSeconds');
    });
  }
}

extension ReaderProgressModelQueryProperty
    on QueryBuilder<ReaderProgressModel, ReaderProgressModel, QQueryProperty> {
  QueryBuilder<ReaderProgressModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ReaderProgressModel, String, QQueryOperations>
      contentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentId');
    });
  }

  QueryBuilder<ReaderProgressModel, ReaderContentType, QQueryOperations>
      contentTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contentType');
    });
  }

  QueryBuilder<ReaderProgressModel, DateTime?, QQueryOperations>
      firstOpenedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firstOpenedAt');
    });
  }

  QueryBuilder<ReaderProgressModel, DateTime, QQueryOperations>
      lastOpenedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastOpenedAt');
    });
  }

  QueryBuilder<ReaderProgressModel, String, QQueryOperations> numberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'number');
    });
  }

  QueryBuilder<ReaderProgressModel, double, QQueryOperations>
      scrollOffsetProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scrollOffset');
    });
  }

  QueryBuilder<ReaderProgressModel, String, QQueryOperations>
      sourceNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceName');
    });
  }

  QueryBuilder<ReaderProgressModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<ReaderProgressModel, int, QQueryOperations>
      totalReadSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalReadSeconds');
    });
  }
}

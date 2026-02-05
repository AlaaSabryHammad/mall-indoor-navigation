// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _aisleNumberMeta =
      const VerificationMeta('aisleNumber');
  @override
  late final GeneratedColumn<String> aisleNumber = GeneratedColumn<String>(
      'aisle_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _shelfNumberMeta =
      const VerificationMeta('shelfNumber');
  @override
  late final GeneratedColumn<String> shelfNumber = GeneratedColumn<String>(
      'shelf_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _locationXMeta =
      const VerificationMeta('locationX');
  @override
  late final GeneratedColumn<double> locationX = GeneratedColumn<double>(
      'location_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _locationYMeta =
      const VerificationMeta('locationY');
  @override
  late final GeneratedColumn<double> locationY = GeneratedColumn<double>(
      'location_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        barcode,
        category,
        description,
        imageUrl,
        quantity,
        aisleNumber,
        shelfNumber,
        locationX,
        locationY,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(Insertable<Product> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('aisle_number')) {
      context.handle(
          _aisleNumberMeta,
          aisleNumber.isAcceptableOrUnknown(
              data['aisle_number']!, _aisleNumberMeta));
    } else if (isInserting) {
      context.missing(_aisleNumberMeta);
    }
    if (data.containsKey('shelf_number')) {
      context.handle(
          _shelfNumberMeta,
          shelfNumber.isAcceptableOrUnknown(
              data['shelf_number']!, _shelfNumberMeta));
    } else if (isInserting) {
      context.missing(_shelfNumberMeta);
    }
    if (data.containsKey('location_x')) {
      context.handle(_locationXMeta,
          locationX.isAcceptableOrUnknown(data['location_x']!, _locationXMeta));
    } else if (isInserting) {
      context.missing(_locationXMeta);
    }
    if (data.containsKey('location_y')) {
      context.handle(_locationYMeta,
          locationY.isAcceptableOrUnknown(data['location_y']!, _locationYMeta));
    } else if (isInserting) {
      context.missing(_locationYMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      aisleNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}aisle_number'])!,
      shelfNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}shelf_number'])!,
      locationX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_x'])!,
      locationY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}location_y'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String id;
  final String name;
  final String barcode;
  final String category;
  final String description;
  final String? imageUrl;
  final int quantity;
  final String aisleNumber;
  final String shelfNumber;
  final double locationX;
  final double locationY;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Product(
      {required this.id,
      required this.name,
      required this.barcode,
      required this.category,
      required this.description,
      this.imageUrl,
      required this.quantity,
      required this.aisleNumber,
      required this.shelfNumber,
      required this.locationX,
      required this.locationY,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['barcode'] = Variable<String>(barcode);
    map['category'] = Variable<String>(category);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['quantity'] = Variable<int>(quantity);
    map['aisle_number'] = Variable<String>(aisleNumber);
    map['shelf_number'] = Variable<String>(shelfNumber);
    map['location_x'] = Variable<double>(locationX);
    map['location_y'] = Variable<double>(locationY);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      id: Value(id),
      name: Value(name),
      barcode: Value(barcode),
      category: Value(category),
      description: Value(description),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      quantity: Value(quantity),
      aisleNumber: Value(aisleNumber),
      shelfNumber: Value(shelfNumber),
      locationX: Value(locationX),
      locationY: Value(locationY),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Product.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      barcode: serializer.fromJson<String>(json['barcode']),
      category: serializer.fromJson<String>(json['category']),
      description: serializer.fromJson<String>(json['description']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      quantity: serializer.fromJson<int>(json['quantity']),
      aisleNumber: serializer.fromJson<String>(json['aisleNumber']),
      shelfNumber: serializer.fromJson<String>(json['shelfNumber']),
      locationX: serializer.fromJson<double>(json['locationX']),
      locationY: serializer.fromJson<double>(json['locationY']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'barcode': serializer.toJson<String>(barcode),
      'category': serializer.toJson<String>(category),
      'description': serializer.toJson<String>(description),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'quantity': serializer.toJson<int>(quantity),
      'aisleNumber': serializer.toJson<String>(aisleNumber),
      'shelfNumber': serializer.toJson<String>(shelfNumber),
      'locationX': serializer.toJson<double>(locationX),
      'locationY': serializer.toJson<double>(locationY),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Product copyWith(
          {String? id,
          String? name,
          String? barcode,
          String? category,
          String? description,
          Value<String?> imageUrl = const Value.absent(),
          int? quantity,
          String? aisleNumber,
          String? shelfNumber,
          double? locationX,
          double? locationY,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        barcode: barcode ?? this.barcode,
        category: category ?? this.category,
        description: description ?? this.description,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        quantity: quantity ?? this.quantity,
        aisleNumber: aisleNumber ?? this.aisleNumber,
        shelfNumber: shelfNumber ?? this.shelfNumber,
        locationX: locationX ?? this.locationX,
        locationY: locationY ?? this.locationY,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      category: data.category.present ? data.category.value : this.category,
      description:
          data.description.present ? data.description.value : this.description,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      aisleNumber:
          data.aisleNumber.present ? data.aisleNumber.value : this.aisleNumber,
      shelfNumber:
          data.shelfNumber.present ? data.shelfNumber.value : this.shelfNumber,
      locationX: data.locationX.present ? data.locationX.value : this.locationX,
      locationY: data.locationY.present ? data.locationY.value : this.locationY,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('quantity: $quantity, ')
          ..write('aisleNumber: $aisleNumber, ')
          ..write('shelfNumber: $shelfNumber, ')
          ..write('locationX: $locationX, ')
          ..write('locationY: $locationY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      barcode,
      category,
      description,
      imageUrl,
      quantity,
      aisleNumber,
      shelfNumber,
      locationX,
      locationY,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.id == this.id &&
          other.name == this.name &&
          other.barcode == this.barcode &&
          other.category == this.category &&
          other.description == this.description &&
          other.imageUrl == this.imageUrl &&
          other.quantity == this.quantity &&
          other.aisleNumber == this.aisleNumber &&
          other.shelfNumber == this.shelfNumber &&
          other.locationX == this.locationX &&
          other.locationY == this.locationY &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> barcode;
  final Value<String> category;
  final Value<String> description;
  final Value<String?> imageUrl;
  final Value<int> quantity;
  final Value<String> aisleNumber;
  final Value<String> shelfNumber;
  final Value<double> locationX;
  final Value<double> locationY;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProductsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.barcode = const Value.absent(),
    this.category = const Value.absent(),
    this.description = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.quantity = const Value.absent(),
    this.aisleNumber = const Value.absent(),
    this.shelfNumber = const Value.absent(),
    this.locationX = const Value.absent(),
    this.locationY = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String id,
    required String name,
    required String barcode,
    required String category,
    required String description,
    this.imageUrl = const Value.absent(),
    required int quantity,
    required String aisleNumber,
    required String shelfNumber,
    required double locationX,
    required double locationY,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        barcode = Value(barcode),
        category = Value(category),
        description = Value(description),
        quantity = Value(quantity),
        aisleNumber = Value(aisleNumber),
        shelfNumber = Value(shelfNumber),
        locationX = Value(locationX),
        locationY = Value(locationY),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Product> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? barcode,
    Expression<String>? category,
    Expression<String>? description,
    Expression<String>? imageUrl,
    Expression<int>? quantity,
    Expression<String>? aisleNumber,
    Expression<String>? shelfNumber,
    Expression<double>? locationX,
    Expression<double>? locationY,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (barcode != null) 'barcode': barcode,
      if (category != null) 'category': category,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
      if (quantity != null) 'quantity': quantity,
      if (aisleNumber != null) 'aisle_number': aisleNumber,
      if (shelfNumber != null) 'shelf_number': shelfNumber,
      if (locationX != null) 'location_x': locationX,
      if (locationY != null) 'location_y': locationY,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? barcode,
      Value<String>? category,
      Value<String>? description,
      Value<String?>? imageUrl,
      Value<int>? quantity,
      Value<String>? aisleNumber,
      Value<String>? shelfNumber,
      Value<double>? locationX,
      Value<double>? locationY,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return ProductsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      category: category ?? this.category,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      aisleNumber: aisleNumber ?? this.aisleNumber,
      shelfNumber: shelfNumber ?? this.shelfNumber,
      locationX: locationX ?? this.locationX,
      locationY: locationY ?? this.locationY,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (aisleNumber.present) {
      map['aisle_number'] = Variable<String>(aisleNumber.value);
    }
    if (shelfNumber.present) {
      map['shelf_number'] = Variable<String>(shelfNumber.value);
    }
    if (locationX.present) {
      map['location_x'] = Variable<double>(locationX.value);
    }
    if (locationY.present) {
      map['location_y'] = Variable<double>(locationY.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('ProductsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('barcode: $barcode, ')
          ..write('category: $category, ')
          ..write('description: $description, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('quantity: $quantity, ')
          ..write('aisleNumber: $aisleNumber, ')
          ..write('shelfNumber: $shelfNumber, ')
          ..write('locationX: $locationX, ')
          ..write('locationY: $locationY, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoreMapsTable extends StoreMaps
    with TableInfo<$StoreMapsTable, StoreMap> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoreMapsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _widthMeta = const VerificationMeta('width');
  @override
  late final GeneratedColumn<double> width = GeneratedColumn<double>(
      'width', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, imageUrl, width, height, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'store_maps';
  @override
  VerificationContext validateIntegrity(Insertable<StoreMap> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    } else if (isInserting) {
      context.missing(_imageUrlMeta);
    }
    if (data.containsKey('width')) {
      context.handle(
          _widthMeta, width.isAcceptableOrUnknown(data['width']!, _widthMeta));
    } else if (isInserting) {
      context.missing(_widthMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoreMap map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreMap(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url'])!,
      width: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}width'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $StoreMapsTable createAlias(String alias) {
    return $StoreMapsTable(attachedDatabase, alias);
  }
}

class StoreMap extends DataClass implements Insertable<StoreMap> {
  final String id;
  final String name;
  final String imageUrl;
  final double width;
  final double height;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StoreMap(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.width,
      required this.height,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['image_url'] = Variable<String>(imageUrl);
    map['width'] = Variable<double>(width);
    map['height'] = Variable<double>(height);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StoreMapsCompanion toCompanion(bool nullToAbsent) {
    return StoreMapsCompanion(
      id: Value(id),
      name: Value(name),
      imageUrl: Value(imageUrl),
      width: Value(width),
      height: Value(height),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StoreMap.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreMap(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      imageUrl: serializer.fromJson<String>(json['imageUrl']),
      width: serializer.fromJson<double>(json['width']),
      height: serializer.fromJson<double>(json['height']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'imageUrl': serializer.toJson<String>(imageUrl),
      'width': serializer.toJson<double>(width),
      'height': serializer.toJson<double>(height),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StoreMap copyWith(
          {String? id,
          String? name,
          String? imageUrl,
          double? width,
          double? height,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      StoreMap(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        width: width ?? this.width,
        height: height ?? this.height,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  StoreMap copyWithCompanion(StoreMapsCompanion data) {
    return StoreMap(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      width: data.width.present ? data.width.value : this.width,
      height: data.height.present ? data.height.value : this.height,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreMap(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, imageUrl, width, height, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreMap &&
          other.id == this.id &&
          other.name == this.name &&
          other.imageUrl == this.imageUrl &&
          other.width == this.width &&
          other.height == this.height &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StoreMapsCompanion extends UpdateCompanion<StoreMap> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> imageUrl;
  final Value<double> width;
  final Value<double> height;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StoreMapsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.width = const Value.absent(),
    this.height = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoreMapsCompanion.insert({
    required String id,
    required String name,
    required String imageUrl,
    required double width,
    required double height,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        imageUrl = Value(imageUrl),
        width = Value(width),
        height = Value(height),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<StoreMap> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? imageUrl,
    Expression<double>? width,
    Expression<double>? height,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (imageUrl != null) 'image_url': imageUrl,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoreMapsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? imageUrl,
      Value<double>? width,
      Value<double>? height,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return StoreMapsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      width: width ?? this.width,
      height: height ?? this.height,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
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
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (width.present) {
      map['width'] = Variable<double>(width.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
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
    return (StringBuffer('StoreMapsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('width: $width, ')
          ..write('height: $height, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PathNodesTable extends PathNodes
    with TableInfo<$PathNodesTable, PathNode> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PathNodesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionXMeta =
      const VerificationMeta('positionX');
  @override
  late final GeneratedColumn<double> positionX = GeneratedColumn<double>(
      'position_x', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _positionYMeta =
      const VerificationMeta('positionY');
  @override
  late final GeneratedColumn<double> positionY = GeneratedColumn<double>(
      'position_y', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isWalkableMeta =
      const VerificationMeta('isWalkable');
  @override
  late final GeneratedColumn<bool> isWalkable = GeneratedColumn<bool>(
      'is_walkable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_walkable" IN (0, 1))'));
  static const VerificationMeta _connectedNodeIdsMeta =
      const VerificationMeta('connectedNodeIds');
  @override
  late final GeneratedColumn<String> connectedNodeIds = GeneratedColumn<String>(
      'connected_node_ids', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, positionX, positionY, isWalkable, connectedNodeIds];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'path_nodes';
  @override
  VerificationContext validateIntegrity(Insertable<PathNode> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('position_x')) {
      context.handle(_positionXMeta,
          positionX.isAcceptableOrUnknown(data['position_x']!, _positionXMeta));
    } else if (isInserting) {
      context.missing(_positionXMeta);
    }
    if (data.containsKey('position_y')) {
      context.handle(_positionYMeta,
          positionY.isAcceptableOrUnknown(data['position_y']!, _positionYMeta));
    } else if (isInserting) {
      context.missing(_positionYMeta);
    }
    if (data.containsKey('is_walkable')) {
      context.handle(
          _isWalkableMeta,
          isWalkable.isAcceptableOrUnknown(
              data['is_walkable']!, _isWalkableMeta));
    } else if (isInserting) {
      context.missing(_isWalkableMeta);
    }
    if (data.containsKey('connected_node_ids')) {
      context.handle(
          _connectedNodeIdsMeta,
          connectedNodeIds.isAcceptableOrUnknown(
              data['connected_node_ids']!, _connectedNodeIdsMeta));
    } else if (isInserting) {
      context.missing(_connectedNodeIdsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PathNode map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PathNode(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      positionX: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_x'])!,
      positionY: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}position_y'])!,
      isWalkable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_walkable'])!,
      connectedNodeIds: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}connected_node_ids'])!,
    );
  }

  @override
  $PathNodesTable createAlias(String alias) {
    return $PathNodesTable(attachedDatabase, alias);
  }
}

class PathNode extends DataClass implements Insertable<PathNode> {
  final String id;
  final double positionX;
  final double positionY;
  final bool isWalkable;
  final String connectedNodeIds;
  const PathNode(
      {required this.id,
      required this.positionX,
      required this.positionY,
      required this.isWalkable,
      required this.connectedNodeIds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['position_x'] = Variable<double>(positionX);
    map['position_y'] = Variable<double>(positionY);
    map['is_walkable'] = Variable<bool>(isWalkable);
    map['connected_node_ids'] = Variable<String>(connectedNodeIds);
    return map;
  }

  PathNodesCompanion toCompanion(bool nullToAbsent) {
    return PathNodesCompanion(
      id: Value(id),
      positionX: Value(positionX),
      positionY: Value(positionY),
      isWalkable: Value(isWalkable),
      connectedNodeIds: Value(connectedNodeIds),
    );
  }

  factory PathNode.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PathNode(
      id: serializer.fromJson<String>(json['id']),
      positionX: serializer.fromJson<double>(json['positionX']),
      positionY: serializer.fromJson<double>(json['positionY']),
      isWalkable: serializer.fromJson<bool>(json['isWalkable']),
      connectedNodeIds: serializer.fromJson<String>(json['connectedNodeIds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'positionX': serializer.toJson<double>(positionX),
      'positionY': serializer.toJson<double>(positionY),
      'isWalkable': serializer.toJson<bool>(isWalkable),
      'connectedNodeIds': serializer.toJson<String>(connectedNodeIds),
    };
  }

  PathNode copyWith(
          {String? id,
          double? positionX,
          double? positionY,
          bool? isWalkable,
          String? connectedNodeIds}) =>
      PathNode(
        id: id ?? this.id,
        positionX: positionX ?? this.positionX,
        positionY: positionY ?? this.positionY,
        isWalkable: isWalkable ?? this.isWalkable,
        connectedNodeIds: connectedNodeIds ?? this.connectedNodeIds,
      );
  PathNode copyWithCompanion(PathNodesCompanion data) {
    return PathNode(
      id: data.id.present ? data.id.value : this.id,
      positionX: data.positionX.present ? data.positionX.value : this.positionX,
      positionY: data.positionY.present ? data.positionY.value : this.positionY,
      isWalkable:
          data.isWalkable.present ? data.isWalkable.value : this.isWalkable,
      connectedNodeIds: data.connectedNodeIds.present
          ? data.connectedNodeIds.value
          : this.connectedNodeIds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PathNode(')
          ..write('id: $id, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('isWalkable: $isWalkable, ')
          ..write('connectedNodeIds: $connectedNodeIds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, positionX, positionY, isWalkable, connectedNodeIds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PathNode &&
          other.id == this.id &&
          other.positionX == this.positionX &&
          other.positionY == this.positionY &&
          other.isWalkable == this.isWalkable &&
          other.connectedNodeIds == this.connectedNodeIds);
}

class PathNodesCompanion extends UpdateCompanion<PathNode> {
  final Value<String> id;
  final Value<double> positionX;
  final Value<double> positionY;
  final Value<bool> isWalkable;
  final Value<String> connectedNodeIds;
  final Value<int> rowid;
  const PathNodesCompanion({
    this.id = const Value.absent(),
    this.positionX = const Value.absent(),
    this.positionY = const Value.absent(),
    this.isWalkable = const Value.absent(),
    this.connectedNodeIds = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PathNodesCompanion.insert({
    required String id,
    required double positionX,
    required double positionY,
    required bool isWalkable,
    required String connectedNodeIds,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        positionX = Value(positionX),
        positionY = Value(positionY),
        isWalkable = Value(isWalkable),
        connectedNodeIds = Value(connectedNodeIds);
  static Insertable<PathNode> custom({
    Expression<String>? id,
    Expression<double>? positionX,
    Expression<double>? positionY,
    Expression<bool>? isWalkable,
    Expression<String>? connectedNodeIds,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (positionX != null) 'position_x': positionX,
      if (positionY != null) 'position_y': positionY,
      if (isWalkable != null) 'is_walkable': isWalkable,
      if (connectedNodeIds != null) 'connected_node_ids': connectedNodeIds,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PathNodesCompanion copyWith(
      {Value<String>? id,
      Value<double>? positionX,
      Value<double>? positionY,
      Value<bool>? isWalkable,
      Value<String>? connectedNodeIds,
      Value<int>? rowid}) {
    return PathNodesCompanion(
      id: id ?? this.id,
      positionX: positionX ?? this.positionX,
      positionY: positionY ?? this.positionY,
      isWalkable: isWalkable ?? this.isWalkable,
      connectedNodeIds: connectedNodeIds ?? this.connectedNodeIds,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (positionX.present) {
      map['position_x'] = Variable<double>(positionX.value);
    }
    if (positionY.present) {
      map['position_y'] = Variable<double>(positionY.value);
    }
    if (isWalkable.present) {
      map['is_walkable'] = Variable<bool>(isWalkable.value);
    }
    if (connectedNodeIds.present) {
      map['connected_node_ids'] = Variable<String>(connectedNodeIds.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PathNodesCompanion(')
          ..write('id: $id, ')
          ..write('positionX: $positionX, ')
          ..write('positionY: $positionY, ')
          ..write('isWalkable: $isWalkable, ')
          ..write('connectedNodeIds: $connectedNodeIds, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductsTable products = $ProductsTable(this);
  late final $StoreMapsTable storeMaps = $StoreMapsTable(this);
  late final $PathNodesTable pathNodes = $PathNodesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [products, storeMaps, pathNodes];
}

typedef $$ProductsTableCreateCompanionBuilder = ProductsCompanion Function({
  required String id,
  required String name,
  required String barcode,
  required String category,
  required String description,
  Value<String?> imageUrl,
  required int quantity,
  required String aisleNumber,
  required String shelfNumber,
  required double locationX,
  required double locationY,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ProductsTableUpdateCompanionBuilder = ProductsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> barcode,
  Value<String> category,
  Value<String> description,
  Value<String?> imageUrl,
  Value<int> quantity,
  Value<String> aisleNumber,
  Value<String> shelfNumber,
  Value<double> locationX,
  Value<double> locationY,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get aisleNumber => $composableBuilder(
      column: $table.aisleNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shelfNumber => $composableBuilder(
      column: $table.shelfNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationX => $composableBuilder(
      column: $table.locationX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get locationY => $composableBuilder(
      column: $table.locationY, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get aisleNumber => $composableBuilder(
      column: $table.aisleNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shelfNumber => $composableBuilder(
      column: $table.shelfNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationX => $composableBuilder(
      column: $table.locationX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get locationY => $composableBuilder(
      column: $table.locationY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
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

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get aisleNumber => $composableBuilder(
      column: $table.aisleNumber, builder: (column) => column);

  GeneratedColumn<String> get shelfNumber => $composableBuilder(
      column: $table.shelfNumber, builder: (column) => column);

  GeneratedColumn<double> get locationX =>
      $composableBuilder(column: $table.locationX, builder: (column) => column);

  GeneratedColumn<double> get locationY =>
      $composableBuilder(column: $table.locationY, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProductsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()> {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> barcode = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String> aisleNumber = const Value.absent(),
            Value<String> shelfNumber = const Value.absent(),
            Value<double> locationX = const Value.absent(),
            Value<double> locationY = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion(
            id: id,
            name: name,
            barcode: barcode,
            category: category,
            description: description,
            imageUrl: imageUrl,
            quantity: quantity,
            aisleNumber: aisleNumber,
            shelfNumber: shelfNumber,
            locationX: locationX,
            locationY: locationY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String barcode,
            required String category,
            required String description,
            Value<String?> imageUrl = const Value.absent(),
            required int quantity,
            required String aisleNumber,
            required String shelfNumber,
            required double locationX,
            required double locationY,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              ProductsCompanion.insert(
            id: id,
            name: name,
            barcode: barcode,
            category: category,
            description: description,
            imageUrl: imageUrl,
            quantity: quantity,
            aisleNumber: aisleNumber,
            shelfNumber: shelfNumber,
            locationX: locationX,
            locationY: locationY,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ProductsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ProductsTable,
    Product,
    $$ProductsTableFilterComposer,
    $$ProductsTableOrderingComposer,
    $$ProductsTableAnnotationComposer,
    $$ProductsTableCreateCompanionBuilder,
    $$ProductsTableUpdateCompanionBuilder,
    (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
    Product,
    PrefetchHooks Function()>;
typedef $$StoreMapsTableCreateCompanionBuilder = StoreMapsCompanion Function({
  required String id,
  required String name,
  required String imageUrl,
  required double width,
  required double height,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$StoreMapsTableUpdateCompanionBuilder = StoreMapsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> imageUrl,
  Value<double> width,
  Value<double> height,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$StoreMapsTableFilterComposer
    extends Composer<_$AppDatabase, $StoreMapsTable> {
  $$StoreMapsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$StoreMapsTableOrderingComposer
    extends Composer<_$AppDatabase, $StoreMapsTable> {
  $$StoreMapsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get width => $composableBuilder(
      column: $table.width, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$StoreMapsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoreMapsTable> {
  $$StoreMapsTableAnnotationComposer({
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

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<double> get width =>
      $composableBuilder(column: $table.width, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StoreMapsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StoreMapsTable,
    StoreMap,
    $$StoreMapsTableFilterComposer,
    $$StoreMapsTableOrderingComposer,
    $$StoreMapsTableAnnotationComposer,
    $$StoreMapsTableCreateCompanionBuilder,
    $$StoreMapsTableUpdateCompanionBuilder,
    (StoreMap, BaseReferences<_$AppDatabase, $StoreMapsTable, StoreMap>),
    StoreMap,
    PrefetchHooks Function()> {
  $$StoreMapsTableTableManager(_$AppDatabase db, $StoreMapsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoreMapsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoreMapsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoreMapsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> imageUrl = const Value.absent(),
            Value<double> width = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StoreMapsCompanion(
            id: id,
            name: name,
            imageUrl: imageUrl,
            width: width,
            height: height,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String imageUrl,
            required double width,
            required double height,
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              StoreMapsCompanion.insert(
            id: id,
            name: name,
            imageUrl: imageUrl,
            width: width,
            height: height,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StoreMapsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StoreMapsTable,
    StoreMap,
    $$StoreMapsTableFilterComposer,
    $$StoreMapsTableOrderingComposer,
    $$StoreMapsTableAnnotationComposer,
    $$StoreMapsTableCreateCompanionBuilder,
    $$StoreMapsTableUpdateCompanionBuilder,
    (StoreMap, BaseReferences<_$AppDatabase, $StoreMapsTable, StoreMap>),
    StoreMap,
    PrefetchHooks Function()>;
typedef $$PathNodesTableCreateCompanionBuilder = PathNodesCompanion Function({
  required String id,
  required double positionX,
  required double positionY,
  required bool isWalkable,
  required String connectedNodeIds,
  Value<int> rowid,
});
typedef $$PathNodesTableUpdateCompanionBuilder = PathNodesCompanion Function({
  Value<String> id,
  Value<double> positionX,
  Value<double> positionY,
  Value<bool> isWalkable,
  Value<String> connectedNodeIds,
  Value<int> rowid,
});

class $$PathNodesTableFilterComposer
    extends Composer<_$AppDatabase, $PathNodesTable> {
  $$PathNodesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isWalkable => $composableBuilder(
      column: $table.isWalkable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get connectedNodeIds => $composableBuilder(
      column: $table.connectedNodeIds,
      builder: (column) => ColumnFilters(column));
}

class $$PathNodesTableOrderingComposer
    extends Composer<_$AppDatabase, $PathNodesTable> {
  $$PathNodesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionX => $composableBuilder(
      column: $table.positionX, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get positionY => $composableBuilder(
      column: $table.positionY, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isWalkable => $composableBuilder(
      column: $table.isWalkable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get connectedNodeIds => $composableBuilder(
      column: $table.connectedNodeIds,
      builder: (column) => ColumnOrderings(column));
}

class $$PathNodesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PathNodesTable> {
  $$PathNodesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get positionX =>
      $composableBuilder(column: $table.positionX, builder: (column) => column);

  GeneratedColumn<double> get positionY =>
      $composableBuilder(column: $table.positionY, builder: (column) => column);

  GeneratedColumn<bool> get isWalkable => $composableBuilder(
      column: $table.isWalkable, builder: (column) => column);

  GeneratedColumn<String> get connectedNodeIds => $composableBuilder(
      column: $table.connectedNodeIds, builder: (column) => column);
}

class $$PathNodesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PathNodesTable,
    PathNode,
    $$PathNodesTableFilterComposer,
    $$PathNodesTableOrderingComposer,
    $$PathNodesTableAnnotationComposer,
    $$PathNodesTableCreateCompanionBuilder,
    $$PathNodesTableUpdateCompanionBuilder,
    (PathNode, BaseReferences<_$AppDatabase, $PathNodesTable, PathNode>),
    PathNode,
    PrefetchHooks Function()> {
  $$PathNodesTableTableManager(_$AppDatabase db, $PathNodesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PathNodesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PathNodesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PathNodesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<double> positionX = const Value.absent(),
            Value<double> positionY = const Value.absent(),
            Value<bool> isWalkable = const Value.absent(),
            Value<String> connectedNodeIds = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PathNodesCompanion(
            id: id,
            positionX: positionX,
            positionY: positionY,
            isWalkable: isWalkable,
            connectedNodeIds: connectedNodeIds,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required double positionX,
            required double positionY,
            required bool isWalkable,
            required String connectedNodeIds,
            Value<int> rowid = const Value.absent(),
          }) =>
              PathNodesCompanion.insert(
            id: id,
            positionX: positionX,
            positionY: positionY,
            isWalkable: isWalkable,
            connectedNodeIds: connectedNodeIds,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PathNodesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PathNodesTable,
    PathNode,
    $$PathNodesTableFilterComposer,
    $$PathNodesTableOrderingComposer,
    $$PathNodesTableAnnotationComposer,
    $$PathNodesTableCreateCompanionBuilder,
    $$PathNodesTableUpdateCompanionBuilder,
    (PathNode, BaseReferences<_$AppDatabase, $PathNodesTable, PathNode>),
    PathNode,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
  $$StoreMapsTableTableManager get storeMaps =>
      $$StoreMapsTableTableManager(_db, _db.storeMaps);
  $$PathNodesTableTableManager get pathNodes =>
      $$PathNodesTableTableManager(_db, _db.pathNodes);
}

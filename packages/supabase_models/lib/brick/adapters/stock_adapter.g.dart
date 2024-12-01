// GENERATED CODE DO NOT EDIT
part of '../brick.g.dart';

Future<Stock> _$StockFromSupabase(Map<String, dynamic> data,
    {required SupabaseProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return Stock(
      id: data['id'] as int,
      tin: data['tin'] as int?,
      bhfId: data['bhf_id'] as String?,
      branchId: data['branch_id'] as int?,
      variantId: data['variant_id'] as int?,
      currentStock: data['current_stock'] as int? ?? 0,
      lowStock: data['low_stock'] as int? ?? 0,
      canTrackingStock: data['can_tracking_stock'] as bool? ?? true,
      showLowStockAlert: data['show_low_stock_alert'] as bool? ?? true,
      productId: data['product_id'] as int?,
      active: data['active'] as bool?,
      value: data['value'] as int?,
      rsdQty: data['rsd_qty'] as int?,
      lastTouched: data['last_touched'] == null
          ? null
          : DateTime.tryParse(data['last_touched'] as String),
      deletedAt: data['deleted_at'] == null
          ? null
          : DateTime.tryParse(data['deleted_at'] as String),
      ebmSynced: data['ebm_synced'] as bool? ?? false,
      initialStock: data['initial_stock'] as int? ?? 1,
      variant: await VariantAdapter().fromSupabase(data['variant'],
          provider: provider, repository: repository));
}

Future<Map<String, dynamic>> _$StockToSupabase(Stock instance,
    {required SupabaseProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return {
    'id': instance.id,
    'tin': instance.tin,
    'bhf_id': instance.bhfId,
    'branch_id': instance.branchId,
    'variant_id': instance.variantId,
    'current_stock': instance.currentStock,
    'low_stock': instance.lowStock,
    'can_tracking_stock': instance.canTrackingStock,
    'show_low_stock_alert': instance.showLowStockAlert,
    'product_id': instance.productId,
    'active': instance.active,
    'value': instance.value,
    'rsd_qty': instance.rsdQty,
    'last_touched': instance.lastTouched?.toIso8601String(),
    'deleted_at': instance.deletedAt?.toIso8601String(),
    'ebm_synced': instance.ebmSynced,
    'initial_stock': instance.initialStock,
    'variant': await VariantAdapter().toSupabase(instance.variant,
        provider: provider, repository: repository)
  };
}

Future<Stock> _$StockFromSqlite(Map<String, dynamic> data,
    {required SqliteProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return Stock(
      id: data['id'] as int,
      tin: data['tin'] == null ? null : data['tin'] as int?,
      bhfId: data['bhf_id'] == null ? null : data['bhf_id'] as String?,
      branchId: data['branch_id'] == null ? null : data['branch_id'] as int?,
      variantId: data['variant_id'] == null ? null : data['variant_id'] as int?,
      currentStock:
          data['current_stock'] == null ? null : data['current_stock'] as int?,
      lowStock: data['low_stock'] == null ? null : data['low_stock'] as int?,
      canTrackingStock: data['can_tracking_stock'] == null
          ? null
          : data['can_tracking_stock'] == 1,
      showLowStockAlert: data['show_low_stock_alert'] == null
          ? null
          : data['show_low_stock_alert'] == 1,
      productId: data['product_id'] == null ? null : data['product_id'] as int?,
      active: data['active'] == null ? null : data['active'] == 1,
      value: data['value'] == null ? null : data['value'] as int?,
      rsdQty: data['rsd_qty'] == null ? null : data['rsd_qty'] as int?,
      lastTouched: data['last_touched'] == null
          ? null
          : data['last_touched'] == null
              ? null
              : DateTime.tryParse(data['last_touched'] as String),
      deletedAt: data['deleted_at'] == null
          ? null
          : data['deleted_at'] == null
              ? null
              : DateTime.tryParse(data['deleted_at'] as String),
      ebmSynced: data['ebm_synced'] == null ? null : data['ebm_synced'] == 1,
      initialStock:
          data['initial_stock'] == null ? null : data['initial_stock'] as int?,
      variant: (await repository!.getAssociation<Variant>(
        Query.where('primaryKey', data['variant_Variant_brick_id'] as int,
            limit1: true),
      ))!
          .first)
    ..primaryKey = data['_brick_id'] as int;
}

Future<Map<String, dynamic>> _$StockToSqlite(Stock instance,
    {required SqliteProvider provider,
    OfflineFirstWithSupabaseRepository? repository}) async {
  return {
    'id': instance.id,
    'tin': instance.tin,
    'bhf_id': instance.bhfId,
    'branch_id': instance.branchId,
    'variant_id': instance.variantId,
    'current_stock': instance.currentStock,
    'low_stock': instance.lowStock,
    'can_tracking_stock': instance.canTrackingStock == null
        ? null
        : (instance.canTrackingStock! ? 1 : 0),
    'show_low_stock_alert': instance.showLowStockAlert == null
        ? null
        : (instance.showLowStockAlert! ? 1 : 0),
    'product_id': instance.productId,
    'active': instance.active == null ? null : (instance.active! ? 1 : 0),
    'value': instance.value,
    'rsd_qty': instance.rsdQty,
    'last_touched': instance.lastTouched?.toIso8601String(),
    'deleted_at': instance.deletedAt?.toIso8601String(),
    'ebm_synced':
        instance.ebmSynced == null ? null : (instance.ebmSynced! ? 1 : 0),
    'initial_stock': instance.initialStock,
    'variant_Variant_brick_id': instance.variant.primaryKey ??
        await provider.upsert<Variant>(instance.variant, repository: repository)
  };
}

/// Construct a [Stock]
class StockAdapter extends OfflineFirstWithSupabaseAdapter<Stock> {
  StockAdapter();

  @override
  final supabaseTableName = 'stocks';
  @override
  final defaultToNull = true;
  @override
  final fieldsToSupabaseColumns = {
    'id': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'id',
    ),
    'tin': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'tin',
    ),
    'bhfId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'bhf_id',
    ),
    'branchId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'branch_id',
    ),
    'variantId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'variant_id',
    ),
    'currentStock': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'current_stock',
    ),
    'lowStock': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'low_stock',
    ),
    'canTrackingStock': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'can_tracking_stock',
    ),
    'showLowStockAlert': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'show_low_stock_alert',
    ),
    'productId': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'product_id',
    ),
    'active': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'active',
    ),
    'value': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'value',
    ),
    'rsdQty': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'rsd_qty',
    ),
    'lastTouched': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'last_touched',
    ),
    'deletedAt': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'deleted_at',
    ),
    'ebmSynced': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'ebm_synced',
    ),
    'initialStock': const RuntimeSupabaseColumnDefinition(
      association: false,
      columnName: 'initial_stock',
    ),
    'variant': const RuntimeSupabaseColumnDefinition(
      association: true,
      columnName: 'variant',
      associationType: Variant,
      associationIsNullable: false,
    )
  };
  @override
  final ignoreDuplicates = false;
  @override
  final uniqueFields = {'id'};
  @override
  final Map<String, RuntimeSqliteColumnDefinition> fieldsToSqliteColumns = {
    'primaryKey': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: '_brick_id',
      iterable: false,
      type: int,
    ),
    'id': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'id',
      iterable: false,
      type: int,
    ),
    'tin': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'tin',
      iterable: false,
      type: int,
    ),
    'bhfId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'bhf_id',
      iterable: false,
      type: String,
    ),
    'branchId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'branch_id',
      iterable: false,
      type: int,
    ),
    'variantId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'variant_id',
      iterable: false,
      type: int,
    ),
    'currentStock': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'current_stock',
      iterable: false,
      type: int,
    ),
    'lowStock': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'low_stock',
      iterable: false,
      type: int,
    ),
    'canTrackingStock': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'can_tracking_stock',
      iterable: false,
      type: bool,
    ),
    'showLowStockAlert': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'show_low_stock_alert',
      iterable: false,
      type: bool,
    ),
    'productId': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'product_id',
      iterable: false,
      type: int,
    ),
    'active': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'active',
      iterable: false,
      type: bool,
    ),
    'value': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'value',
      iterable: false,
      type: int,
    ),
    'rsdQty': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'rsd_qty',
      iterable: false,
      type: int,
    ),
    'lastTouched': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'last_touched',
      iterable: false,
      type: DateTime,
    ),
    'deletedAt': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'deleted_at',
      iterable: false,
      type: DateTime,
    ),
    'ebmSynced': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'ebm_synced',
      iterable: false,
      type: bool,
    ),
    'initialStock': const RuntimeSqliteColumnDefinition(
      association: false,
      columnName: 'initial_stock',
      iterable: false,
      type: int,
    ),
    'variant': const RuntimeSqliteColumnDefinition(
      association: true,
      columnName: 'variant_Variant_brick_id',
      iterable: false,
      type: Variant,
    )
  };
  @override
  Future<int?> primaryKeyByUniqueColumns(
      Stock instance, DatabaseExecutor executor) async {
    final results = await executor.rawQuery('''
        SELECT * FROM `Stock` WHERE id = ? LIMIT 1''', [instance.id]);

    // SQFlite returns [{}] when no results are found
    if (results.isEmpty || (results.length == 1 && results.first.isEmpty)) {
      return null;
    }

    return results.first['_brick_id'] as int;
  }

  @override
  final String tableName = 'Stock';

  @override
  Future<Stock> fromSupabase(Map<String, dynamic> input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$StockFromSupabase(input,
          provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSupabase(Stock input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$StockToSupabase(input,
          provider: provider, repository: repository);
  @override
  Future<Stock> fromSqlite(Map<String, dynamic> input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$StockFromSqlite(input,
          provider: provider, repository: repository);
  @override
  Future<Map<String, dynamic>> toSqlite(Stock input,
          {required provider,
          covariant OfflineFirstWithSupabaseRepository? repository}) async =>
      await _$StockToSqlite(input, provider: provider, repository: repository);
}

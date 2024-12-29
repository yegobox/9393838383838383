import 'package:brick_offline_first_with_supabase/brick_offline_first_with_supabase.dart';
import 'package:brick_sqlite/brick_sqlite.dart';
import 'package:brick_supabase/brick_supabase.dart';
import 'package:uuid/uuid.dart';

@ConnectOfflineFirstWithSupabase(
  supabaseConfig: SupabaseSerializable(tableName: 'codes'),
)
class ItemCode extends OfflineFirstWithSupabaseModel {
  @Sqlite(unique: true)
  final String id;

  @Sqlite(index: true)
  final String code;

  final DateTime createdAt;

  ItemCode({
    String? id,
    required this.code,
    required this.createdAt,
  }) : id = id ?? const Uuid().v4();
}

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_felica/src/felica_platform_android.dart';
import 'package:nfc_manager_felica/src/felica_platform_ios.dart';

/// Provides access to FeliCa operations.
///
/// Acquire an instance using [from(NfcTag)].
abstract class FeliCa {
  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static FeliCa? from(NfcTag tag) {
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => FeliCaPlatformAndroid.from(tag),
      TargetPlatform.iOS => FeliCaPlatformIos.from(tag),
      _ => null,
    };
  }

  // DOC:
  Uint8List get systemCode;

  // DOC:
  Uint8List get idm;

  // DOC:
  Future<FeliCaPollingResponse> polling({
    required Uint8List systemCode,
    required FeliCaPollingRequestCode requestCode,
    required FeliCaPollingTimeSlot timeSlot,
  });

  // DOC:
  Future<List<Uint8List>> requestService({
    required List<Uint8List> nodeCodeList,
  });

  // DOC:
  Future<int> requestResponse();

  // DOC:
  Future<FeliCaReadWithoutEncryptionResponse> readWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
  });

  // DOC:
  Future<FeliCaStatusFlag> writeWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
    required List<Uint8List> blockData,
  });

  // DOC:
  Future<List<Uint8List>> requestSystemCode();

  // DOC:
  Future<FeliCaRequestServiceV2Response> requestServiceV2({
    required List<Uint8List> nodeCodeList,
  });

  // DOC:
  Future<FeliCaRequestSpecificationVersionResponse>
  requestSpecificationVersion();

  // DOC:
  Future<FeliCaStatusFlag> resetMode();

  // DOC:
  Future<Uint8List> sendFeliCaCommand({required Uint8List commandPacket});
}

// DOC:
final class FeliCaPollingResponse {
  // DOC:
  @visibleForTesting
  const FeliCaPollingResponse({required this.pmm, required this.requestData});

  // DOC:
  final Uint8List pmm;

  // DOC:
  final Uint8List? requestData;
}

// DOC:
final class FeliCaReadWithoutEncryptionResponse {
  // DOC:
  @visibleForTesting
  const FeliCaReadWithoutEncryptionResponse({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.blockData,
  });

  // DOC:
  final int statusFlag1;

  // DOC:
  final int statusFlag2;

  // DOC:
  final List<Uint8List> blockData;
}

// DOC:
final class FeliCaRequestServiceV2Response {
  // DOC:
  @visibleForTesting
  const FeliCaRequestServiceV2Response({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.encryptionIdentifier,
    required this.nodeKeyVersionListAes,
    required this.nodeKeyVersionListDes,
  });

  // DOC:
  final int statusFlag1;

  // DOC:
  final int statusFlag2;

  // DOC:
  final int encryptionIdentifier;

  // DOC:
  final List<Uint8List>? nodeKeyVersionListAes;

  // DOC:
  final List<Uint8List>? nodeKeyVersionListDes;
}

// DOC:
final class FeliCaRequestSpecificationVersionResponse {
  // DOC:
  @visibleForTesting
  const FeliCaRequestSpecificationVersionResponse({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.basicVersion,
    required this.optionVersion,
  });

  // DOC:
  final int statusFlag1;

  // DOC:
  final int statusFlag2;

  // DOC:
  final Uint8List? basicVersion;

  // DOC:
  final Uint8List? optionVersion;
}

// DOC:
final class FeliCaStatusFlag {
  // DOC:
  @visibleForTesting
  const FeliCaStatusFlag({
    required this.statusFlag1,
    required this.statusFlag2,
  });

  // DOC:
  final int statusFlag1;

  // DOC:
  final int statusFlag2;
}

/// Indicates the type of the data to request when polling.
enum FeliCaPollingRequestCode {
  /// Indicates no request.
  noRequest._(0x00),

  /// Indicates a system code request.
  systemCode._(0x01),

  /// Indicates a communication performance request.
  communicationPerformance._(0x02);

  /// The code used in the actual command.
  final int code;

  const FeliCaPollingRequestCode._(this.code);
}

/// Indicates the maximum number of time slots.
enum FeliCaPollingTimeSlot {
  /// Indicates a maximum of one slot.
  max1._(0x00),

  /// Indicates a maximum of two slots.
  max2._(0x01),

  /// Indicates a maximum of four slots.
  max4._(0x03),

  /// Indicates a maximum of right slots.
  max8._(0x07),

  /// Indicates a maximum of sixteen slots.
  max16._(0x0F);

  /// The code used in the actual command.
  final int code;

  const FeliCaPollingTimeSlot._(this.code);
}

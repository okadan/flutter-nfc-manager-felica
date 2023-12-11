import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager_felica/src/felica_platform_android.dart';
import 'package:nfc_manager_felica/src/felica_platform_ios.dart';

/// The class providing access to FeliCa operations.
///
/// Acquire an instance using [from(NfcTag)].
abstract class FeliCa {
  /// Creates an instance of this class for the given tag.
  ///
  /// Returns null if the tag is not compatible.
  static FeliCa? from(NfcTag tag) {
    return switch (defaultTargetPlatform) {
      // ignore: invalid_use_of_visible_for_testing_member
      TargetPlatform.android => FeliCaPlatformAndroid.from(tag),
      // ignore: invalid_use_of_visible_for_testing_member
      TargetPlatform.iOS => FeliCaPlatformIOS.from(tag),
      _ => null,
    };
  }

  /// DOC:
  Future<FeliCaPollingResponse> polling({
    required Uint8List systemCode,
    required FeliCaPollingRequestCode requestCode,
    required FeliCaPollingTimeSlot timeSlot,
  });

  /// DOC:
  Future<List<Uint8List>> requestService({
    required List<Uint8List> nodeCodeList,
  });

  /// DOC:
  Future<int> requestResponse();

  /// DOC:
  Future<FeliCaReadWithoutEncryptionResponse> readWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
  });

  /// DOC:
  Future<FeliCaStatusFlag> writeWithoutEncryption({
    required List<Uint8List> serviceCodeList,
    required List<Uint8List> blockList,
    required List<Uint8List> blockData,
  });

  /// DOC:
  Future<List<Uint8List>> requestSystemCode();

  /// DOC:
  Future<FeliCaRequestServiceV2Response> requestServiceV2({
    required List<Uint8List> nodeCodeList,
  });

  /// DOC:
  Future<FeliCaRequestSpecificationVersionResponse>
      requestSpecificationVersion();

  /// DOC:
  Future<FeliCaStatusFlag> resetMode();

  /// DOC:
  Future<Uint8List> sendFeliCaCommand({
    required Uint8List commandPacket,
  });
}

/// DOC:
final class FeliCaPollingResponse {
  /// DOC:
  @visibleForTesting
  const FeliCaPollingResponse({
    required this.pmm,
    required this.requestData,
  });

  /// DOC:
  final Uint8List pmm;

  /// DOC:
  final Uint8List requestData;
}

/// DOC:
final class FeliCaReadWithoutEncryptionResponse {
  /// DOC:
  @visibleForTesting
  const FeliCaReadWithoutEncryptionResponse({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.blockData,
  });

  /// DOC:
  final int statusFlag1;

  /// DOC:
  final int statusFlag2;

  /// DOC:
  final List<Uint8List> blockData;
}

/// DOC:
final class FeliCaRequestServiceV2Response {
  /// DOC:
  @visibleForTesting
  const FeliCaRequestServiceV2Response({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.encryptionIdentifier,
    required this.nodeKeyVersionListAes,
    required this.nodeKeyVersionListDes,
  });

  /// DOC:
  final int statusFlag1;

  /// DOC:
  final int statusFlag2;

  /// DOC:
  final int encryptionIdentifier;

  /// DOC:
  final List<Uint8List> nodeKeyVersionListAes;

  /// DOC:
  final List<Uint8List> nodeKeyVersionListDes;
}

/// DOC:
final class FeliCaRequestSpecificationVersionResponse {
  /// DOC:
  @visibleForTesting
  const FeliCaRequestSpecificationVersionResponse({
    required this.statusFlag1,
    required this.statusFlag2,
    required this.basicVersion,
    required this.optionVersion,
  });

  /// DOC:
  final int statusFlag1;

  /// DOC:
  final int statusFlag2;

  /// DOC:
  final Uint8List basicVersion;

  /// DOC:
  final Uint8List optionVersion;
}

/// DOC:
final class FeliCaStatusFlag {
  /// DOC:
  @visibleForTesting
  const FeliCaStatusFlag({
    required this.statusFlag1,
    required this.statusFlag2,
  });

  /// DOC:
  final int statusFlag1;

  /// DOC:
  final int statusFlag2;
}

/// DOC
enum FeliCaPollingRequestCode {
  /// DOC:
  noRequest(0x00),

  /// DOC:
  systemCode(0x01),

  /// DOC:
  communicationPerformance(0x02);

  /// DOC:
  const FeliCaPollingRequestCode(this.code);

  /// DOC:
  final int code;
}

/// DOC:
enum FeliCaPollingTimeSlot {
  /// DOC:
  max1(0x00),

  /// DOC:
  max2(0x01),

  /// DOC:
  max4(0x03),

  /// DOC:
  max8(0x07),

  /// DOC:
  max16(0x0F);

  /// DOC:
  const FeliCaPollingTimeSlot(this.code);

  /// DOC:
  final int code;
}

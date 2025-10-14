/**
 * ============================================================
 *  FILE: file_operations_demo.dart
 *  PURPOSE: Demonstrate robust and scalable file I/O in Dart
 *  AUTHOR: Srikanta (Software Developer)
 *  DESCRIPTION:
 *    This file showcases end-to-end file handling in Dart:
 *      • File creation with recursive and exclusive options
 *      • Reading files (full text, line by line, streaming)
 *      • Writing files (overwrite, append, list, JSON)
 *      • File modes (write, append, read, writeOnly, writeOnlyAppend)
 *      • Best practices for scalable and memory-efficient file handling
 * ============================================================
 */

import 'dart:io';
import 'dart:convert';

Future<void> main() async {
  final filePath = 'nested/folder/sample.txt';
  final file = File(filePath);

  // ============================================================
  // 1. FILE CREATION
  // ============================================================
  print('--- FILE CREATION ---');

  /**
   * recursive = true
   *   → Creates missing parent directories automatically.
   * exclusive = true
   *   → Throws error if file already exists (prevents overwrite).
   */
  try {
    await file.create(recursive: true, exclusive: false);
    print('File created successfully: $filePath');
  } catch (e) {
    print('File creation error: $e');
  }

  // ============================================================
  // 2. WRITING TO FILE
  // ============================================================
  print('\n--- FILE WRITING ---');

  // 2.1 Overwrite the file (default behavior)
  await file.writeAsString('Hello World (Overwritten)\n');
  print('✅ File overwritten');

  // 2.2 Append text at the end
  await file.writeAsString('Appended line\n', mode: FileMode.append);
  print('✅ Text appended');

  // 2.3 Write a list to file (joins with new lines)
  List<String> lines = ['Line 1', 'Line 2', 'Line 3'];
  await file.writeAsString(lines.join('\n'), mode: FileMode.append);
  print('✅ List written');

  // 2.4 Write JSON to file
  final jsonFile = File('nested/folder/data.json');
  final jsonData = {
    'name': 'Srikanta',
    'role': 'Software Developer',
    'skills': ['Dart', 'Flutter', 'Node.js']
  };
  await jsonFile.writeAsString(jsonEncode(jsonData));
  print('✅ JSON written');

  // ============================================================
  // 3. READING FILE CONTENT
  // ============================================================
  print('\n--- FILE READING ---');

  // 3.1 Read entire file as String
  final fullText = await file.readAsString();
  print('📄 Full Content:\n$fullText');

  // 3.2 Read file as list of lines
  final allLines = await file.readAsLines();
  print('📄 ReadAsLines() Output:');
  for (var line in allLines) {
    print('  → $line');
  }

  // 3.3 Stream read (memory efficient for large files)
  print('📄 Stream Reading (Line by Line):');
  final stream = file
      .openRead()                                // Stream<List<int>>
      .transform(SystemEncoding().decoder)       // Convert bytes to text
      .transform(const LineSplitter());          // Split into lines

  await for (var line in stream) {
    print('  → $line');
  }

  // ============================================================
  // 4. READING JSON FILE
  // ============================================================
  print('\n--- JSON READING ---');

  final jsonContent = await jsonFile.readAsString();
  final parsed = jsonDecode(jsonContent);
  print('👤 Name: ${parsed['name']}');
  print('💼 Role: ${parsed['role']}');
  print('🧠 Skills: ${parsed['skills']}');

  // ============================================================
  // 5. FILE MODES DEMO
  // ============================================================
  print('\n--- FILE MODE DEMONSTRATION ---');

  /**
   * FileMode.write
   * - Overwrites existing content
   * - Creates file if not exists
   */
  await file.writeAsString('FileMode.write: Fresh content\n',
      mode: FileMode.write);

  /**
   * FileMode.append
   * - Appends at the end
   * - Does not clear previous data
   */
  await file.writeAsString('FileMode.append: Appended content\n',
      mode: FileMode.append);

  /**
   * FileMode.writeOnly
   * - Overwrites file
   * - No reading allowed from this handle
   * - Performance-optimized for write-only streams
   */
  final sink1 = file.openWrite(mode: FileMode.writeOnly);
  sink1.write('FileMode.writeOnly: Write-only operation\n');
  await sink1.close();

  /**
   * FileMode.writeOnlyAppend
   * - Appends only, no read access
   * - Ideal for logs and fast append operations
   */
  final sink2 = file.openWrite(mode: FileMode.writeOnlyAppend);
  sink2.write('FileMode.writeOnlyAppend: Append-only operation\n');
  await sink2.close();

  /**
   * FileMode.read
   * - Read-only mode
   * - Throws error if file does not exist
   * - No write access
   */
  try {
    final raf = await file.open(mode: FileMode.read);
    final content = await raf.read(50); // Read first 50 bytes
    print('FileMode.read: ${String.fromCharCodes(content)}');
    await raf.close();
  } catch (e) {
    print('Error reading with FileMode.read: $e');
  }

  // ============================================================
  // 6. ERROR HANDLING BEST PRACTICE
  // ============================================================
  print('\n--- ERROR HANDLING ---');

  try {
    final missingFile = File('missing_folder/missing.txt');
    final text = await missingFile.readAsString();
    print(text);
  } catch (e) {
    print('❌ Gracefully handled file read error: $e');
  }

  // ============================================================
  // 7. PRO TIP
  // ============================================================
  /**
   * ✔ Use recursive:true for nested structures
   * ✔ Use exclusive:true to avoid overwriting critical files
   * ✔ Use streaming for large files to avoid memory issues
   * ✔ Always close sinks to release resources
   * ✔ Use proper FileMode based on use case
   */
  print('\n✅ All file operations executed successfully.');
}

import 'package:flutter_hooks/flutter_hooks.dart';

/// Executes a function once and optionally returns a cleanup function
///
/// [call] - The function to execute
/// [keys] - Dependencies that trigger re-execution when changed
/// [cleanup] - Optional cleanup function to run when the effect is disposed
void useOnce(void Function() call, {List<Object> keys = const [], void Function()? cleanup}) => useEffect(
  () {
    call();
    return cleanup;
  },
  keys,
);

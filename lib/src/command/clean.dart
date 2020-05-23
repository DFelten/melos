import 'package:args/command_runner.dart' show Command;

import '../command_runner.dart';
import '../common/logger.dart';
import '../common/workspace.dart';

class CleanCommand extends Command {
  @override
  final String name = 'clean';

  @override
  final List<String> aliases = ['c'];

  @override
  final String description =
      'Clean this workspace and all packages. This deletes the temporary pub files such as ".packages" & ".flutter-plugins". Supports all package filtering options.';

  @override
  void run() async {
    logger.stdout('Cleaning workspace...');
    currentWorkspace.clean();
    if (currentWorkspace.config.scripts.containsKey('postclean')) {
      logger.stdout('Running postclean script...\n');
      await MelosCommandRunner.instance.run(['run', 'postclean']);
    }
    logger.stdout(
        'Workspace cleaned, you will need to run the bootstrap command again.');
  }
}
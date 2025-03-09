import 'package:provider/provider.dart';
import '../viewmodels/upgrade_viewmodel.dart';
import '../models/upgrade_level_model.dart';

class UpgradeView extends StatelessWidget {
  final int playerId;

  const UpgradeView({Key? key, required this.playerId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UpgradeViewModel()..fetchUpgrades(playerId),
      child: Scaffold(
        appBar: AppBar(title: const Text('Améliorations')),
        body: Consumer<UpgradeViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: viewModel.upgrades.length,
              itemBuilder: (context, index) {
                final upgrade = viewModel.upgrades[index];
                final isUnlocked = upgrade.level > 0;

                return GestureDetector(
                  onTap: isUnlocked
                      ? null
                      : () => viewModel.buyUpgrade(playerId, upgrade.id),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isUnlocked ? Colors.blueAccent : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: isUnlocked ? 1.0 : 0.1,
                          child: Text(
                            upgrade.upgrade.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //
                        if (!isUnlocked)
                          const Icon(Icons.lock, color: Colors.white, size: 30),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
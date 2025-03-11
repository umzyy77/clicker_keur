import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/upgrade_viewmodel.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  _ShopViewState createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UpgradeViewModel>(context, listen: false).loadUpgrades(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final upgradeViewModel = Provider.of<UpgradeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("🏪 Boutique d'Améliorations"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: upgradeViewModel.isLoading
            ? const CircularProgressIndicator()
            : upgradeViewModel.upgrades.isEmpty
            ? Text(
          upgradeViewModel.errorMessage ?? "Aucune amélioration disponible.",
          style: const TextStyle(fontSize: 18, color: Colors.grey),
        )
            : ListView.builder(
          itemCount: upgradeViewModel.upgrades.length,
          itemBuilder: (context, index) {
            final upgrade = upgradeViewModel.upgrades[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${upgrade.upgradeLevel.name} - Niveau ${upgrade.upgradeLevel.level}",
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text("💰 Coût : ${upgrade.upgradeLevel.cost}",
                        style: const TextStyle(fontSize: 16, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text("⚡ Bonus : ${upgrade.upgradeLevel.boostValue}",
                        style: const TextStyle(fontSize: 16, color: Colors.green)),
                    const SizedBox(height: 16),

                    if (!upgrade.purchased)
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await upgradeViewModel.buyUpgrade(context, upgrade.upgradeLevel.idUpgrade);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text("🛒 Acheter", style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

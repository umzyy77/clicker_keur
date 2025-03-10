import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/upgrade_viewmodel.dart';

class ShopView extends StatefulWidget {
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
        title: Text("🏪 Boutique d'Améliorations"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: upgradeViewModel.isLoading
            ? CircularProgressIndicator()
            : upgradeViewModel.upgrades.isEmpty
            ? Text(
          upgradeViewModel.errorMessage ?? "Aucune amélioration disponible.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        )
            : ListView.builder(
          itemCount: upgradeViewModel.upgrades.length,
          itemBuilder: (context, index) {
            final upgrade = upgradeViewModel.upgrades[index];

            return Card(
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${upgrade.upgradeLevel.name} - Niveau ${upgrade.upgradeLevel.level}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text("💰 Coût : ${upgrade.upgradeLevel.cost}",
                        style: TextStyle(fontSize: 16, color: Colors.grey)),
                    SizedBox(height: 8),
                    Text("⚡ Bonus : ${upgrade.upgradeLevel.boostValue}",
                        style: TextStyle(fontSize: 16, color: Colors.green)),
                    SizedBox(height: 16),

                    if (!upgrade.purchased)
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await upgradeViewModel.buyUpgrade(context, upgrade.upgradeLevel.idUpgrade);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: Text("🛒 Acheter", style: TextStyle(fontSize: 16, color: Colors.white)),
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

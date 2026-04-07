import 'package:app_tp2/screens/app_scaffolding.dart';
import 'package:app_tp2/services/pointage_service.dart';
import '../app/app_routes.dart';
import 'package:flutter/material.dart';

class PointageScreen extends StatefulWidget {
  const PointageScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PointageScreenState();
}

class _PointageScreenState extends State<PointageScreen> {
  Future<bool> hasAlreadyPointedToday() async {
    return await PointageService.pointageExistsForToday();
  }

  Widget _buildHeader(BuildContext context, bool alreadyPointed) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: alreadyPointed
            ? theme.colorScheme.secondaryContainer
            : theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: (alreadyPointed
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              alreadyPointed
                  ? Icons.verified_rounded
                  : Icons.access_time_filled_rounded,
              size: 30,
              color: alreadyPointed
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alreadyPointed ? 'Pointage effectué' : 'Pointage du jour',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: alreadyPointed
                        ? theme.colorScheme.onSecondaryContainer
                        : theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  alreadyPointed
                      ? 'Votre présence a déjà été enregistrée aujourd’hui.'
                      : 'Enregistrez votre arrivée en une seule action.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: alreadyPointed
                        ? theme.colorScheme.onSecondaryContainer.withValues(alpha: 0.85)
                        : theme.colorScheme.onPrimaryContainer.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlreadyPointedBody(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.check_circle_rounded,
            size: 54,
            color: theme.colorScheme.secondary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Vous avez déjà pointé aujourd’hui',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Vous pouvez consulter votre historique pour vérifier vos enregistrements précédents.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.pointageHistoryPage.path,
              );
            },
            icon: const Icon(Icons.history),
            label: const Text('Voir l’historique de pointage'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPointageButtonBody(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.fingerprint_rounded,
            size: 58,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Prêt à pointer ?',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'Appuyez sur le bouton ci-dessous pour enregistrer votre arrivée du jour.',
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () async {
              await PointageService.createPointageForToday();
              setState(() {});
            },
            icon: const Icon(Icons.login_rounded),
            label: const Text('Pointer aujourd’hui'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffolding(
      title: "Pointage",
      body: FutureBuilder<bool>(
        future: hasAlreadyPointedToday(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Erreur : ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final alreadyPointed = snapshot.data ?? false;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader(context, alreadyPointed),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surfaceContainerHighest
                          .withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: alreadyPointed
                        ? _buildAlreadyPointedBody(context)
                        : _buildPointageButtonBody(context),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
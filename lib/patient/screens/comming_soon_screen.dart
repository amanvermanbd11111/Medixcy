import 'package:videocalling_medical/common/utils/app_imports.dart';

class ComingSoonScreen extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const ComingSoonScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top image taking half the screen height
            SizedBox(
              height: size.height * 0.45,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ),

            const Spacer(),

            // "Coming Soon" tag or animation area
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.color2.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "🚧 Coming Soon",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.buttonColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

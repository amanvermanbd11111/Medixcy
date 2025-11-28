import 'package:videocalling_medical/common/utils/app_imports.dart';

class LoginOptionsScreen extends StatelessWidget {
  LoginOptionsScreen({super.key});

  final LoginOptionsController controller = Get.put(LoginOptionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Logo
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(30),
                child: Image.asset(
                 AppImages.medixyIcon,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(Icons.image_not_supported,
                            color: Colors.grey, size: 40),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),

              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.loginOptions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final option = controller.loginOptions[index];
                    return LoginOptionCard(data: option);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginOptionCard extends StatelessWidget {
  final LoginOptionData data;

  const LoginOptionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => data.onTap(context),
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          data.imagePath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 80,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image_not_supported,
                    color: Colors.grey, size: 40),
              ),
            );
          },
        ),
      ),
    );
  }
}

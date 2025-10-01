import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_event.dart';
import '../../bloc/home_state.dart';
import '../views/error_view_home.dart';
import '../views/loading_view_home.dart';
import '../views/success_view_home.dart';

class HomePage extends StatelessWidget {
  final String? loginEmail;
  final String? loginPassword;

  const HomePage({super.key, this.loginEmail, this.loginPassword});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(HomeFetchData()),
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    // Imagen del automóvil con diseño moderno
                    Container(
                      width: double.infinity,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://www.shutterstock.com/image-photo/silver-car-standing-parking-lot-600nw-2462850863.jpg',
                              width: double.infinity,
                              height: 220,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: double.infinity,
                                  height: 220,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.grey[300]!,
                                        Colors.grey[500]!,
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.directions_car,
                                    size: 80,
                                    color: Colors.white,
                                  ),
                                );
                              },
                            ),
                            // Overlay gradient
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.4),
                                  ],
                                ),
                              ),
                            ),
                            // Texto sobre la imagen
                            const Positioned(
                              bottom: 16,
                              left: 16,
                              child: Text(
                                'Mi Vehículo Premium',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const LoadingViewHome();
                    } else if (state is HomeError) {
                      return ErrorViewHome(
                        onRetry: () =>
                            context.read<HomeBloc>().add(HomeFetchData()),
                      );
                    } else if (state is HomeLoaded) {
                      return SuccessViewHome(
                        phone: state.phone,
                        website: state.website,
                        loginEmail: loginEmail,
                        loginPassword: loginPassword,
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

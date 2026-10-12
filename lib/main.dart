import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const DetailsLabApp());

const lessons = [
  Lesson(1, 'Flutter с нуля', 'Создание интерфейсов, виджеты и компоновка.'),
  Lesson(2, 'Dart: основы', 'Типы, функции, классы и асинхронный код.'),
  Lesson(3, 'Material 3', 'Тема приложения, цветовая схема и доступность.'),
];

class Lesson {
  const Lesson(this.id, this.title, this.description);
  final int id;
  final String title;
  final String description;
}

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(path: '/home', builder: (_, _) => const HomeScreen()),
    GoRoute(
      path: '/content/:id',
      builder: (_, state) {
        final id = int.parse(state.pathParameters['id']!);
        return DetailsScreen(lesson: lessons.firstWhere((item) => item.id == id));
      },
    ),
  ],
);

class DetailsLabApp extends StatelessWidget {
  const DetailsLabApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ЛР №3',
        theme: ThemeData(colorSchemeSeed: const Color(0xFF14344E), useMaterial3: true),
        routerConfig: _router,
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Каталог занятий')),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: lessons.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (_, index) => ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('assets/images/study_workspace.png', width: 56, height: 56, fit: BoxFit.cover),
            ),
            title: Text(lessons[index].title),
            subtitle: Text(lessons[index].description, maxLines: 1, overflow: TextOverflow.ellipsis),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/content/${lessons[index].id}'),
          ),
        ),
      );
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({required this.lesson, super.key});
  final Lesson lesson;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Подробности')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/images/study_workspace.png', height: 220, width: double.infinity, fit: BoxFit.cover),
            ),
            const SizedBox(height: 24),
            Text(lesson.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 12),
            Text(lesson.description, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 20),
            const Text('На этом экране отображается расширенная информация об элементе, выбранном на первом экране.'),
          ]),
        ),
      );
}

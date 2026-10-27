#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QUrl>
#include <cstdio>

int main(int argc, char **argv)
{
    QGuiApplication app(argc, argv);
    const bool checkOnly = argc == 3 && QString::fromLocal8Bit(argv[2]) == QStringLiteral("--check");
    if (argc < 2 || argc > 3 || (argc == 3 && !checkOnly)) {
        std::fprintf(stderr, "Usage: kde_gui_qml_consumer <absolute-qml-file> [--check]\n");
        return 2;
    }

    QQmlApplicationEngine engine;
    engine.load(QUrl::fromLocalFile(QString::fromLocal8Bit(argv[1])));
    if (engine.rootObjects().isEmpty())
        return 1;

    if (checkOnly)
        return 0;

    return app.exec();
}

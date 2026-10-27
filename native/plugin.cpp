#include <QQmlEngineExtensionPlugin>

extern "C" bool cxx_qt_init_crate_kde_gui();

class KdeGuiPlugin final : public QQmlEngineExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlEngineExtensionInterface")

public:
    explicit KdeGuiPlugin(QObject *parent = nullptr)
        : QQmlEngineExtensionPlugin(parent)
    {
        cxx_qt_init_crate_kde_gui();
    }
};

#include "plugin.moc"

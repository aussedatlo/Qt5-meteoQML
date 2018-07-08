#ifndef METEOMANAGER_H
#define METEOMANAGER_H

#include <QtNetwork>
#include <QDebug>
#include <QObject>
#include <QVector>


class MeteoManager : public QObject{
    Q_OBJECT
public:
    MeteoManager();
    ~MeteoManager();
    enum class Fenetre {
        meteo1Day, meteo4Days
    };

    void update(Fenetre);

public slots:
    void enregistrer();
    void progressionTelechargement(qint64, qint64);
    void messageErreur(QNetworkReply::NetworkError);
    void updateData();
signals:
    void requestOver();
    void updateBigSection(const QString &temp_max, const QString &temp_min, const QString &icon);
    void updateSmallSection(const int &index, const QString &temp_max, const QString &temp_min, const QString &icon);

private:
    bool erreurTrouvee;
    const QString url_4days_sartrouville = "http://api.openweathermap.org/data/2.5/forecast/daily?id=2975921&APPID=48d746904b47cc2c1d5696d1f7dcaa9c&units=metric&cnt=4";
    const QString url_today_sartrouville = "http://api.openweathermap.org/data/2.5/weather?id=2975921&APPID=48d746904b47cc2c1d5696d1f7dcaa9c&units=metric";
    QNetworkReply *reply;
    QNetworkAccessManager *manager;
    Fenetre typeRequest;
    void map4Days(QVariantMap);

};

#endif // METEOMANAGER_H

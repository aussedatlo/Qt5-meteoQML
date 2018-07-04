#ifndef METEOMANAGER_H
#define METEOMANAGER_H

#include <QtNetwork>
#include <QDebug>
#include <QObject>
#include <QVector>
#include "meteobeans.h"


class MeteoManager : public QObject{
    Q_OBJECT
public:
    MeteoManager();
    ~MeteoManager();
    void update();

public slots:
    void enregistrer();
    void progressionTelechargement(qint64, qint64);
    void messageErreur(QNetworkReply::NetworkError);
    MeteoBeans* getMeteoBeans(int);
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
    QVector<MeteoBeans*> vector;
};

#endif // METEOMANAGER_H

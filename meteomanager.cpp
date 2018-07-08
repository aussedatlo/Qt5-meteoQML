#include "meteomanager.h"

MeteoManager::MeteoManager()
{
}

MeteoManager::~MeteoManager()
{
}


void MeteoManager::update(Fenetre type)
{
    typeRequest = type;
    QUrl url;
    if (type == Fenetre::meteo4Days) {
        url = QUrl(url_4days_sartrouville);
    } else {
        url = QUrl(url_today_sartrouville);
    }

    erreurTrouvee = false;
    QNetworkRequest requete(url);
    manager = new QNetworkAccessManager;
    reply = manager->get(requete);
    connect(reply, SIGNAL(error(QNetworkReply::NetworkError)), this, SLOT(messageErreur(QNetworkReply::NetworkError)));
    connect(reply, SIGNAL(finished()), this, SLOT(enregistrer()));
    connect(reply, SIGNAL(downloadProgress(qint64, qint64)), this, SLOT(progressionTelechargement(qint64, qint64) ));

}

void MeteoManager::enregistrer()
{
    if(!erreurTrouvee)
    {
        QNetworkReply *r = qobject_cast<QNetworkReply*>(sender()); //On récupère la réponse du serveur
        QJsonDocument itemDoc = QJsonDocument::fromJson(r->readAll());
        QJsonObject rootObject = itemDoc.object();
        QVariantMap map = rootObject.toVariantMap();

        if (typeRequest == Fenetre::meteo4Days) {
            map4Days(map);
        } else {
            qDebug() << "TODO";
        }
    }
}


void MeteoManager::progressionTelechargement(qint64 bytesReceived, qint64 bytesTotal)
{
    if (bytesTotal != -1)
    {
        qDebug() << "Download: " << bytesReceived << "/" << bytesTotal ;
    }
}


void MeteoManager::messageErreur(QNetworkReply::NetworkError)
{
    erreurTrouvee = true; //On indique qu'il y a eu une erreur au slot enregistrer
    QNetworkReply *r = qobject_cast<QNetworkReply*>(sender());
    qDebug() << r->errorString();
}

void MeteoManager::updateData()
{
    this->update(typeRequest);
}


void MeteoManager::map4Days(QVariantMap map) {

    double max = int(map["list"].toList().at(0).toMap()["temp"].toMap()["max"].toDouble());
    double min = int(map["list"].toList().at(0).toMap()["temp"].toMap()["min"].toDouble());
    QString icon = map["list"].toList().at(0).toMap()["weather"].toList().at(0).toMap()["icon"].toString();

    updateBigSection(QString::number(max),QString::number(min),icon);

    for (int i=1; i<4; i++)
    {
        double max = int(map["list"].toList().at(i).toMap()["temp"].toMap()["max"].toDouble());
        double min = int(map["list"].toList().at(i).toMap()["temp"].toMap()["min"].toDouble());
        QString icon = map["list"].toList().at(i).toMap()["weather"].toList().at(0).toMap()["icon"].toString();

        updateSmallSection(i, QString::number(max), QString::number(min), icon);
    }
}


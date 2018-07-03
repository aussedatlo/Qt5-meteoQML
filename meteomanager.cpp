#include "meteomanager.h"

MeteoManager::MeteoManager()
{
    vector.append(new MeteoBeans());
    vector.append(new MeteoBeans());
    vector.append(new MeteoBeans());
    vector.append(new MeteoBeans());
}

MeteoManager::~MeteoManager()
{
}


void MeteoManager::update()
{
    erreurTrouvee = false;
    QUrl url = QUrl(url_4days_sartrouville);
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

        for (int i=0; i<4; i++)
        {
            vector.at(i)->setMax(int(map["list"].toList().at(i).toMap()["temp"].toMap()["max"].toDouble()));
            vector.at(i)->setMin(int(map["list"].toList().at(i).toMap()["temp"].toMap()["min"].toDouble()));
            vector.at(i)->setTemp(int(map["list"].toList().at(i).toMap()["temp"].toMap()["day"].toDouble()));
            vector.at(i)->setIcon(map["list"].toList().at(i).toMap()["weather"].toList().at(0).toMap()["icon"].toString());
        }
        requestOver();
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

MeteoBeans* MeteoManager::getMeteoBeans(int i){
    return vector.at(i);
}

void MeteoManager::updateData()
{
    this->update();
}



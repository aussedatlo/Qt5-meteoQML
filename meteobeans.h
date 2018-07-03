#ifndef METEOBEANS_H
#define METEOBEANS_H

#include <QObject>
#include <QString>

class MeteoBeans : public QObject
{
    Q_OBJECT
public:
    MeteoBeans(QObject *parent = 0);
    ~MeteoBeans();

    double getTemp() const;
    void setTemp(double value);

    double getMin() const;
    void setMin(double value);

    double getMax() const;
    void setMax(double value);

    QString getIcon();
    void setIcon(QString value);

private:
    double temp;
    double min;
    double max;
    QString icon;
};

#endif // METEOBEANS_H

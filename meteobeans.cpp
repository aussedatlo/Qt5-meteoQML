#include "meteobeans.h"

MeteoBeans::MeteoBeans(QObject *parent) :
    QObject(parent)
{
}

MeteoBeans::~MeteoBeans()
{
}


double MeteoBeans::getTemp() const
{
    return temp;
}

void MeteoBeans::setTemp(double value)
{
    temp = value;
}

double MeteoBeans::getMin() const
{
    return min;
}

void MeteoBeans::setMin(double value)
{
    min = value;
}

double MeteoBeans::getMax() const
{
    return max;
}

void MeteoBeans::setMax(double value)
{
    max = value;
}

QString MeteoBeans::getIcon()
{
    return icon;
}

void MeteoBeans::setIcon(QString value)
{
    icon = value;
}

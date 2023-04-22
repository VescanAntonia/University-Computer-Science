from django.db import models
class TravelAgency(models.Model):
    name=models.CharField(max_length=100)
    website=models.CharField(max_length=100)
    address=models.CharField(max_length=100)
    nrOfEmployees=models.IntegerField()
    nrOfOffers=models.IntegerField()
    cityBreak=models.ManyToManyField('CityBreak',through='CityBreakAgency')

    def __str__(self):
        return self.name
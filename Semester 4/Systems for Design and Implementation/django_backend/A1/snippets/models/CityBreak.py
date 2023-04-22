from django.db import models
class CityBreak(models.Model):
    country = models.CharField(max_length=100)
    city=models.CharField(max_length=100)
    hotel=models.CharField(max_length=100)
    price=models.FloatField()
    transport=models.CharField(max_length=100)
    agency=models.ManyToManyField('TravelAgency',through='CityBreakAgency')
    # agency=models.ForeignKey(TravelAgency,on_delete=models.CASCADE,default=None)

    def __str__(self):
        return self.country
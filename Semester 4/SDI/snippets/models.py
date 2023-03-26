from django.db import models

# Create your models here.
from django.db import models
from rest_framework import serializers
from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles


class TravelAgency(models.Model):
    name=models.CharField(max_length=100)
    website=models.CharField(max_length=100)
    address=models.CharField(max_length=100)
    nrOfEmployees=models.IntegerField()
    nrOfOffers=models.IntegerField()
    cityBreak=models.ManyToManyField('CityBreak',through='CityBreakAgency')

    def __str__(self):
        return self.name


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

class Person(models.Model):
    first_name=models.CharField(max_length=100)
    last_name=models.CharField(max_length=100)
    age=models.IntegerField()
    gender=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    cityBreak=models.ForeignKey(CityBreak,on_delete=models.CASCADE)

    def __str__(self):
        return self.first_name

class CityBreakAgency(models.Model):
    cityBreak=models.ForeignKey(CityBreak,on_delete=models.CASCADE)
    agency=models.ForeignKey(TravelAgency,on_delete=models.CASCADE)
    creatingDate=models.DateField()
    enrollmentDeadline=models.DateField()

    def __str__(self):
        return f"{self.cityBreak.country}-{self.agency.name}"


# class CityBreakPerson(models.Model):
#     cityBreak=models.ForeignKey(CityBreak,on_delete=models.CASCADE)
#     person=models.ForeignKey(Person,on_delete=models.CASCADE)
#     contractDate=models.DateField(auto_now_add=True)
#     advancePayment=models.FloatField(default=50)
#
#     def __str__(self):
#         return f"{self.cityBreak}-{self.person}"


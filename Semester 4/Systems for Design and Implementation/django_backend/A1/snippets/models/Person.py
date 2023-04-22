from django.db import models
from snippets.models.CityBreak import CityBreak

class Person(models.Model):
    first_name=models.CharField(max_length=100)
    last_name=models.CharField(max_length=100)
    age=models.IntegerField()
    gender=models.CharField(max_length=100)
    email=models.CharField(max_length=100)
    cityBreak=models.ForeignKey(CityBreak,on_delete=models.CASCADE)

    def __str__(self):
        return self.first_name
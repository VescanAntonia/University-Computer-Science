from django.db import models
from snippets.models.CityBreak import CityBreak
from snippets.models.TravelAgency import TravelAgency
class CityBreakAgency(models.Model):
    cityBreak=models.ForeignKey(CityBreak,on_delete=models.CASCADE)
    agency=models.ForeignKey(TravelAgency,on_delete=models.CASCADE)
    creatingDate=models.DateField()
    enrollmentDeadline=models.DateField()

    def __str__(self):
        return f"{self.cityBreak.country}-{self.agency.name}"
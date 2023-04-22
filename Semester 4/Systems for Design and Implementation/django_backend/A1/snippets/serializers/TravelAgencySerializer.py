from rest_framework import serializers
from snippets.models.TravelAgency import TravelAgency

class TravelAgencySerializerIds(serializers.ModelSerializer):
    class Meta:
        model=TravelAgency
        fields=('id',)

class TravelAgencySerializer(serializers.ModelSerializer):
    avg_price=serializers.FloatField(read_only=True)

    class Meta:
        model=TravelAgency
        fields=('id','name','website','address','nrOfEmployees','nrOfOffers','avg_price')
        #fields='__all__'

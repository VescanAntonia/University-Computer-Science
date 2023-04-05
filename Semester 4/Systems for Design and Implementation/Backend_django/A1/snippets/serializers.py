from rest_framework import serializers
from .models import CityBreak,Person,TravelAgency
from .models import CityBreakAgency

class PersonSerializer(serializers.ModelSerializer):
    def validate_citybreak_id(self, value):
        filter = CityBreak.objects.filter(id=value)
        if not filter.exists():
            raise serializers.ValidationError("City break does not exist")
        return value
    class Meta:
        model=Person
        fields='__all__'
        # fields=('id','first_name','last_name','age','gender','citybreak_id')

class PersonSerializerIds(serializers.ModelSerializer):
    class Meta:
        model=Person
        fields=('id',)

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


class CityBreakSerializer(serializers.ModelSerializer):
    num_other_agencies=serializers.FloatField(read_only=True)
    class Meta:
        model=CityBreak
        fields=('id','country','city','hotel','price','transport','agency','num_other_agencies')
        #fields ='__all__'

    def create(self, validated_data):
        """
        Create and return a new `Snippet` instance, given the validated data.
        """
        return CityBreak.objects.create(**validated_data)

class CityBreakAgencySerializer(serializers.ModelSerializer):
    cityBreak_id=serializers.IntegerField(write_only=True)
    agency_id=serializers.IntegerField(write_only=True)

    def validate_citybreak_id(self, value):
        filter = CityBreak.objects.filter(id=value)
        if not filter.exists():
            raise serializers.ValidationError("City break does not exist")
        return value

    def validate_agency_id(self, value):
        filter = TravelAgency.objects.filter(id=value)
        if not filter.exists():
            raise serializers.ValidationError("Travel agency does not exist")
        return value

    class Meta:
        model=CityBreakAgency
        fields='__all__'
        #fields=('cityBreak_id','agency_id')


#
# class CityBreakPersonSerializer(serializers.ModelSerializer):
#     cityBreak_id=serializers.IntegerField(write_only=True)
#     person_id=serializers.IntegerField(write_only=True)
#
#     class Meta:
#         model=CityBreakPerson
#         fields=('cityBreak_id','person_id')


from rest_framework import serializers
from snippets.models.Person import Person
from snippets.models.CityBreak import CityBreak


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
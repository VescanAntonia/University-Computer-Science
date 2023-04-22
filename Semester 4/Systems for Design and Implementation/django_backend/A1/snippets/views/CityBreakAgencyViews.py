from snippets.models.CityBreak import CityBreak
from django.db.models import Avg,Count,OuterRef

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework import generics
from rest_framework.views import APIView
from snippets.serializers.CityBreakSerializers import CityBreakAgencySerializer,CityBreakAgency,CityBreakSerializer
from snippets.serializers.TravelAgencySerializer import TravelAgencySerializer,TravelAgency

class CityBreakAgencyContract(APIView):
    queryset = CityBreakAgency.objects.all()
    serializer_class = CityBreakAgencySerializer
    # def get_queryset(self):
    #     #obj=CityBreak.objects.all().values_list('id',flat=True)
    #     query = CityBreakPerson.objects.all().values()
    #     print(query.query)
    #     return query


    def get(self, request):
        #obj=CityBreak.objects.all().values_list('id',flat=True)
        queryset = CityBreakAgency.objects.all()
        serializer = CityBreakAgencySerializer(queryset, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


    def post(self, request):
        serializer = CityBreakAgencySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)

class TravelAgencyOrderedByAveragePriceOfCitybreak(generics.ListCreateAPIView):
    serializer_class = TravelAgencySerializer

    def get_queryset(self):
        query=TravelAgency.objects\
                .annotate(avg_price=Avg('citybreakagency__cityBreak__price'))\
            .order_by('avg_price')
        print(query.query)
        return query

class CityBreaksByNumberOfOtherAgenciesContract(generics.ListCreateAPIView):
    serializer_class = CityBreakSerializer
    def get_queryset(selfself):
        query=CityBreak.objects.annotate(
            num_other_agencies=Count(
                TravelAgency.cityBreak.through.objects.filter(
                    cityBreak_id=OuterRef('pk')
                ).exclude(
                    agency_id=OuterRef('agency__id')
                ).values('agency_id').distinct(),
                distinct=True
            )
        ).order_by('-num_other_agencies')[:3]
        print(query.query)
        return query

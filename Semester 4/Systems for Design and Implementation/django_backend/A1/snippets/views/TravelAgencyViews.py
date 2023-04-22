from snippets.models.TravelAgency import TravelAgency
from django.db.models import Avg,Count,OuterRef

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from rest_framework import generics
from rest_framework.views import APIView
from snippets.serializers.TravelAgencySerializer import TravelAgencySerializerIds,TravelAgencySerializer

class TravelAgencyList(generics.ListAPIView):
    queryset = TravelAgency.objects.all()
    serializer_class = TravelAgencySerializer

    def get(self, request):
        obj = TravelAgency.objects.all()
        serializer = TravelAgencySerializer(obj, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request):
        serializer = TravelAgencySerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.data, status=status.HTTP_400_BAD_REQUEST)

class TravelAgencyIds(generics.ListAPIView):
    queryset = TravelAgency.objects.all()
    serializer_class = TravelAgencySerializerIds
    def get(self,request):
        obj=TravelAgency.objects.all()
        serializer=TravelAgencySerializerIds(obj,many=True)
        return Response(serializer.data,status=status.HTTP_200_OK)

class TravelAgencyDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = TravelAgency.objects.all()
    serializer_class = TravelAgencySerializer
    def get(self,request,id):
        try:
            obj = TravelAgency.objects.get(id=id)
        except TravelAgency.DoesNotExist:
            msg = {"msg": "not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)

        serializer=TravelAgencySerializer(obj)
        return Response(serializer.data,status=status.HTTP_200_OK)

    def put(self, request, id):
        try:
            obj = TravelAgency.objects.get(id=id)
        except TravelAgency.DoesNotExist:
            msg = {"msg": "Not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)
        serializer = TravelAgencySerializer(obj, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def patch(self, request, id):
        try:
            obj = TravelAgency.objects.get(id=id)
        except TravelAgency.DoesNotExist:
            msg = {"msg": "Not found"}
            return Response(msg, status=status.HTTP_404_NOT_FOUND)
        serializer = TravelAgencySerializer(obj, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_205_RESET_CONTENT)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


    def delete(self,request,id):
        try:
            obj=TravelAgency.objects.get(id=id)
        except TravelAgency.DoesNotExist:
            msg={"msg":"not found"}
            return Response(msg,status=status.HTTP_404_NOT_FOUND)
        obj.delete()
        return Response({"msg":"deleted"},status=status.HTTP_204_NO_CONTENT)

class TravelAgenciesWithMoreThan100Emplyees(generics.ListAPIView):
    serializer_class = TravelAgencySerializer
    queryset = TravelAgency.objects.all()
    def get(self,request):
        employees = TravelAgency.objects.filter(nrOfEmployees__gte=100).values()
        serializer = TravelAgencySerializer(employees, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
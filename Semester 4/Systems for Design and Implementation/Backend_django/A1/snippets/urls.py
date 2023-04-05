"""A1 URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,re_path
import django_extensions
from . import views
from .views import CityBreaksDetail,CityBreaksWithPriceBiggerThanN,CityBreaksInfo,PersonDetail,PersonList,TravelAgencyDetail,TravelAgencyList,PersonIds,TravelAgencyIds
#from .views import cityBreaksListView,cityBreaksDetailView
from .views import CityBreakAgencyContract,TravelAgencyOrderedByAveragePriceOfCitybreak,CityBreaksByNumberOfOtherAgenciesContract,AddCitybreaks
from rest_framework_swagger.views import get_swagger_view
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi

schema_view = get_schema_view(
    openapi.Info(
        title="Jaseci API",
        default_version='v1',
        description="Welcome to the world of Jaseci",
        terms_of_service="https://www.jaseci.org",
        contact=openapi.Contact(email="jason@jaseci.org"),
        license=openapi.License(name="Awesome IP"),
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)

urlpatterns = [

    re_path(r'^doc(?P<format>\.json|\.yaml)$',
            schema_view.without_ui(cache_timeout=0), name='schema-json'),  #<-- Here
    path('doc/', schema_view.with_ui('swagger', cache_timeout=0),
         name='schema-swagger-ui'),  #<-- Here
    path('redoc/', schema_view.with_ui('redoc', cache_timeout=0),
         name='schema-redoc'),  #<-- Here

    #path('',views.cityBreaksListView),
    path("cit/",CityBreaksDetail.as_view(),name="cit"),
    #path('cityBreaks/', cityBreaksListView.as_view()),
    path("cit/<int:id>/",CityBreaksInfo.as_view()),


    path("person/",PersonList.as_view()),
    path("person/<int:pk>/",PersonDetail.as_view()),
    path("person/ids/",PersonIds.as_view()),


    path("travel/",TravelAgencyList.as_view()),
    path("travel/<int:pk>/",TravelAgencyDetail.as_view()),
    path("travel/ids/",TravelAgencyIds.as_view()),
    path("citAgency/",CityBreakAgencyContract.as_view()),
    path("travel/by-avg-price/",TravelAgencyOrderedByAveragePriceOfCitybreak.as_view()),
    path("cit/by-other-agencies-contract/",CityBreaksByNumberOfOtherAgenciesContract.as_view()),
    #path("contract/",PersonCityBreakContract.as_view()),
    path("cit/filter/",CityBreaksWithPriceBiggerThanN.as_view()),
    path("cit/filter/<int:n>/",CityBreaksWithPriceBiggerThanN.as_view()),

    path('cit/<int:id>/person/', AddCitybreaks.as_view())
]

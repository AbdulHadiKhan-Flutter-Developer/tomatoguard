from django.urls import path
from .views import getdata, Deletedata, userprofileview

urlpatterns = [
    path('usersearchingdata/', getdata.as_view(), name='user-searching-data'),
    path('usersearchingdata/<int:id>/', Deletedata.as_view(), name='delete-data'),
    path('userprofile/', userprofileview.as_view(), name='userprofile'),
    path('userprofile/<str:uid>/', userprofileview.as_view(), name='get-userprofile'),  
]

from django.db import models

# Create your models here.
class usersearchingdata (models.Model):
    DiseaseName = models.CharField(max_length=200)
    DiseaseImage = models.ImageField(upload_to='images/')
    Date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.DiseaseName[:200]


class userprofile(models.Model):
    uid = models.CharField(max_length=100,unique=True)
    username = models.CharField(max_length=100)
    useremail = models.CharField(max_length=200)
    userfarmingexperience = models.CharField(max_length=200)
    userimage = models.ImageField(upload_to='userprofile/')

    def __str__(self):
        return self.username[:100]    

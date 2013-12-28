from django.db import models

class FacebookUser(models.Model):
	fb_id = models.CharField(max_length=250)
	highest_score = models.ForeignKey("Highscore")
	class Meta:
		db_table = 't_facebook_user'

# Create your models here.
class Highscore(models.Model):
	score = models.IntegerField(default=0)
	player = models.CharField(max_length=250, null=True)
	user = models.ForeignKey(FacebookUser)
	class Meta:
		db_table = 't_highscore'


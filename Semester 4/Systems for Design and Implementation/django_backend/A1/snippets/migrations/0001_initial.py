# Generated by Django 4.1.7 on 2023-03-05 19:03

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='CityBreaks',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('country', models.CharField(blank=True, default='', max_length=100)),
                ('city', models.CharField(default='', max_length=100)),
                ('hotel', models.CharField(default='', max_length=150)),
                ('price', models.IntegerField(default=0)),
                ('transport', models.CharField(default='plane', max_length=100)),
            ],
        ),
    ]
# Enter_challenge

## Context
Analysis is based on data of orders and appointments of customers in the timeframe from Sep 2023 to Mar 2024 with 78k observations.

## Problem Statement
What business actions can be taken based on the ordering process at Enter?

## Project setup
To get setup with this project:

1. Ensure Docker is installed and running
2. ⁠Add the input csv files (named ```appointments.csv``` & ```orders.csv```) to the ```input_data``` folder
3. ⁠Run ```docker-compose up``` from the root of the project (note the input files are needed during the build process)
4. ⁠*the ```./src/preparation.py``` file will build a small set of cleaned files/tables from the input data.
5. ⁠Open up the running juypter notebook on ```http://localhost:8888/?token=token```

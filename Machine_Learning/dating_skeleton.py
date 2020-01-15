import pandas as pd
import numpy as np
from matplotlib import pyplot as plt

#Create your df here:

df = pd.read_csv("profiles.csv")
print(df.job.head())
print(df.diet.head())
print(df.drinks.head())
print(df.income.head())
print(df.offspring.head())

print(df.offspring.value_counts())

plt.hist(df.age, bins=20)
plt.xlabel("Age")
plt.ylabel("Frequency")
plt.xlim(16, 80)
plt.show()

print(df.sign.value_counts())

drink_mapping = {"not at all": 0, "rarely": 1, "socially": 2, "often": 3, "very often": 4, "desperately": 5}

df["drinks_code"] = df.drinks.map(drink_mapping)
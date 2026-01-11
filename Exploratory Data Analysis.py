from google.colab import files
uploaded = files.upload()

import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

plt.style.use("default")

df = pd.read_excel("sales_data.xlsx")

print(df.head())

df.info()
print(df.describe())

print(df[["age","marketing_spend","sales"]].describe())

categorical_cols = ["region","segment","product","category"]
for col in categorical_cols:
  print(col)
  print(df[col].value_counts())

df[["age","marketing_spend","sales"]].hist(bins=15, figsize=(10,5))
plt.show()

for col in categorical_cols:

    df[col].value_counts().plot(kind="bar")
    plt.show()

sns.scatterplot(x="marketing_spend", y="sales", data=df)
plt.show()

plt.figure(figsize=(8,5))
sns.heatmap(df[["age","marketing_spend","sales"]].corr(), annot=True, cmap="coolwarm")
plt.show()

sns.pairplot(df[["age","marketing_spend","sales"]])
plt.show()

total_revenue = df["sales"].sum()
avg_order_value = df["sales"].mean()
top_product = df.groupby("product")["sales"].sum().idxmax()
best_region = df.groupby("region")["sales"].sum().idxmax()
total_customers = df["customer_id"].nunique()

print(total_revenue)
print(avg_order_value)
print(top_product)
print(best_region)
print(total_customers)

df.to_csv("cleaned_sales_data.csv", index=False)
files.download("cleaned_sales_data.csv")

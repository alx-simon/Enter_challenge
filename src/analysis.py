import pandas as pd

'''df = pd.read_csv('events_table.csv')
print(df.head())
mean_time_difference = df.groupby('event_name')['time_difference_events'].mean()
print(mean_time_difference)
df_filtered = df[df['event_name'] == 'no_prior_event']
print(df_filtered)

df_check = pd.read_csv('./input_data/appointments.csv')
df_02e1337f38=df_check[df_check['customer_id']== '02e1337f38']
print(df_02e1337f38)'''

#check customer has no NAN
'''df = pd.read_csv('customers_table.csv')
print(df.info())'''

df = pd.read_csv('events_table.csv')
mean_time_difference = df.groupby('event_name')['time_difference_events'].mean()
print(mean_time_difference)
df_filtered = df[df['event_name'] == 'no_prior_event']
print(df_filtered)

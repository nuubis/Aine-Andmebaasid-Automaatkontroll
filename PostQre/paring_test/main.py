import psycopg2
import os

db_params = {
    'host': 'localhost',
    'database': 'Eurovision',
    'user': 'postgres',
    'password': 'sql',
    'port': '5432'
}

def get_yl(failitee, yl_nr):
    with open(failitee) as f:
        query = ''
        for line in f:
            query += line.strip('\n') + " "
    create_view_query = """
        CREATE OR REPLACE VIEW """ + yl_nr + """ AS
        """ + query
    return create_view_query

create_view_query1 = get_yl('./YL1.txt', 'yl1')
create_view_query2 = get_yl('./YL2.txt', 'yl2')
create_view_query3 = get_yl('./YL3.txt', 'yl3')
create_view_query4 = get_yl('./YL4.txt', 'yl4')

with open('euro_test.sql', 'r') as script_file:
    sql_script = script_file.read()
#def get_yl(failitee):
"""queryd = []
with open('./YL.txt') as f:
    queryd = f.read().split(';')
    print(queryd)
    i = 1
    for query in queryd:
        print('YL' + str(i) + ': ' +query.strip('\n'))
        i += 1
    """
try:
    with psycopg2.connect(**db_params) as connection:
        with connection.cursor() as cursor:
            # Execute the CREATE VIEW statement
            print('YL1: ' + create_view_query1)
            cursor.execute(create_view_query1)
            
            print('YL2: ' + create_view_query2)
            cursor.execute(create_view_query2)
            
            print('YL3: ' + create_view_query3)
            cursor.execute(create_view_query3)
            
            print('YL4: ' + create_view_query4)
            cursor.execute(create_view_query4)

            # Commit the changes
            connection.commit()
            cursor.execute("SELECT * FROM yl1;")
            rows = cursor.fetchall()
            for row in rows:
                print(row)
            
            cursor.execute("SELECT * FROM yl2;")
            rows = cursor.fetchall()
            for row in rows:
                print(row)
                
            cursor.execute("SELECT * FROM yl3;")
            rows = cursor.fetchall()
            for row in rows:
                print(row)
                
            cursor.execute("SELECT * FROM yl4;")
            rows = cursor.fetchall()
            for row in rows:
                print(row)
            
            cursor.execute(sql_script)
            connection.commit()
            
except (Exception, psycopg2.Error) as error:
    print("Error while connecting to PostgreSQL:", error)    
        
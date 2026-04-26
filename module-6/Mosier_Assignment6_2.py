import mysql.connector

db = mysql.connector.connect(
    host="localhost",
    user="movies_user",
    password="NEW_PASSWORD",
    database="movies"
)

cursor = db.cursor()
# Query 1
print("\n--DISPLAYING Studio RECORDS --")
cursor.execute("SELECT * FROM studio")
studios = cursor.fetchall()
for studio in studios:
    print("Studio ID: {}\nStudio Name: {}\n" .format(studio[0],studio[1]))

# Query 2
print("\n--DISPLAYING Genre RECORDS --")
cursor.execute("SELECT * FROM genre")
genres = cursor.fetchall()
for genre in genres:
    print("Genre ID: {}\nGenre Name: {}\n".format(genre[0], genre[1]))

# Query 3
print("\n--DISPLAYING Short Film RECORDS --")
cursor.execute("SELECT film_name FROM film WHERE film_runtime < 120")
short_films = cursor.fetchall()
for film in short_films:
    print("Film Name: {}\n".format(film[0]))

# Query 4
print("\n-- DISPLAYING Director RECORDS in Order --")
cursor.execute("SELECT film_name, film_director FROM film ORDER BY film_director")
directors = cursor.fetchall()
for film in directors:
    print("Film Name: {}\nDirector: {}\n".format(film[0], film[1]))

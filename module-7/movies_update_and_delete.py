#Megan Mosier
#CSD-310
#Module 7.2 Update and Delete

import mysql.connector
from mysql.connector import errorcode

config = {
    "user": "movies_user",
    "password": "NEW_PASSWORD",
    "host": "127.0.0.1",
    "database": "movies",
    "raise_on_warnings": True
}

def show_films(cursor, title):
    cursor.execute("""
        SELECT film_name AS Name,
                film_director AS Director,
                genre_name AS Genre,
                studio_name AS Studio
        FROM film
        INNER JOIN genre ON film.genre_id = genre.genre_id
        INNER JOIN studio ON film.studio_id = studio.studio_id""")
    
    films = cursor.fetchall()

    print("\n -- {} --".format(title))
    print("  Film Name          Director        Genre        Studio")
    print("  " + "-" * 75)
    for film in films:
        print("   {:<27}{:<23}{:<13}{}".format(film[0], film[1], film[2], film[3]))

try:
    db=mysql.connector.connect(**config)
    cursor = db.cursor()
    print("\n Database user {} connected to MySQL on host {} with database {}".format(
        config["user"], config["host"], config["database"]))
    input("\n\n Press any key to continue. . .")

    #1 - Original dsplay
    show_films(cursor, "DISPLAYING FILMS")

    #2 - INSERT
    cursor.execute("""
        INSERT INTO film (film_name, film_director, genre_id, studio_id, film_releaseDate, film_runtime)
        VALUES ('The Dark Knight', 'Christopher Nolan', 2, 2, '2008', 152)
    """)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER INSERT")

    #3 - UPDATE
    cursor.execute("""
        UPDATE film
        SET genre_id = (SELECT genre_id FROM genre WHERE genre_name = 'Horror' )
        WHERE film_name = 'Alien'
    """)
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER UPDATE - ALIEN IS NOW HORROR")

    #4 - Delete
    cursor.execute("DELETE FROM film WHERE film_name = 'Gladiator'")
    db.commit()
    show_films(cursor, "DISPLAYING FILMS AFTER DELETE")
except mysql.connector.Error as err:
    if err.errno == errorcode.ER_ACCESS_DENIED_ERROR:
        print(" The supplied username or password are invalid")
    elif err.errno == errorcode.ER_BAD_DB_ERROR:
        print("  The specified database does not exist")
    else:
        print(err)

finally:
    if 'cursor' in dir():
        cursor.close()
    if 'db' in dir():
        db.close()
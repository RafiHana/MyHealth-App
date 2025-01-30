import paho.mqtt.client as mqtt
from mysql.connector import Error
import mysql.connector
from datetime import datetime
import os
from dotenv import load_dotenv

load_dotenv()

DB_CONFIG = {
    "host": os.getenv("DB_HOST"),      
    "user": os.getenv("DB_USER"),      
    "password": os.getenv("DB_PASS"),  
    "database": os.getenv("DB_NAME"),  
}

MQTT_CONFIG = {
    "broker": os.getenv("MQTT_BROKER"), 
    "port": int(os.getenv("MQTT_PORT")),
    "topics": ["suhu", "kelembapan", "karbon_dioksida", "asap"]
}

def save_to_database(topic, value):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        
        if topic == "suhu":
            query = "INSERT INTO sensor_data (temperature, timestamp) VALUES (%s, %s)"
        elif topic == "kelembapan":
            query = "INSERT INTO sensor_data (humidity, timestamp) VALUES (%s, %s)"
        elif topic == "karbon_dioksida":
            query = "INSERT INTO sensor_data (co2, timestamp) VALUES (%s, %s)"
        elif topic == "asap":
            query = "INSERT INTO sensor_data (smoke, timestamp) VALUES (%s, %s)"
        else:
            return
        
        timestamp = datetime.now()
        cursor.execute(query, (float(value), timestamp))
        connection.commit()
        print(f"Data tersimpan: {topic} = {value}")

    except Error as e:
        print(f"Error: {e}")
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def on_message(client, userdata, msg):
    topic = msg.topic
    payload = msg.payload.decode()
    print(f"Pesan diterima: [{topic}] {payload}")
    save_to_database(topic, payload)

def main():
    client = mqtt.Client()
    client.connect(MQTT_CONFIG["broker"], MQTT_CONFIG["port"])
    
    for topic in MQTT_CONFIG["topics"]:
        client.subscribe(topic)
    
    client.on_message = on_message
    print("Menghubungkan ke MQTT dan database...")
    client.loop_forever()

if __name__ == "__main__":
    main()
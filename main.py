from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import pandas as pd
import numpy as np
import bcrypt
import os
import datetime
import jwt
from flask_cors import CORS, cross_origin
import pickle
from sklearn.model_selection import GridSearchCV, StratifiedKFold
from sklearn.metrics import mean_absolute_error
from sklearn.model_selection import RepeatedKFold
from sklearn.metrics import make_scorer
from numpy import absolute
from sklearn.model_selection import cross_val_score
from sklearn.pipeline import Pipeline

# Flask app settings
app = Flask(__name__)

# Enable CORS
cors = CORS(app, resources={r"/*": {"origins": "*"}})
app.config['CORS_HEADERS'] = 'Content-Type'
import pandas as pd 


#Memuat dataset yang dibutuhkan 
df = pd.read_csv('male_players (legacy).csv')
# take environment variables from .env.
df = df[df['fifa_version'] == 23]

#Memilih fitur yang dibutuhkan dari dataset yang sudah dimuat
selected_columns = df[['rwb', 'lwb', 'rb', 'lb', 'cb', 'cdm', 'lm', 'rm', 'lw', 'rw', 'cf', 'st', 
                      'movement_sprint_speed', 'movement_acceleration', 'mentality_positioning',
                      'mentality_interceptions', 'mentality_aggression','attacking_finishing',
                      'power_shot_power', 'power_long_shots', 'attacking_volleys',
                      'mentality_penalties', 'mentality_vision', 'attacking_crossing',
                      'skill_fk_accuracy', 'attacking_short_passing', 'skill_long_passing',
                      'skill_curve', 'movement_agility', 'movement_balance',
                      'movement_reactions', 'skill_ball_control', 'skill_dribbling',
                      'mentality_composure', 'attacking_heading_accuracy', 'defending_marking_awareness',
                      'defending_standing_tackle', 'defending_sliding_tackle', 'power_jumping',
                      'power_stamina', 'power_strength', 'long_name']]

player_position = selected_columns[['rwb', 'lwb', 'rb', 'lb', 'cb', 'cdm', 'lm', 'rm', 'lw', 'rw', 'cf', 'st']]
def convert_strings_to_integers(dataframe):

    def convert_string_to_int(value):
        if '-' in value:
            parts = value.split('-')
            return int(parts[0]) - int(parts[1])
        else:
            parts = value.split('+')
            return int(parts[0])

    return dataframe.applymap(convert_string_to_int)

player_position_transformed = convert_strings_to_integers(player_position)



# Model Section
model = pickle.load(open('model_pertama.pkl', 'rb'))

# Mysql Settings
app.config['MYSQL_USER'] = os.getenv('MYSQL_USER') or 'root'
app.config['MYSQL_PASSWORD'] = os.getenv('MYSQL_PASSWORD') or ''
app.config['MYSQL_HOST'] = os.getenv('MYSQL_HOST') or '127.0.0.1' # localhost
app.config['MYSQL_DB'] = os.getenv('MYSQL_DB') or 'soccer_db'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

# MySQL Connection
mysql = MySQL(app)

def check_token():
    token = request.headers.get('Authorization')
    try:
        decoded_token = jwt.decode(token, 'secret', algorithms=['HS256'])
        return decoded_token
    except jwt.InvalidTokenError:
        return None

@app.route('/authenticate', methods=['POST'])
def authenticate():
    username = request.json['username']
    password = request.json['password']
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM users WHERE username=%s', (username,))
    user = cursor.fetchone()
    if user:
        hashed_password = user['password'].encode('utf-8')
        
        if bcrypt.checkpw(password.encode('utf-8'), hashed_password):
            token = jwt.encode(payload={'user_id': user['id'], 'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=2)},
                            key='secret',
                            algorithm="HS256")
            return jsonify({'status': 'success', 'message': 'Authentication successful', 'data': {'token': token}}), 200
    return jsonify({'message': 'Authentication failed'}), 401

@app.route('/user', methods=['GET'])
def get_user():
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    id = decoded['user_id']

    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM users WHERE id=%s', (id,))
    user = cursor.fetchone()
    return jsonify({'status': 'success', 'message': 'User retrieved successfully', 'data': user})

from flask import request, jsonify
import bcrypt
import jwt
import datetime

@app.route('/register', methods=['POST'])
def register():
    try:
        username = request.json['username']
        password = request.json['password']
        role = request.json['role']
        name = request.json['name']
        email = request.json['email']
        phone = request.json['phone']
        birth_date = request.json['birthdate']

        cursor = mysql.connection.cursor() # get the cursor from the connection
        cursor.execute('SELECT * FROM users WHERE username=%s', (username,))
        user = cursor.fetchone()

        if user:
            return jsonify({'message': 'User already exists'}), 409

        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
        hashed_pass = hashed_password.decode('utf-8')
        cursor.execute('INSERT INTO users (username, password, role, name, email, phone) VALUES (%s, %s, %s, %s, %s, %s)', (username, hashed_pass, role, name, email, phone))
        mysql.connection.commit()

        cursor.execute('SELECT * FROM users WHERE username=%s', (username,))
        user = cursor.fetchone()
        user_id = user['id']
        print(user_id,user)
        if role == 1:
            cursor.execute('INSERT INTO players (user_id, birth_date) VALUES (%s, %s)', (user_id, birth_date))
            mysql.connection.commit()

        token = jwt.encode(payload={'user_id': user['id'], 'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=2)},
                    key='secret',
                    algorithm="HS256")

        return jsonify({'message': 'User created successfully', 'status': 'success', 'token': token}), 201

    except Exception as e:
        return jsonify({'message': str(e)}), 500


@app.route('/positions', methods=['GET'])
def display_positions():
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM positions')

    positions = cursor.fetchall()
    return jsonify({'message': 'Positions retrieved successfully', 'data': positions, 'status': 'success'})

@app.route('/articles', methods=['GET'])
def display_articles():
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT articles.*, GROUP_CONCAT(positions.name) AS positions, users.name AS user_name FROM articles LEFT JOIN article_positions ON articles.id = article_positions.article_id LEFT JOIN positions ON article_positions.position_id = positions.id LEFT JOIN users ON articles.user_id = users.id GROUP BY articles.id')

    articles = cursor.fetchall()
    return jsonify({'message': 'Articles retrieved successfully', 'data': articles, 'status': 'success'})

@app.route('/articles', methods=['POST'])
def create_article():
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    user_id = decoded['user_id']

    cursor = mysql.connection.cursor() # get the cursor from the connection
    title = request.json['title']
    body = request.json['body']
    steps = request.json['steps']
    thumbnail = request.json['thumbnail']
    position_1 = request.json['position_1']
    position_2 = request.json['position_2']
    position_3 = request.json['position_3']

    # merge array
    positions = [position_1, position_2, position_3]
    create_date = datetime.datetime.now()
    cursor.execute('INSERT INTO articles (title, body, steps, thumbnail, create_date, user_id) VALUES (%s, %s, %s, %s, %s, %s)', (title, body, steps, thumbnail, create_date, user_id))
    mysql.connection.commit()

    id = cursor.lastrowid

    for position in positions:
        cursor.execute('INSERT INTO article_positions (article_id, position_id) VALUES (%s, %s)', (id, position))
        mysql.connection.commit()

    return jsonify({'message': 'Article created successfully','status': 'success'})

@app.route('/articles/attributes/<int:id>', methods=['GET'])
def get_article_attributes_by_id(id):
    cursor = mysql.connection.cursor()
    cursor.execute('''
    SELECT 
        a.id AS article_id,
        a.title AS article_title,
        a.body AS article_body,
        GROUP_CONCAT(DISTINCT p.name) AS article_positions,
        a.steps AS article_steps,
        a.thumbnail AS article_thumbnail,
        a.create_date AS article_create_date,
        ua.user_id AS player_user_id,
        ua.status AS player_status
    FROM 
        articles a
    LEFT JOIN 
        article_positions ap ON a.id = ap.article_id
    LEFT JOIN 
        positions p ON ap.position_id = p.id
    LEFT JOIN 
        user_articles ua ON a.id = ua.article_id
    WHERE 
        ap.position_id IN (
            SELECT position_1 FROM player_positions WHERE player_attributes_id = %s
            UNION
            SELECT position_2 FROM player_positions WHERE player_attributes_id = %s
            UNION
            SELECT position_3 FROM player_positions WHERE player_attributes_id = %s
        )
    GROUP BY 
        a.id, a.title, a.body, ua.user_id
    ''', (id, id, id))

    article_attributes = cursor.fetchall()

    return jsonify({'message': 'Article attributes retrieved successfully', 'data': article_attributes, 'status': 'success'})

@app.route('/articles/complete/<int:id>', methods=['GET'])
def get_completed_articles(id):
    cursor = mysql.connection.cursor()
    cursor.execute('SELECT * FROM user_articles WHERE user_id = %s AND article_id = %s AND status = 1', (id, id))
    articles = cursor.fetchall()
    
    if len(articles) == 0:
        return jsonify({'message': 'No completed articles found', 'status': 'success', 'data': False})
    else:
        return jsonify({'message': 'Completed articles retrieved successfully', 'data': articles, 'status': 'success'})




@app.route('/articles/complete/<int:id>', methods=['POST'])
def complete_article(id):
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401

    user_id = decoded['user_id']

    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('INSERT INTO user_articles (user_id, article_id, status) VALUES (%s, %s, %s)', (user_id, id, 1))
    mysql.connection.commit()

    return jsonify({'message': 'Article completed successfully','status': 'success'})

@app.route('/articles/<int:id>', methods=['GET'])
def display_article(id):
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT articles.id, articles.title, articles.body, articles.steps, articles.thumbnail, GROUP_CONCAT(positions.name) AS position_names FROM articles LEFT JOIN article_positions ON articles.id = article_positions.article_id LEFT JOIN positions ON article_positions.position_id = positions.id WHERE articles.id=%s GROUP BY articles.id', (id,))


    article = cursor.fetchone()
    return jsonify({'message': 'Article retrieved successfully','status': 'success', 'data': article})

@app.route('/articles/<int:id>', methods=['PUT'])
def update_article(id):
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    user_id = decoded['user_id']

    cursor = mysql.connection.cursor() # get the cursor from the connection
    title = request.json['title']
    body = request.json['body']
    steps = request.json['steps']
    thumbnail = request.json['thumbnail']
    position_1 = request.json['position_1']
    position_2 = request.json['position_2']
    position_3 = request.json['position_3']

    # merge array
    positions = [position_1, position_2, position_3]
    create_date = datetime.datetime.now()

    cursor.execute('UPDATE articles SET title=%s, body=%s, steps=%s, thumbnail=%s, create_date=%s WHERE id=%s', (title, body, steps, thumbnail, create_date, id ))
    mysql.connection.commit()

    cursor.execute('DELETE FROM article_positions WHERE article_id=%s', (id,))
    mysql.connection.commit()

    for position in positions:
        if position != "0":
            cursor.execute('INSERT INTO article_positions (article_id, position_id) VALUES (%s, %s)', (id, position))
            mysql.connection.commit()

    

    return jsonify({'message': 'Article updated successfully','status': 'success'})

@app.route('/articles/<int:id>', methods=['DELETE'])
def delete_article(id):
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('UPDATE articles SET deleted = 0 WHERE id = %s', (id,))
    mysql.connection.commit()

    return jsonify({'message': 'Article deleted successfully'})





@app.route('/player', methods=['GET'])
def get_player():
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    id = decoded['user_id']

    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM players LEFT JOIN users ON players.user_id = users.id WHERE players.user_id = %s', (id,))
    player = cursor.fetchone()

    cursor2 = mysql.connection.cursor()  # get the cursor from the connection
    cursor2.execute(
    'SELECT movement_sprint_speed, movement_acceleration, mentality_positioning, mentality_interceptions, '
    'mentality_aggression, attacking_finishing, power_shot_power, power_long_shots, '
    'attacking_volleys, mentality_penalties, mentality_vision, attacking_crossing, '
    'skill_fk_accuracy, attacking_short_passing, skill_long_passing, skill_curve, '
    'movement_agility, movement_balance, movement_reactions, skill_ball_control, '
    'skill_dribbling, mentality_composure, attacking_heading_accuracy, '
    'defending_marking_awareness, defending_standing_tackle, defending_sliding_tackle, '
    'power_jumping, power_stamina, power_strength, created_date, id, height, weight, prefered_foot '
    'FROM player_attributes2 WHERE user_id = %s ORDER BY created_date', (id,))

    attributes = cursor2.fetchall()

    #foreach attribute
    for attribute in attributes:
        cursor2.execute(
            'SELECT pos1.name, pos2.name, pos3.name, player_alike1, player_alike2, player_alike3 FROM player_positions LEFT JOIN positions as pos1 ON player_positions.position_1 = pos1.id LEFT JOIN positions as pos2 ON player_positions.position_2 = pos2.id LEFT JOIN positions as pos3 ON player_positions.position_3 = pos3.id WHERE player_attributes_id = %s', (attribute['id'],)
        )
        positions = cursor2.fetchone()

        attribute['positions'] = positions

        cursor2.execute(
        'SELECT '
        'MAX(art1.id) AS latest_art1_id, '
        'MAX(art1.title) AS latest_art1_title, '
        'MAX(art1.thumbnail) AS latest_art1_thumbnail, '
        'MAX(art2.id) AS latest_art2_id, '
        'MAX(art2.title) AS latest_art2_title, '
        'MAX(art2.thumbnail) AS latest_art2_thumbnail, '
        'MAX(art3.id) AS latest_art3_id, '
        'MAX(art3.title) AS latest_art3_title, '
        'MAX(art3.thumbnail) AS latest_art3_thumbnail '
        'FROM player_positions '
        'LEFT JOIN article_positions pos1 ON player_positions.position_1 = pos1.position_id '
        'LEFT JOIN article_positions pos2 ON player_positions.position_2 = pos2.position_id '
        'LEFT JOIN article_positions pos3 ON player_positions.position_3 = pos3.position_id '
        'LEFT JOIN articles art1 ON pos1.article_id = art1.id '
        'LEFT JOIN articles art2 ON pos2.article_id = art2.id '
        'LEFT JOIN articles art3 ON pos3.article_id = art3.id '
        'WHERE player_positions.player_attributes_id = %s '
        'GROUP BY player_positions.player_attributes_id', (attribute['id'],)
        )

        latest_articles = cursor2.fetchone()

        attribute['latest_articles'] = latest_articles




    cursor3 = mysql.connection.cursor()
    cursor3.execute(
    'SELECT '
    'MAX(art1.id) AS latest_art1_id, '
    'MAX(art1.title) AS latest_art1_title, '
    'MAX(art1.thumbnail) AS latest_art1_thumbnail, '
    'MAX(art2.id) AS latest_art2_id, '
    'MAX(art2.title) AS latest_art2_title, '
    'MAX(art2.thumbnail) AS latest_art2_thumbnail, '
    'MAX(art3.id) AS latest_art3_id, '
    'MAX(art3.title) AS latest_art3_title, '
    'MAX(art3.thumbnail) AS latest_art3_thumbnail '
    'FROM player_positions '
    'LEFT JOIN article_positions pos1 ON player_positions.position_1 = pos1.position_id '
    'LEFT JOIN article_positions pos2 ON player_positions.position_2 = pos2.position_id '
    'LEFT JOIN article_positions pos3 ON player_positions.position_3 = pos3.position_id '
    'LEFT JOIN articles art1 ON pos1.article_id = art1.id '
    'LEFT JOIN articles art2 ON pos2.article_id = art2.id '
    'LEFT JOIN articles art3 ON pos3.article_id = art3.id '
    'WHERE player_positions.user_id = %s '
    'GROUP BY pos1.position_id', (id,)
    )

    article = cursor3.fetchall()


    print(article)
    return jsonify({'message': 'Player retrieved successfully', 'data': {'player': player, 'attribute': attributes, 'article': article}, 'status': 'success'}), 200

@app.route('/attributes_master', methods=['GET'])
def get_attributes():
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM attributes')
    attributes = cursor.fetchall()

    return jsonify({'message': 'Attributes retrieved successfully', 'data': attributes, 'status': 'success'}), 200

@app.route('/attributes/<int:id>', methods=['GET'])
def get_attribute(id):
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT movement_sprint_speed, movement_acceleration, mentality_positioning, mentality_interceptions, '
                    'mentality_aggression, attacking_finishing, power_shot_power, power_long_shots, '
                    'attacking_volleys, mentality_penalties, mentality_vision, attacking_crossing, '
                    'skill_fk_accuracy, attacking_short_passing, skill_long_passing, skill_curve, '
                    'movement_agility, movement_balance, movement_reactions, skill_ball_control, '
                    'skill_dribbling, mentality_composure, attacking_heading_accuracy, '
                    'defending_marking_awareness, defending_standing_tackle, defending_sliding_tackle, '
                    'power_jumping, power_stamina, power_strength FROM player_attributes2 WHERE id=%s', (id,))
    attribute = cursor.fetchone()

    return jsonify({'message': 'Attribute retrieved successfully', 'data': attribute, 'status': 'success'}), 200
@app.route('/attribute', methods=['POST'])
def create_attribute():
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    user_id = decoded['user_id']

    try:
        json_attribute = request.get_json()
        new_attributes = json_attribute['attributes']

        attributes_series = pd.Series(new_attributes)
        # Insert into player_positions table
        alike = infer(attributes_series, player_position_transformed)
        result_object = {
            'rwb': round(alike['rwb']),
            'lwb': round(alike['lwb']),
            'rb': round(alike['rb']),
            'lb': round(alike['lb']),
            'cdm': round(alike['cdm']),
            'lw': round(alike['lw']),
            'rw': round(alike['rw']),
            'st': round(alike['st']),
            'cb': round(alike['cb']),
            'lm': round(alike['lm']),
            'rm': round(alike['rm']),
            'cf': round(alike['cf']),
        }
        
        positons = [pos.upper() for pos, _ in sorted(result_object.items(), key=lambda x: x[1], reverse=True)[:3]]

        player_alike = alike['similar_players']

        return jsonify({'message': 'Attributes updated successfully', 'status': 'success','positions': positons, 'alike': player_alike[0]}), 200

    except Exception as e:
        return jsonify({'message': f'Error updating attributes: {str(e)}'}), 500

@app.route('/attribute', methods=['PUT'])
def update_attribute():
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    user_id = decoded['user_id']

    try:
        json_attribute = request.get_json()
        new_attributes = json_attribute['attributes']

        cursor = mysql.connection.cursor()
        print(new_attributes['movement_sprint_speed'], user_id)
        #Insert the attributes in the database
        cursor.execute(
            'INSERT INTO player_attributes2 ('
            'movement_sprint_speed, movement_acceleration, mentality_positioning, mentality_interceptions, '
            'mentality_aggression, attacking_finishing, power_shot_power, power_long_shots, '
            'attacking_volleys, mentality_penalties, mentality_vision, attacking_crossing, '
            'skill_fk_accuracy, attacking_short_passing, skill_long_passing, skill_curve, '
            'movement_agility, movement_balance, movement_reactions, skill_ball_control, '
            'skill_dribbling, mentality_composure, attacking_heading_accuracy, '
            'defending_marking_awareness, defending_standing_tackle, defending_sliding_tackle, '
            'power_jumping, power_stamina, power_strength,height,weight,prefered_foot, user_id) '
            'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)',
            (new_attributes['movement_sprint_speed'], new_attributes['movement_acceleration'], new_attributes['mentality_positioning'],
             new_attributes['mentality_interceptions'], new_attributes['mentality_aggression'],
             new_attributes['attacking_finishing'], new_attributes['power_shot_power'],
             new_attributes['power_long_shots'], new_attributes['attacking_volleys'],
             new_attributes['mentality_penalties'], new_attributes['mentality_vision'],
             new_attributes['attacking_crossing'], new_attributes['skill_fk_accuracy'],
             new_attributes['attacking_short_passing'], new_attributes['skill_long_passing'],
             new_attributes['skill_curve'], new_attributes['movement_agility'],
             new_attributes['movement_balance'], new_attributes['movement_reactions'],
             new_attributes['skill_ball_control'], new_attributes['skill_dribbling'],
             new_attributes['mentality_composure'], new_attributes['attacking_heading_accuracy'],
             new_attributes['defending_marking_awareness'], new_attributes['defending_standing_tackle'],
             new_attributes['defending_sliding_tackle'], new_attributes['power_jumping'],
             new_attributes['power_stamina'], new_attributes['power_strength'],
             new_attributes['height'], new_attributes['weight'], new_attributes['prefered_foot'],
             user_id))
        print(cursor)
        mysql.connection.commit()
        print("Data inserted successfully")
        attributes_series = pd.Series(new_attributes)
        # Insert into player_positions table
        alike = infer(attributes_series, player_position_transformed)
        result_object = {
            'rwb': round(alike['rwb']),
            'lwb': round(alike['lwb']),
            'rb': round(alike['rb']),
            'lb': round(alike['lb']),
            'cdm': round(alike['cdm']),
            'lw': round(alike['lw']),
            'rw': round(alike['rw']),
            'st': round(alike['st']),
            'cb': round(alike['cb']),
            'lm': round(alike['lm']),
            'rm': round(alike['rm']),
            'cf': round(alike['cf']),
        }
        
        positions = [pos.upper() for pos, _ in sorted(result_object.items(), key=lambda x: x[1], reverse=True)[:3]]

        player_alike = alike['similar_players']
        cursor.execute(
            'SELECT p.id as position_id, pa.id as player_attributes_id '
            'FROM positions p '
            'JOIN player_attributes2 pa ON pa.user_id = %s '
            'WHERE p.name IN (%s, %s, %s) '
            'ORDER BY pa.created_date DESC', (user_id, positions[0], positions[1], positions[2])
        )
        
        result = cursor.fetchall()
        print(positions,player_alike,result)
        cursor.execute(
            'INSERT INTO player_positions (user_id, player_attributes_id, position_1, position_2, position_3, player_alike1, player_alike2, player_alike3) '
            'VALUES (%s, %s, %s, %s, %s, %s, %s, %s)',
            (user_id, result[0]['player_attributes_id'], result[0]['position_id'], result[1]['position_id'], result[2]['position_id'], player_alike[0], player_alike[1], player_alike[2])
        )

        # Commit changes and close the cursor
        mysql.connection.commit()
        cursor.close()

        return jsonify({'message': 'Attributes updated successfully', 'status': 'success', 'positions': positions, 'alike': player_alike}), 200

    except Exception as e:
        return jsonify({'message': f'Error attributes: {str(e)}'}), 500


def infer(user_skills, players_data):
    """
    Memperkirakan kemampuan pemain berdasarkan model prediksi yang telah dilatih sebelumnya.

    Parameters:
    - user_skills (pd.Series): Pandas Series berisi atribut kemampuan pemain input.
    - players_data (pd.DataFrame): DataFrame berisi data pemain lengkap termasuk atribut kemampuan dan posisi.

    Returns:
    - dict: Kamus berisi prediksi kemampuan pemain untuk setiap posisi dan daftar pemain yang serupa.
    """

    # Daftar atribut untuk setiap model
    atribut_model_1 = [
      'movement_sprint_speed', 'movement_acceleration', 'mentality_positioning', 'mentality_interceptions',
      'mentality_aggression', 'attacking_finishing', 'power_shot_power', 'power_long_shots',
      'attacking_volleys', 'mentality_penalties', 'mentality_vision', 'attacking_crossing',
      'skill_fk_accuracy', 'attacking_short_passing', 'skill_long_passing', 'skill_curve',
      'movement_agility', 'movement_balance', 'movement_reactions', 'skill_ball_control',
      'skill_dribbling', 'mentality_composure', 'attacking_heading_accuracy', 'defending_marking_awareness',
      'defending_standing_tackle', 'defending_sliding_tackle', 'power_jumping', 'power_stamina', 'power_strength'
    ]

    atribut_model_2 = [
      'movement_sprint_speed', 'mentality_positioning', 'mentality_interceptions', 'mentality_aggression',
      'attacking_finishing', 'power_shot_power', 'power_long_shots', 'attacking_volleys',
      'mentality_penalties', 'mentality_vision', 'attacking_crossing', 'skill_fk_accuracy',
      'attacking_short_passing', 'skill_long_passing', 'skill_curve',
      'movement_agility', 'movement_balance', 'movement_reactions',
      'skill_ball_control', 'skill_dribbling', 'mentality_composure',
      'attacking_heading_accuracy', 'defending_marking_awareness',
      'defending_standing_tackle', 'defending_sliding_tackle',
      'power_jumping', 'power_stamina', 'power_strength'
    ]

    atribut_model_3 = [
      'movement_sprint_speed', 'movement_acceleration', 'mentality_positioning',
      'mentality_interceptions', 'mentality_aggression', 'attacking_finishing',
      'power_shot_power', 'power_long_shots', 'attacking_volleys', 'mentality_penalties',
      'mentality_vision', 'attacking_crossing', 'skill_fk_accuracy', 'attacking_short_passing',
      'skill_long_passing', 'skill_curve', 'movement_agility', 'movement_balance',
      'movement_reactions', 'skill_ball_control', 'skill_dribbling', 'mentality_composure',
      'attacking_heading_accuracy', 'defending_marking_awareness', 'defending_standing_tackle',
      'defending_sliding_tackle', 'power_jumping', 'power_stamina'
    ]

    # Load model
    loaded_model_1 = pickle.load(open('model_pertama.pkl', 'rb'))
    loaded_model_2 = pickle.load(open('model_kedua.pkl', 'rb'))
    loaded_model_3 = pickle.load(open('model_ketiga.pkl', 'rb'))

    # Melakukan prediksi menggunakan setiap model
    predictions_1 = loaded_model_1.predict(user_skills[atribut_model_1].values.reshape(1, -1))
    predictions_2 = loaded_model_2.predict(user_skills[atribut_model_2].values.reshape(1, -1))
    predictions_3 = loaded_model_3.predict(user_skills[atribut_model_3].values.reshape(1, -1))

   
    # Simpan prediksi ke dalam dictionary
    skill_pred = {
        'rwb': predictions_1[0][0], 'lwb': predictions_1[0][1], 'rb': predictions_1[0][2],
        'lb': predictions_1[0][3], 'cdm': predictions_1[0][4], 'lw': predictions_1[0][5],
        'rw': predictions_1[0][6], 'st': predictions_1[0][7], 'cb': predictions_2[0], 
        'lm': predictions_3[0][0], 'rm': predictions_3[0][1], 'cf': predictions_3[0][2],
    }
    # Load players data
    players_data = pd.read_pickle('players_data.pkl')
    
    # Cari pemain serupa berdasarkan prediksi kemampuan
    players_alike = find_top_min_variance_rows(skill_pred, players_data, top_n=3)
    # Tambahkan informasi pemain serupa ke dalam dictionary prediksi
    skill_pred['similar_players'] = players_alike.tolist()

    return skill_pred

def find_top_min_variance_rows(input_dict, dataframe, top_n=3, min_international_reputation=3):
    """
    Mencari baris dengan varians paling rendah antara posisi pemain dalam input dan posisi pemain dalam dataframe.
    
    Parameters:
    - input_dict (dict): Dict yang berisi posisi pemain input dengan nama posisi sebagai kunci dan nilai numerik sebagai nilai.
    - dataframe (pd.DataFrame): DataFrame yang berisi data pemain dengan kolom-kolom termasuk 'international_reputation' dan posisi pemain.
    - top_n (int): Jumlah baris teratas dengan varians paling rendah yang ingin diambil. Default: 3.
    - min_international_reputation (int): Nilai reputasi internasional minimum yang dibutuhkan untuk mempertimbangkan pemain. Default: 4.
    
    Returns:
    - pd.Series: Seri berisi nama-nama pemain dengan varians paling rendah untuk posisi yang diberikan.
                Jika tidak ada pemain yang memenuhi kriteria, kembalikan DataFrame kosong.
    """
    input_values = np.array(list(input_dict.values()))

    filtered_dataframe = dataframe[dataframe['international_reputation'] >= min_international_reputation]

    if filtered_dataframe.empty:
        return pd.DataFrame()
    

    positions = filtered_dataframe[['rwb', 'lwb', 'rb', 'lb', 'cb', 'cdm', 'lm', 'rm', 'lw', 'rw', 'cf', 'st']]

    # Minimalisasi varians antara input dan players_data
    variances = positions.apply(lambda row: np.var(row.values - input_values), axis=1)

    # Cari varians paling minimum
    top_indices = variances.nsmallest(top_n).index

    # Cari top N varians paling minimum
    top_rows = filtered_dataframe.loc[top_indices]

    return top_rows['long_name']


if __name__ == '__main__':
    app.run(debug=True)
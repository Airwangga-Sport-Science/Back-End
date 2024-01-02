from flask import Flask, request, jsonify
from flask_mysqldb import MySQL
import bcrypt
import os
import datetime
import jwt
from flask_cors import CORS, cross_origin

# Flask app settings
app = Flask(__name__)

# Enable CORS
cors = CORS(app, resources={r"/*": {"origins": "*"}})
app.config['CORS_HEADERS'] = 'Content-Type'

# take environment variables from .env.

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
            token = jwt.encode(payload={'user_id': user['id'], 'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=30)},
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

@app.route('/register', methods=['POST'])
def register():
    username = request.json['username']
    password = request.json['password']
    role = request.json['role']
    name = request.json['name']
    email = request.json['email']
    phone = request.json['phone']
    weight = request.json['weight']
    height = request.json['height']
    
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM users WHERE username=%s', (username,))
    user = cursor.fetchone()

    if user:
        return jsonify({'message': 'User already exists'}), 409

    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    hashed_pass = hashed_password.decode('utf-8')
    cursor.execute('INSERT INTO users (username, password, role, name, email, phone) VALUES (%s, %s, %s, %s, %s, %s)', (username, hashed_pass, role, name, email, phone))
    mysql.connection.commit()

    if role == "1":
        cursor.execute('SELECT * FROM users WHERE username=%s', (username,))
        user = cursor.fetchone()
        user_id = user['id']
        cursor.execute('INSERT INTO players (user_id, weight, height) VALUES (%s, %s, %s)', (user_id, weight, height))
        mysql.connection.commit()

        cursor.execute('INSERT INTO player_attributes (user_id) VALUES (%s)', (user_id,))
        mysql.connection.commit()

    return jsonify({'message': 'User created successfully'})

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
    cursor = mysql.connection.cursor() # get the cursor from the connection
    title = request.json['title']
    body = request.json['body']
    steps = request.json['steps']
    thumbnail = request.json['thumbnail']
    user_id = request.json['user_id']
    create_date = datetime.datetime.now()
    cursor.execute('INSERT INTO articles (title, body, steps, thumbnail, create_date, user_id) VALUES (%s, %s, %s, %s, %s, %s)', (title, body, steps, thumbnail, create_date, user_id))
    mysql.connection.commit()
    return jsonify({'message': 'Article created successfully'})

@app.route('/articles/<int:id>', methods=['GET'])
def display_article(id):
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT articles.id, articles.title, articles.body, articles.steps, articles.thumbnail, GROUP_CONCAT(positions.name) AS position_names FROM articles LEFT JOIN article_positions ON articles.id = article_positions.article_id LEFT JOIN positions ON article_positions.position_id = positions.id WHERE articles.id=%s GROUP BY articles.id', (id,))


    article = cursor.fetchone()
    return jsonify({'message': 'Article retrieved successfully','status': 'success', 'data': article})

@app.route('/articles/<int:id>', methods=['PUT'])
def update_article(id):
    cursor = mysql.connection.cursor() # get the cursor from the connection
    title = request.json['title']
    body = request.json['body']
    steps = request.json['steps']
    thumbnail = request.json['thumbnail']
    create_date = datetime.datetime.now()
    cursor.execute('UPDATE articles SET title=%s, body=%s, steps=%s, thumbnail=%s, create_date=%s WHERE id=%s', (title, body, steps, thumbnail, create_date, id))
    mysql.connection.commit()
    return jsonify({'message': 'Article updated successfully'})

@app.route('/articles/<int:id>', methods=['DELETE'])
def delete_article(id):
    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('DELETE FROM articles WHERE id=%s', (id,))
    mysql.connection.commit()
    return jsonify({'message': 'Article deleted successfully'})

@app.route('/player', methods=['GET'])
def get_player():
    decoded = check_token()

    if decoded is None:
        return jsonify({'message': 'Authentication failed'}), 401
    
    id = decoded['user_id']

    cursor = mysql.connection.cursor() # get the cursor from the connection
    cursor.execute('SELECT * FROM players LEFT JOIN player_positions ON players.user_id = player_positions.user_id LEFT JOIN users ON players.user_id = users.id WHERE players.user_id = %s', (id,))
    player = cursor.fetchone()

    cursor2 = mysql.connection.cursor() # get the cursor from the connection
    cursor2.execute('SELECT corners, crossing, dribbling, finishing, first_touch, '
        'free_kick_taking, heading, long_shots, passing, tackling, technique, '
        'concentration, vision, decision, determination, position_1, teamwork, '
        'balance, natural_fitness, pace, stamina, strength, left_foot, right_foot '
        'FROM player_attributes WHERE user_id = %s', (id,))
    attribute = cursor2.fetchone()

    cursor3 = mysql.connection.cursor() # get the cursor from the connection
    cursor3.execute('SELECT * FROM player_positions LEFT JOIN article_positions ON player_positions.position_id = article_positions.position_id LEFT JOIN articles ON article_positions.article_id = articles.id WHERE player_positions.user_id = %s ORDER BY articles.create_date', (id,))
    article = cursor3.fetchall()

    return jsonify({'message': 'Player retrieved successfully', 'data': {'player': player, 'attribute': attribute, 'article': article}, 'status': 'success'}), 200
    
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

        # Update the attributes in the database
        cursor.execute('UPDATE player_attributes SET '
                       'corners=%s, crossing=%s, dribbling=%s, finishing=%s, first_touch=%s, '
                       'free_kick_taking=%s, heading=%s, long_shots=%s, passing=%s, tackling=%s, '
                       'technique=%s, concentration=%s, vision=%s, decision=%s, determination=%s, '
                       'position_1=%s, teamwork=%s, balance=%s, natural_fitness=%s, pace=%s, '
                       'stamina=%s, strength=%s, left_foot=%s, right_foot=%s '
                       'WHERE user_id=%s',
                       (new_attributes['corners'], new_attributes['crossing'], new_attributes['dribbling'],
                        new_attributes['finishing'], new_attributes['first_touch'], new_attributes['free_kick_taking'],
                        new_attributes['heading'], new_attributes['long_shots'], new_attributes['passing'],
                        new_attributes['tackling'], new_attributes['technique'], new_attributes['concentration'],
                        new_attributes['vision'], new_attributes['decision'], new_attributes['determination'],
                        new_attributes['position_1'], new_attributes['teamwork'], new_attributes['balance'],
                        new_attributes['natural_fitness'], new_attributes['pace'], new_attributes['stamina'],
                        new_attributes['strength'], new_attributes['left_foot'], new_attributes['right_foot'],
                        user_id))

        mysql.connection.commit()

        return jsonify({'message': 'Attributes updated successfully', 'status': 'success'}), 200
    except Exception as e:
        return jsonify({'message': f'Error updating attributes: {str(e)}'}), 500



if __name__ == '__main__':
    app.run(debug=True)
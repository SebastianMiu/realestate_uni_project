from flask import Flask, render_template, request, redirect, url_for, session
from flask_mysqldb import MySQL
 
 
app = Flask(__name__)
 
 
app.config['MYSQL_HOST'] = '127.0.0.1'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'INSERT_PASSWORD_HERE'
app.config['MYSQL_DB'] = 'AgentieImobiliara'

 
 
mysql = MySQL(app)





print(mysql)
@app.route('/')
def index():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM AgentiImobiliari")
    data = cur.fetchall()
    cur.close()
    return render_template('index.html', agents=data)

@app.route('/index2')
def index2():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Proprietari")
    data = cur.fetchall()
    cur.close()
    return render_template('index2.html', proprietari=data)

@app.route('/spec')
def index3():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Specificatii")
    data = cur.fetchall()
    cur.close()
    return render_template('spec.html', specificatii=data)


@app.route('/proprietati')
def proprietati():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Proprietati")
    data = cur.fetchall()
    cur.close()
    return render_template('proprietati.html', proprietati=data)

@app.route('/detalii')
def detalii():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM DetaliiProprietate")
    data = cur.fetchall()
    cur.close()
    return render_template('detalii.html', imobile=data)


# add proprietati
@app.route('/proprietati/add', methods=['POST'])
def add_proprietate():
    if request.method == 'POST':
       
        idagent = request.form['ID_agent']
        sector = request.form['Sector']
        camere = request.form['Nr_Camere']
        
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO Proprietati (ID_agent, Sector, Nr_Camere) VALUES (%s, %s, %s)",
                    (idagent, sector, camere))
        
        
        
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('proprietati'))


 # add agenti
@app.route('/add', methods=['POST'])
def add_agent():
    if request.method == 'POST':
        nume = request.form['Nume_agent']
        nrproprietati = request.form['Nr_proprietati']
        telefon = request.form['Nr_telefon']
        email = request.form['Email']
        cur = mysql.connection.cursor()
        cur.execute("INSERT INTO AgentiImobiliari (Nume_agent, Nr_proprietati, Nr_telefon, Email) VALUES (%s, %s, %s, %s)",
                    (nume, nrproprietati, telefon, email))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('index'))

 # update agenti
@app.route('/update', methods=['POST'])
def update_agent():
    if request.method == 'POST':
        idagent = request.form['ID_agent']
        nume = request.form['Nume_agent']
        nrproprietati = request.form['Nr_proprietati']
        telefon = request.form['Nr_telefon']
        email = request.form['Email']
        cur = mysql.connection.cursor()
        cur.execute("""UPDATE AgentiImobiliari
            SET Nume_agent = %s, Nr_proprietati = %s, Nr_telefon = %s, Email = %s
            WHERE ID_agent = %s""", (nume, nrproprietati, telefon, email, idagent))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('index'))

# delete agent
@app.route('/delete/<string:id>', methods=['POST', 'DELETE'])
def delete_agent(id):
     if request.method == 'POST' or request.method == 'DELETE':
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM AgentiImobiliari WHERE ID_agent = %s", (id,))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('index'))
    

@app.route('/index2')
def show_index2():
    return redirect(url_for('index2'))


@app.route('/spec')
def show_index3():
    return redirect(url_for('spec'))


# 5 interogari
@app.route('/index2/negocieri', methods=['POST']) 
def show_negocieri():
    cur = mysql.connection.cursor()
    input = request.form['Negociere']
    cur.execute("SELECT * FROM Proprietari WHERE Negociere = %s", [input])
    data = cur.fetchall()
    cur.close()
    return render_template('index2.html', proprietari2=data)

@app.route('/index2/agent', methods=['POST']) 
def propdupaagent():
    cur = mysql.connection.cursor()
    input = request.form['ID_agent']
    cur.execute("SELECT * FROM Proprietari WHERE ID_agent = %s", [input])
    data = cur.fetchall()
    cur.close()
    return render_template('index2.html', proprietari2=data)


@app.route('/index2/alfa', methods = ['POST']) 
def ordonarealfabetic():
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM Proprietari ORDER BY Nume_proprietar")
    data = cur.fetchall()
    cur.close()
    return render_template('index2.html', proprietari2=data)


@app.route('/detalii/ordpret', methods=['POST']) 
def ordpret():
    cur = mysql.connection.cursor()
    inputt = request.form['Pret']
    cur.execute("SELECT * FROM DetaliiProprietate WHERE Pret < %s", [inputt])
    data = cur.fetchall()
    cur.close()
    return render_template('detalii.html', imobil2=data)

@app.route('/proprietati/camere', methods = ['POST']) 
def numarcamere():
    cur = mysql.connection.cursor()
    inputcamere = request.form['Nr_Camere']
    cur.execute("SELECT * FROM Proprietati WHERE Nr_Camere = %s", [inputcamere])
    data = cur.fetchall()
    cur.close()
    return render_template('proprietati.html', proprietati2=data)

# sub-interogare - media pretului 
@app.route('/detalii/subint', methods = ['POST']) 
def subinterogarea():
    cur = mysql.connection.cursor()
    input = request.form['Serviciu']
    cur.execute("SELECT AVG(Pret) FROM (SELECT Pret FROM DetaliiProprietate WHERE Serviciu = %s) AS subquery", [input])
    data = cur.fetchone()
    cur.close()
    return render_template('detalii.html', medie=data)




# functie agregat COUNT(*)
@app.route('/spec', methods=['POST'])
def counter():
    cur = mysql.connection.cursor()
    serv = request.form['Serviciu']
    cur.execute("SELECT COUNT(*) FROM Specificatii WHERE Serviciu = %s", [serv])
    count = cur.fetchone()[0]
    cur.close()
    return render_template('spec.html', count=count)


# functii scalare DATEDIFF() si CURDATE()
@app.route('/detalii', methods = ['POST'])
def verifica_valabilitate():
    cur = mysql.connection.cursor()
    id_prop = request.form['ID_proprietate']
    cur.execute("SELECT DATEDIFF(Valabilitate_incepand_cu, CURDATE()) FROM DetaliiProprietate WHERE ID_proprietate = %s", [id_prop])
    output = cur.fetchone()[0]
    cur.close()
    return render_template('detalii.html', output=output)
    
    
if __name__ == '__main__':
    app.run(debug=True)

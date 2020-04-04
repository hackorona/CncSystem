import pyodbc
import pandas as pd
import json



class MsSqlClass():
	def conect(self, server, db):
		conn = pyodbc.connect('Driver={SQL Server};Server=' + server + ';Database=' + db + ';Trusted_Connection=yes;')
		self.cursor = conn.cursor()
		self.cursor.execute("SELECT @@version;") 
		row = self.cursor.fetchone() 
		while row: 
			print(row[0])
			row = self.cursor.fetchone()
		return(self.cursor)


	def selectAll(self, table):
		self.cursor.execute("SELECT * FROM [corona].[dbo].[" + table + "]")
		for row in self.cursor:
			print(row)

	
	def addUser(self, firstName, lastName, idNum, username, pwdHash, pwdWord):

		params = ('{"firstname":"' + firstName + '",'
				'"lastname":"' + lastName + '",'
				'"identitynumber":" ' + idNum + '",'
				'"username":"' + username + '",'
				'"passwordhash":"' + pwdHash + '",'
				'"passwordsalt":"' + pwdWord + '"}')
		
		
		sql = "EXEC dbo.stp_AddUser @json = '" + params + "'"
		self.cursor.execute(sql)
		self.cursor.commit()

	def getFreeSpaces(self, sevirity):
		res = []
        params = ('{"severity":"' + sevirity + '"}')
		sql = "EXEC stp_GetMedicalCentersNumOfPatients @json = '" + params + "'"
		self.cursor.execute(sql)
		for row in self.cursor:
			res.append(row)
		return res

if __name__ == '__main__':
	newDbConn = MsSqlClass()
	newDbConn.conect('LAPTOP-5NIM0VP7\SQLEXPRESS', 'newDb')
	newDbConn.addUser('a', 'b', '204835935', 'c', 'ff', 'bs')
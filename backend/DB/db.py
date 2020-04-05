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
	#
	def addUser(self, firstName, lastName, idNum, username, pwdHash, pwdWord , medicalName , organizatioName ):

		params = ('{"firstname":"' + firstName + '",'
					'"lastname":"' + lastName + '",'
					'"identitynumber":" ' + idNum + '",'
					'"username":"' + username + '",'
					'"passwordhash":"' + pwdHash + '",'
					'"passwordsalt":"' + pwdWord + '"}'
					'"medicalcenterid":"' + str(medicalName) + '",'
					'"organizationid":"' + str(organizatioName) + '"}')

		# params_out = ('{"userid":"' + "1" + '",'
		# 					'"errorno":"' + "2" + '"}')

		#sql = 'exec [my_database].[dbo].[my_table](?, ?, ?, ?, ?, ?, ?, ?)'
		#sql = "EXEC dbo.stp_AddUser @in_json  = '" + params + "' , @out_json = '" + params_out + "' "
		sql = "EXEC dbo.stp_AddUser @in_json  = '" + params + "'"
		self.cursor.execute(sql)
		self.cursor.commit()
		try:
			pass
			# for row in self.cursor.fetchone():
			# 	print("row  :" , row)
		except:
			print("error")




# def getFreeSpaces(self, sevirity):
	# 	res = []
    #     params = ('{"severity":"' + sevirity + '"}')
	# 	sql = "EXEC stp_GetMedicalCentersNumOfPatients @json = '" + params + "'"
	# 	self.cursor.execute(sql)
	# 	for row in self.cursor:
	# 		res.append(row)
	# 	return res




if __name__ == '__main__':
	newDbConn = MsSqlClass()
	newDbConn.conect('DESKTOP-UQ5HGJD\MSSQYARDEN', 'corona_care')
	newDbConn.addUser('riki', 'w', 'wt', 'abcs', 'c0006', '122222d' , 1 ,2)
	print("heyyyyy")
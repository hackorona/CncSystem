import pyodbc
import pandas as pd
import json



class MsSqlClass():

	numOfCloseHospitalToShow = 2

	def conect(self, server, db):
		conn = pyodbc.connect('Driver={SQL Server};Server=' + server + ';Database=' + db + ';Trusted_Connection=yes;')
		self.cursor = conn.cursor()
		self.cursor.execute("SELECT @@version;") 
		row = self.cursor.fetchone() 
		while row: 
			print(row[0])
			row = self.cursor.fetchone()
		return(self.cursor)


	
	# position : tuple(long, lat)
	# sevirity : num
	# risk	 : 0 / 1 
	def getClosestMedicalCenters(self, position, sevirity, risk):
		hospitals = self.newDbConn.getFreeSpaces(sevirity)
		resrved = self.getReserved()
		hospitalDistanceDic = {}
		for hospital in hospitals:
			p2 = []
			for f in hospital["geolocation"].split(","): p2.append(float(f))
			hospitalDistanceDic[hospital["medicalcenterdescription"]] = math.sqrt(((position[0]-p2[0])**2)+((position[1]-p2[1])**2))
		dicToSend = {k: v for k, v in sorted(hospitalDistanceDic.items(), key=lambda item: item[1])}
		jsonDic = {}
		for key in dicToSend.keys()[:self.numOfCloseHospitalToShow]:
			jsonDic[key] = dicToSend[key]
		return jsonDic
	
	
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
		
	def addMedicalCenter(self, description, street, number, city, location, medicalType):
		params = ('{"medicalcenterdescription":"' + description + '",'
				'"street":"' + street + '",'
				'"streetnumber":" ' + number + '",'
				'"city":"' + city + '",'
				'"geolocation":"' + location + '",'
				'"medicalcenterstype":"' + medicalType + '"}')
		
		
		sql = "EXEC dbo.stp_AddMedicalCenter  @in_json = '" + params + "'"
		self.cursor.execute(sql)
		self.cursor.commit()

	def strToDic(self, string):
		res = []
		start = string.find("{")
		end = string.find("}")
		while(end > -1):
			res.append(json.loads(string[start:end + 1]))
			string = string[end + 1:]
			start = string.find("{")
			end = string.find("}")
		return res
	
	def getMedicalCenters(self):
		sql = "EXEC dbo.stp_GetMedicalCenters"
		self.cursor.execute(sql)
		res = []
		for row in self.cursor:
			for i in row:
				return(self.strToDic(i[1:-1]))
		return res
	
	
	def getReserved(self):
		sql = "EXEC dbo.stp_GetReservedBeds"
		self.cursor.execute(sql)
		res = []
		for row in self.cursor:
			for i in row:
				dic = json.loads(i[1:-1])
				res.append(dic)
		return res
		
	def getFreeSpaces(self, sevirity):
		res = []
		params = ('{"severity":"' + sevirity + '"}')
		sql = "EXEC dbo.stp_GetMedicalCentersNumOfPatients @in_json = '" + params + "'"
		self.cursor.execute(sql)
		for row in self.cursor:
			res.append(row)
		return res

if __name__ == '__main__':
	newDbConn = MsSqlClass()
	newDbConn.conect('LAPTOP-5NIM0VP7\SQLEXPRESS', 'coronaCareDb')
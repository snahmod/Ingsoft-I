class Brazo:

	def girar(self, sentido, velocidadEnRPM, duracionEnMinutos):
		self.__sentido = sentido
		self.__velocidadEnRPM = velocidadEnRPM
		self.__duracionEnMinutos = duracionEnMinutos
		print("Se giro el brazo")

	def accionar(self):
		print("Se acciono el brazo")

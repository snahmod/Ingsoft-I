class Brazo:

	def girar(self, sentido, velocidadEnRPM, duracionEnMinutos):
		self._sentido = sentido
		self._velocidadEnRPM = velocidadEnRPM
		self._duracionEnMinutos = duracionEnMinutos
		print("Se giro el brazo")

	def accionar(self):
		print("Se acciono el brazo")

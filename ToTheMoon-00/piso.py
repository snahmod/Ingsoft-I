class Piso:

    def __init__(self, duresa, porosidad):
        self.__duresa = duresa
        self.__porosidad = porosidad
    
    def __tipoDePiso(self):
      medicionConjunta = (self.__duresa + self.__porosidad) / 2
      if medicionConjunta < 10:
        return 1
      elif medicionConjunta < 20:
        return 2
      else:
        return 3

    def esDePiedra(self):
    	return self.__tipoDePiso() == 3

    def esDePolvo(self):
    	return self.__tipoDePiso() == 1

    def esIntermedio(self):
      return self.__tipoDePiso() == 2

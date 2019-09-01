class Piso:

    def __init__(self, duresa, porosidad):
        self._duresa = duresa
        self._porosidad = porosidad

    def esDePiedra(self):
    	return False

    def esDePolvo(self):
    	return True

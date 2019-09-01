from brazo import Brazo
from sentido_giro import SentidoGiro

class Robot:

  brazo = Brazo()

  def __init__(self, piso):
    self.piso = piso

  def excavar(self):
    if self.piso.esDePiedra():
      self.brazo.girar(SentidoGiro.agujasDeReloj, 150, 10)
      self.brazo.accionar()
      self.brazo.girar(SentidoGiro.antiAgujasDeReloj, 150, 10)
    elif self.piso.esDePolvo(): 
      self.brazo.girar(SentidoGiro.antiAgujasDeReloj, 100, 10)
      self.brazo.accionar()
      self.brazo.girar(SentidoGiro.antiAgujasDeReloj, 100, 5)
    else:
      self.brazo.girar(SentidoGiro.agujasDeReloj, 150, 5)
      self.brazo.accionar()
      self.brazo.girar(SentidoGiro.antiAgujasDeReloj, 100, 10)

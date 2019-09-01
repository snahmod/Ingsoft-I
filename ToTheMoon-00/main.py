from robot import Robot
from piso import Piso
import sys

def main():
	robot = Robot(Piso(sys.argv[1], sys.argv[2]))
	robot.excavar()

  
if __name__ == "__main__":
  main()
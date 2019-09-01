from robot import Robot
from piso import Piso
import sys

def main():
	robot = Robot(Piso(int(sys.argv[1]), int(sys.argv[2])))
	robot.excavar()

  
if __name__ == "__main__":
  main()
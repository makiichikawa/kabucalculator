import schedule
import sys
from time import sleep

sys.path.append('..')

from lib.batch import batch

schedule.every().day.at('23:15').do(batch)

while True:
  schedule.run_pending()
  sleep(1)

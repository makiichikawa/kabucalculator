import schedule
import sys
from time import sleep

sys.path.append('..')

from lib.batch import batch  # noqa: E402

schedule.every().day.at('16:00').do(batch)

while True:
    schedule.run_pending()
    sleep(1)

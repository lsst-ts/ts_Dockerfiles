import salobj
import SALPY_Test
import asyncio

csc = salobj.test_utils.TestCsc(1, salobj.State.STANDBY)

loop = asyncio.get_event_loop()

try:
    loop.run_forever()
except KeyboardInterrupt as e:
    print('Stopping CSC.')
finally:
    loop.close()

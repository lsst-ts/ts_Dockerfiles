import salobj
import SALPY_Test
import asyncio

csc = salobj.test_utils.TestCsc(1, salobj.State.STANDBY)

loop = asyncio.get_event_loop()
loop.run_forever()

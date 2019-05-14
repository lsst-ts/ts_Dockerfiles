import asyncio
import logging

from lsst.ts import salobj
from lsst.ts.standardscripts.auxtel.integration_tests import DomeTrajectoryMCS


async def main(index):
    script = DomeTrajectoryMCS(index=index)
    script.log.setLevel(logging.INFO)
    script.log.addHandler(logging.StreamHandler())
    print("*** configure")
    config_data = script.cmd_configure.DataType()
    config_data.config = ""
    config_id_data = salobj.CommandIdData(1, config_data)
    await script.do_configure(config_id_data)
    print("*** run")
    await script.do_run(None)
    print("*** done")


if __name__ == "__main__":
    asyncio.get_event_loop().run_until_complete(main(index=1))

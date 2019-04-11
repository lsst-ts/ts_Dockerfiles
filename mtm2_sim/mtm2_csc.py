# This file is part of NOTHING!.
#
# Developed for the LSST.
# This product includes software developed by the LSST Project
# (https://www.lsst.org).
# See the COPYRIGHT file at the top-level directory of this distribution
# for details of code ownership.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

__all__ = ["MTM2Csc"]

import asyncio

from lsst.ts import salobj
import SALPY_MTM2


class MTM2Csc(salobj.BaseCsc):
    def __init__(self, initial_state=salobj.State.STANDBY, initial_simulation_mode=0):
        super().__init__(SALPY_MTM2, index=0, initial_state=initial_state,
                         initial_simulation_mode=initial_simulation_mode)
        self.telemetry_period = 0.05
        self.axialForceMeasured = [0.0] * 72
        self.position = [0.0] * 6
        self.salinfo.manager.setDebugLevel(0)

    def do_applyBendingMode(self, id_data):
        pass
    
    def do_applyForce(self, id_data):
        self.assert_enabled("applyForce")
        print(f"Applying force starting with {id_data.data.forceSetPoint[:6]}.")
        self.axialForceMeasured = [x for x in id_data.data.forceSetPoint]

    def do_moveAxialActuator(self, id_data):
        pass

    def do_positionMirror(self, id_data):
        self.assert_enabled("positionMirror")
        xTilt = id_data.data.xTilt
        yTilt = id_data.data.yTilt
        z = id_data.data.piston
        self.position[2] = z
        self.position[3] = xTilt
        self.position[4] = yTilt
        print(f"Moving M2 to {self.position}.")

    def do_setCorrectionMode(self, id_data):
        pass

    def report_summary_state(self):
        super().report_summary_state()
        if self.summary_state in (salobj.State.DISABLED, salobj.State.ENABLED):
            asyncio.ensure_future(self.telemetry_loop())

    async def telemetry_loop(self):
        while self.summary_state in (salobj.State.DISABLED, salobj.State.ENABLED):
            self.tel_axialForcesMeasured.set_put(axialForceMeasured=self.axialForceMeasured)
            self.tel_mirrorPositionMeasured.set_put(xTilt=self.position[3],
                                                    yTilt=self.position[4],
                                                    piston=self.position[2],
                                                    xPosition=self.position[0],
                                                    yPosition=self.position[1],
                                                    thetaZPosition=self.position[5])
            await asyncio.sleep(self.telemetry_period)

    async def _heartbeat_loop(self):
        """Output heartbeat at regular intervals.
        """
        while True:
            try:
                await asyncio.sleep(self.heartbeat_interval)
#                self.evt_heartbeat.put(self.evt_heartbeat.DataType())
            except asyncio.CancelledError:
                break
            except Exception as e:
                print(f"Heartbeat output failed: {e}", file=sys.stderr)


if __name__ == '__main__':
    csc = MTM2Csc(initial_state=salobj.State.ENABLED)
    asyncio.get_event_loop().run_until_complete(csc.done_task)

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

__all__ = ["MTCameraHexapodCsc"]

import asyncio

from lsst.ts import salobj
import SALPY_Hexapod


class MTCameraHexapodCsc(salobj.BaseCsc):
    def __init__(self, initial_state=salobj.State.STANDBY, initial_simulation_mode=0):
        super().__init__(SALPY_Hexapod, index=1, initial_state=initial_state,
                         initial_simulation_mode=initial_simulation_mode)
        self.telemetry_period = 0.05
        self.position = [0.0] * 6
        self.salinfo.manager.setDebugLevel(0)

    def do_configureAcceleration(self, id_data):
        pass

    def do_configureAzimuthRawLUT(self, id_data):
        pass

    def do_configureElevationRawLUT(self, id_data):
        pass

    def do_configureLimits(self, id_data):
        pass

    def do_configureTemperatureRawLUT(self, id_data):
        pass

    def do_configureVelocity(self, id_data):
        pass

    def do_move(self, id_data):
        pass

    def do_moveLUT(self, id_data):
        pass

    def do_offset(self, id_data):
        self.assert_enabled("offset")
        self.position = [id_data.data.x, id_data.data.y, id_data.data.z, id_data.data.u, id_data.data.v, id_data.data.w]
        print(f"New position is now {self.position}.")

    def do_pivot(self, id_data):
        pass

    def do_positionSet(self, id_data):
        pass

    def do_test(self, id_data):
        pass

    def do_clearError(self, id_data):
        pass

    def report_summary_state(self):
        super().report_summary_state()
        if self.summary_state in (salobj.State.DISABLED, salobj.State.ENABLED):
            asyncio.ensure_future(self.telemetry_loop())

    async def telemetry_loop(self):
        while self.summary_state in (salobj.State.DISABLED, salobj.State.ENABLED):
            self.tel_Application.set_put(Demand=self.position, Error=[0.0]*6, Position=self.position)
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
    csc = MTCameraHexapodCsc(initial_state=salobj.State.ENABLED)
    asyncio.get_event_loop().run_until_complete(csc.done_task)

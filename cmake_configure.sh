cmake \
	-B build_evercade \
	-DRETRO_DISABLE_PLUS=off \
	-DRETRO_USE_HW_RENDER=on \
	-DRETRO_NETWORKING=off \
	-DRETRO_MOD_LOADER=off \
	-DPLATFORM=Evercade \
	-DCMAKE_TOOLCHAIN_FILE=${EVERSDK}/toolchain/armhf.cmake

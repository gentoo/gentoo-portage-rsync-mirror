# plugin-config-addon for softdevice
plugin_pre_vdr_start() {
	if [ -n "${SOFTDEVICE_VIDEO_OUT}" ]; then
		add_plugin_param "-vo ${SOFTDEVICE_VIDEO_OUT}:${SOFTDEVICE_VIDEO_OUT_SUBOPTS}"
	fi

	if [ -n "${SOFTDEVICE_AUDIO_OUT}" ]; then
		add_plugin_param "-ao ${SOFTDEVICE_AUDIO_OUT}:${SOFTDEVICE_AUDIO_OUT_SUBOPTS}"
	fi
}

# plugin-startup-skript for bitstreamout-plugin

plugin_pre_vdr_start() {
	if [ -n "${BITSTREAMOUT_MUTE}" ]; then
		local mydir=/usr/share/vdr/bitstreamout

		if [ -x ${mydir}/mute_${BITSTREAMOUT_MUTE}.sh ]; then
			BITSTREAMOUT_MUTE=${mydir}/mute_${BITSTREAMOUT_MUTE}.sh
		fi


		if [ -x "${BITSTREAMOUT_MUTE}" ]; then
			add_plugin_param "--mute=${BITSTREAMOUT_MUTE}"
		else
			einfo "  bitstreamout: ${BITSTREAMOUT_MUTE} is not executable"
		fi
	fi
}


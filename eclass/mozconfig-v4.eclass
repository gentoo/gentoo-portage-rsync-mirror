# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mozconfig-v4.eclass,v 1.2 2014/07/29 20:43:02 axs Exp $
#
# mozconfig-v4.eclass: the new mozilla.eclass

inherit multilib flag-o-matic mozcoreconf-2

# use-flags common among all mozilla ebuilds
IUSE="dbus debug startup-notification"

RDEPEND=">=app-text/hunspell-1.2
	dev-libs/expat
	>=dev-libs/libevent-1.4.7
	>=x11-libs/cairo-1.12[X]
	>=x11-libs/gtk+-2.10:2
	>=x11-libs/pango-1.22.0
	media-libs/alsa-lib
	virtual/freedesktop-icon-theme
	dbus? ( >=dev-libs/dbus-glib-0.72 )
	startup-notification? ( >=x11-libs/startup-notification-0.8 )
	wifi? ( >=sys-apps/dbus-0.60
		>=dev-libs/dbus-glib-0.72
		net-wireless/wireless-tools )
	>=dev-libs/glib-2.26:2"

DEPEND="app-arch/zip
	app-arch/unzip
	${RDEPEND}"

mozconfig_config() {

	mozconfig_annotate '' --enable-default-toolkit=cairo-gtk2

	if has bindist ${IUSE}; then
		mozconfig_use_enable !bindist official-branding
		if [[ ${PN} == firefox ]] && use bindist ; then
			mozconfig_annotate '' --with-branding=browser/branding/aurora
		fi
	fi

	mozconfig_use_enable debug
	mozconfig_use_enable debug tests

	if ! use debug ; then
		mozconfig_annotate 'disabled by Gentoo' --disable-debug-symbols
	fi

	mozconfig_use_enable startup-notification

	if has wifi ${IUSE} ; then
		# wifi pulls in dbus so manage both here
		mozconfig_use_enable wifi necko-wifi
		if use wifi && ! use dbus; then
			echo "Enabling dbus support due to wifi request"
			mozconfig_annotate 'dbus required by necko-wifi' --enable-dbus
		else
			mozconfig_use_enable dbus
		fi
	else
		mozconfig_use_enable dbus
		mozconfig_annotate 'disabled' --disable-necko-wifi
	fi

	mozconfig_annotate 'required' --enable-ogg
	mozconfig_annotate 'required' --enable-wave

	if has jit ${IUSE}; then
		mozconfig_use_enable jit ion
		mozconfig_use_enable jit yarr-jit
	fi

	# These are enabled by default in all mozilla applications
	mozconfig_annotate '' --with-system-nspr --with-nspr-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --with-system-nss --with-nss-prefix="${EPREFIX}"/usr
	mozconfig_annotate '' --x-includes="${EPREFIX}"/usr/include --x-libraries="${EPREFIX}"/usr/$(get_libdir)
	mozconfig_annotate '' --with-system-libevent="${EPREFIX}"/usr
	mozconfig_annotate '' --enable-system-hunspell
	mozconfig_annotate '' --disable-gnomevfs
	mozconfig_annotate '' --disable-gnomeui
	mozconfig_annotate '' --enable-gio
	mozconfig_annotate '' --disable-crashreporter
}

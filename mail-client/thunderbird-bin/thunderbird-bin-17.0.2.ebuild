# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/thunderbird-bin/thunderbird-bin-17.0.2.ebuild,v 1.1 2013/01/11 05:39:58 jdhore Exp $

EAPI="4"
MOZ_ESR="1"

# Can be updated using scripts/get_langs.sh from mozilla overlay
MOZ_LANGS=(ar ast be bg bn-BD br ca cs da de el en en-GB en-US es-AR es-ES et eu
fi fr fy-NL ga-IE gd gl he hu id is it ja ko lt nb-NO nl nn-NO pa-IN pl pt-BR
pt-PT rm ro ru si sk sl sq sr sv-SE ta-LK tr uk vi zh-CN zh-TW)

# Convert the ebuild version to the upstream mozilla version, used by
MOZ_PN="${PN/-bin}"
MOZ_PV="${PV/_beta/b}"
MOZ_PV="${MOZ_PV/_rc/rc}"

if [[ ${MOZ_ESR} == 1 ]]; then
	# ESR releases have slightly version numbers
	MOZ_PV="${MOZ_PV}esr"
fi

MOZ_P="${MOZ_PN}-${MOZ_PV}"

# Upstream ftp release URI that's used by mozlinguas.eclass
# We don't use the http mirror because it deletes old tarballs.
MOZ_FTP_URI="ftp://ftp.mozilla.org/pub/mozilla.org/${MOZ_PN}/releases/"

inherit eutils multilib pax-utils fdo-mime gnome2-utils mozlinguas nsplugins

DESCRIPTION="Thunderbird Mail Client"
SRC_URI="${SRC_URI}
	amd64? ( ${MOZ_FTP_URI}/${MOZ_PV}/linux-x86_64/en-US/${MOZ_P}.tar.bz2 -> ${PN}_x86_64-${PV}.tar.bz2 )
	x86? ( ${MOZ_FTP_URI}/${MOZ_PV}/linux-i686/en-US/${MOZ_P}.tar.bz2 -> ${PN}_i686-${PV}.tar.bz2 )"
HOMEPAGE="http://www.mozilla.com/thunderbird"
RESTRICT="strip mirror binchecks"

KEYWORDS="-* ~amd64 ~x86"
SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="+crashreporter"

DEPEND="app-arch/unzip"
RDEPEND="virtual/freedesktop-icon-theme
	x11-libs/libXrender
	x11-libs/libXt
	x11-libs/libXmu
	>=x11-libs/gtk+-2.2:2
	>=media-libs/alsa-lib-1.0.16
	crashreporter? ( net-misc/curl )
	!net-libs/libproxy[spidermonkey]"

S="${WORKDIR}/${MOZ_PN}"

src_unpack() {
	unpack ${A}

	# Unpack language packs
	mozlinguas_src_unpack
}

src_install() {
	declare MOZILLA_FIVE_HOME="/opt/${MOZ_PN}"

	# Install thunderbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${D}"${MOZILLA_FIVE_HOME}

	# Install language packs
	mozlinguas_src_install

	# Create /usr/bin/thunderbird-bin
	dodir /usr/bin/
	cat <<EOF >"${D}"/usr/bin/${PN}
#!/bin/sh
unset LD_PRELOAD
LD_LIBRARY_PATH="${MOZILLA_FIVE_HOME}"
exec ${MOZILLA_FIVE_HOME}/thunderbird "\$@"
EOF
	fperms 0755 /usr/bin/${PN}

	# Install icon and .desktop for menu entry
	doicon "${FILESDIR}"/icon/${PN}-icon.png
	domenu "${FILESDIR}"/icon/${PN}.desktop

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	doins "${FILESDIR}"/10${PN}

	# Enable very specific settings for thunderbird-3
	cp "${FILESDIR}"/thunderbird-gentoo-default-prefs.js \
		"${D}/${MOZILLA_FIVE_HOME}/defaults/pref/all-gentoo.js" || \
		die "failed to cp thunderbird-gentoo-default-prefs.js"

	# Plugins dir
	share_plugins_dir

	pax-mark mr "${ED}"/${MOZILLA_FIVE_HOME}/{thunderbird-bin,thunderbird,plugin-container}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

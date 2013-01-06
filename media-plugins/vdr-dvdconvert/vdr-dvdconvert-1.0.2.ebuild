# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-dvdconvert/vdr-dvdconvert-1.0.2.ebuild,v 1.4 2011/01/28 19:04:29 hd_brummy Exp $

EAPI="3"

inherit vdr-plugin eutils

DESCRIPTION="VDR plugin: for exec dvd2vdr & dvd2dvd scripts"
HOMEPAGE="http://home.lausitz.net/lini/vdr/"
SRC_URI="http://home.lausitz.net/lini/vdr/${P}.tar.bz2
		projectx? ( http://dev.gentoo.org/~hd_brummy/distfiles/px-files-20070104.tar.bz2 )"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE="projectx"

RDEPEND="media-video/vdr
	>=media-video/dvdauthor-0.6.10
	>=media-video/vobcopy-1.0.0
	>=media-video/m2vrequantizer-0.0.2_pre20060306
	media-video/transcode
	media-video/tcmplex-panteltje
	media-libs/a52dec
	media-sound/lame
	media-sound/toolame
	projectx? ( media-video/projectx )"

PATCHES=( "${FILESDIR}/${P}-gentoo.diff"
		"${FILESDIR}/${P}-vobcopy-perm.diff" )

pkg_setup() {
	vdr-plugin_pkg_setup

	if has_version "<=media-video/dvdconvert-1.0.0" ; then
		echo
		eerror "Found existing media-video/dvdconvert install"
		elog "Please unmerge media-video/dvdconvert at first"
		elog "and cleanup all old config files of media-video/dvdconvert"
		die "Found existing media-video/dvdconvert install"
	fi
}

src_install() {
	vdr-plugin_src_install

	insinto /usr/share/vdr/dvdconvert
	doins "${S}"/scripts/dvdconvert.{conf,conf.save}

	use projectx && insinto /usr/share/vdr/dvdconvert/pX
	use projectx && doins "${WORKDIR}/px-files/*"

	exeinto /usr/share/vdr/dvdconvert/bin
	doexe "${S}/scripts/*.sh"

	insinto /etc/vdr/commands
	doins "${FILESDIR}/commands.dvdconvert.conf"

	insinto /etc/vdr/plugins/dvdconvert
	newins "${FILESDIR}/dvd2dvdr-${PV}.conf" dvdconvert

	insinto	/etc/logrotate.d
	newins	"${FILESDIR}"/dvdlogrotate dvdconvert

	diropts -ovdr -gvdr
	keepdir	/var/log/dvdconvert
	keepdir /var/vdr/video/.dvdconvert

	dodoc README-PLUGIN
}

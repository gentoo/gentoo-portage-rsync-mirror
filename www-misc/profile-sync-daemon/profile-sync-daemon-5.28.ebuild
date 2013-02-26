# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/profile-sync-daemon/profile-sync-daemon-5.28.ebuild,v 1.1 2013/02/26 00:43:14 hasufell Exp $

EAPI=5

inherit eutils vcs-snapshot

DESCRIPTION="Symlinks and syncs browser profile dirs to RAM"
HOMEPAGE="https://wiki.archlinux.org/index.php/Profile-sync-daemon"
SRC_URI="https://github.com/graysky2/profile-sync-daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cron"

RDEPEND="
	app-shells/bash
	net-misc/rsync
	cron? ( virtual/cron )"

src_compile() {
	emake -f Makefile.gentoo
}

src_install() {
	emake -f Makefile.gentoo DESTDIR="${D}" $(usex cron "install" "install-bin install-doc install-man")
}

pkg_postinst() {
	eerror "IMPORTANT NOTICE!"
	elog "Usage of the \"mozilla\" variable in the BROWSERS array is"
	elog "deprecated starting with profile-sync-daemon v4.02."
	elog "It has been replaced with the \"firefox\" variable."
	elog
	elog "In order to safely upgrade, you must run an unsync to"
	elog "rotate your firefox profile back to disk using verion 3.x"
	elog
	elog "As usual, watch for any changes in the newly provided"
	elog "/etc/conf.d/psd as well and be sure to incorporate them."
}

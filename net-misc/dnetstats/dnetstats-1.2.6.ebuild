# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/dnetstats/dnetstats-1.2.6.ebuild,v 1.6 2013/03/02 23:00:01 hwoarang Exp $

EAPI="2"

inherit eutils qt4-r2

MY_PN="DNetStats"
MY_P="${MY_PN}-v${PV}-release"

DESCRIPTION="Qt4 network monitor utility"
HOMEPAGE="http://qt-apps.org/content/show.php/DNetStats?content=107467"
SRC_URI="http://qt-apps.org/CONTENT/content-files/107467-${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kde gnome"

DEPEND="dev-qt/qtgui:4"
RDEPEND="${DEPEND}
	app-admin/sudo
	kde? ( kde-base/kdesu )
	gnome? ( x11-libs/gksu )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! use kde && ! use gnome; then
		ewarn
		ewarn "You didn't enable nor kde neither gnome use flags."
		ewarn "This means that no sudo GUI frontend will be used hence"
		ewarn "the ${PN} menu entry won't work for normal users."
		ewarn "Use 'sudo ${PN}' to launch the application or emerge ${PN} with"
		ewarn "USE='kde' or USE='gnome' in order to make use of a graphical"
		ewarn "sudo frontend"
		ewarn
	fi
}

src_prepare() {
	# remove old moc_* files
	rm -rf moc_* || die "failed to remove old moc_* files"
}

src_install() {
	local gsudo
	newbin mythread ${PN} || die "newbin failed"
	dodoc ReadMe || die "dodoc failed"
	newicon resource/energy.png ${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} DNetStats ${PN} 'Qt;Network;Dialup'
	# adjust the .desktop file
	use kde && gsudo="kdesu"
	use gnome && gsudo="gksu"
	if [[ -n ${gsudo} ]]; then
		sed -i "/^Exec/s:${PN}:${gsudo} ${PN}:" \
			${D}/usr/share/applications/"${PN}"-"${PN}".desktop \
			|| die "failed to fix desktop file"
	fi
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/musique/musique-9999.ebuild,v 1.4 2013/07/10 04:51:35 patrick Exp $

EAPI="4"

inherit qt4-r2 git-2

DESCRIPTION="Qt4 music player."
HOMEPAGE="http://flavio.tordini.org/minitunes"
EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtgui:4[dbus(+)]
	dev-qt/qtsql:4[sqlite]
	|| ( dev-qt/qtphonon:4 media-libs/phonon )
	media-libs/taglib
"
DEPEND="${RDEPEND}"

DOCS="CHANGES TODO"

src_configure() {
	eqmake4 ${PN}.pro PREFIX="/usr"
}

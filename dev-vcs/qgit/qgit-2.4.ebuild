# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/qgit/qgit-2.4.ebuild,v 1.5 2012/03/25 18:46:03 ranger Exp $

EAPI=4

inherit eutils qt4-r2

DESCRIPTION="Qt4 GUI for git repositories"
HOMEPAGE="http://libre.tibirna.org/projects/qgit/wiki/QGit"
SRC_URI="http://dev.gentoo.org/~pesa/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	>=dev-vcs/git-1.6
"

S=${WORKDIR}/redivivus

src_install() {
	newbin bin/qgit qgit4
	newicon src/resources/qgit.png qgit4.png
	make_desktop_entry qgit4 QGit qgit4
	dodoc README
}

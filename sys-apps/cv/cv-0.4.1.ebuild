# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cv/cv-0.4.1.ebuild,v 1.1 2014/08/06 02:43:45 zx2c4 Exp $

EAPI=5

DESCRIPTION="Coreutils Viewer: show progress for cp, rm, dd, and so forth."
HOMEPAGE="https://github.com/Xfennec/cv"
SRC_URI="https://github.com/Xfennec/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/CFLAGS=-g/CFLAGS+=/' Makefile || die
}

src_install() {
	emake PREFIX="${D}/${EPREFIX}/usr" install
}

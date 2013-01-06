# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/plextor-tool/plextor-tool-0.5.0.ebuild,v 1.4 2009/05/07 20:30:40 ssuominen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Tool to change the parameters of a Plextor CD-ROM drive"
HOMEPAGE="http://plextor-tool.sourceforge.net/"
SRC_URI="mirror://sourceforge/plextor-tool/${P}.src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static gnome"

RDEPEND="gnome? ( gnome-base/gnome-panel )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	gunzip src/plextor-tool.8.gz || die
}

src_compile() {
	cd "${S}"/src
	local targets="plextor-tool"
	use static && targets="${targets} pt-static"
	use gnome && targets="${targets} plextor-tool-applet"
#	use static && use gnome && targets="${targets} pta-static"
	echo ${targets} > my-make-targets
	emake CC="$(tc-getCC)" ${targets} || die "make ${targets} failed"
}

src_install() {
	local targets=$(<src/my-make-targets)
	dodoc src/TODO doc/README doc/NEWS
	cd src
	dobin ${targets} || die "dobin failed"
	doman plextor-tool.8
}

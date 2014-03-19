# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/nmon/nmon-14i.ebuild,v 1.1 2014/03/19 20:58:31 polynomial-c Exp $

EAPI=5

inherit toolchain-funcs flag-o-matic

DESCRIPTION="Nigel's performance MONitor for CPU, memory, network, disks, etc..."
HOMEPAGE="http://nmon.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/lmon${PV}.c"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/lmon${PV}.c "${S}"/nmon.c || die
}

src_compile() {
	append-cppflags -DJFS -DGETUSER -DLARGEMEM -DPOWER
	emake CC="$(tc-getCC)" LDLIBS="-lncurses" nmon
}

src_install() {
	dobin nmon
}

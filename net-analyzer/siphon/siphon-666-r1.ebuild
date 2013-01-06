# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/siphon/siphon-666-r1.ebuild,v 1.5 2012/12/05 16:28:50 jer Exp $

EAPI="2"

inherit toolchain-funcs

MY_P=${PN}-v.${PV}

DESCRIPTION="A portable passive network mapping suite"
SRC_URI="http://siphon.datanerds.net/${MY_P}.tar.gz"
HOMEPAGE="http://siphon.datanerds.net/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="net-libs/libpcap"
RDEPEND="${DEPEND}"
IUSE=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i log.c \
		-e 's:osprints\.conf:/etc/osprints.conf:' \
		|| die "sed log.c"
	sed -i Makefile \
		-e '/^CFLAGS/s:=.*:+= -pthread -Wall -I.:g' \
		-e 's: -o : $(LDFLAGS)&:g' \
		|| die "sed Makefile"
}

src_compile() {
	emake CC=$(tc-getCC) || die
}

src_install() {
	dobin ${PN} || die "dobin ${PN}"
	insinto /etc
	doins osprints.conf
	dodoc README
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/watchdog/watchdog-5.9-r1.ebuild,v 1.1 2011/06/09 01:36:47 vapier Exp $

EAPI="2"

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="A software watchdog"
HOMEPAGE="http://sourceforge.net/projects/watchdog/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~m68k ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="nfs"

DEPEND="nfs? ( net-libs/libtirpc )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nfs.patch #370655
}

src_configure() {
	if use nfs ; then
		append-cppflags $($(tc-getPKG_CONFIG) libtirpc --cflags)
		export LIBS+=" $($(tc-getPKG_CONFIG) libtirpc --libs)"
	fi
	econf $(use_enable nfs)
}

src_install() {
	emake DESTDIR="${D}" install || die

	newconfd "${FILESDIR}"/${PN}-conf.d ${PN}
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}

	dodoc AUTHORS README TODO NEWS ChangeLog
	docinto examples
	dodoc examples/*
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/dialign-tx/dialign-tx-1.0.2.ebuild,v 1.3 2010/02/09 11:20:45 pacho Exp $

EAPI="2"

inherit multilib toolchain-funcs

MY_P="DIALIGN-TX_${PV}"

DESCRIPTION="Greedy and progressive approaches for segment-based multiple sequence alignment"
HOMEPAGE="http://dialign-tx.gobics.de/"
SRC_URI="http://dialign-tx.gobics.de/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake -C source clean
	emake -C source \
		CPPFLAGS="${CFLAGS}" \
		|| die "make failed"
}

src_install() {
	DESTTREE="/usr" dobin "${S}"/source/dialign-tx
	insinto /usr/$(get_libdir)/${PN}/conf
	doins "${S}"/conf/*
}

pkg_postinst() {
	einfo "The configuration directory is"
	einfo "${ROOT}usr/$(get_libdir)/${PN}/conf"
	einfo "You will need to pass this to ${PN} on every run."
}

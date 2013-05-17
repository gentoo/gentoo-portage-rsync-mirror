# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/acpype/acpype-389.ebuild,v 1.1 2013/05/17 10:53:33 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit python-r1

DESCRIPTION="AnteChamber PYthon Parser interfacE"
HOMEPAGE="http://code.google.com/p/acpype/"
SRC_URI="http://dev.gentoo.org/~jlec/distfiles/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux"
IUSE=""

DEPEND="sci-chemistry/ambertools"
RDEPEND="${DEPEND}"

src_prepare() {
	sed \
		-e '1s:^:#!/usr/bin/python\n\n:g' \
		-i CcpnToAcpype.py || die
}

src_install() {
	python_parallel_foreach_impl python_newscript ${PN}.py ${PN}
	python_parallel_foreach_impl python_newscript CcpnToAcpype.py CcpnToAcpype
	dodoc NOTE.txt README.txt
	insinto /usr/share/${PN}
	doins -r ffamber_additions test
}

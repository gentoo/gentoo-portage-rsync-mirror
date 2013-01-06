# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/switzerland/switzerland-0.0.5.ebuild,v 1.2 2011/04/05 20:20:11 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils toolchain-funcs

DESCRIPTION="Switzerland Network Testing Tool"
HOMEPAGE="http://www.eff.org/testyourisp/switzerland/"
SRC_URI="mirror://sourceforge/switzerland/${P}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-libs/libpcap"
RDEPEND=${DEPEND}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	cp "${FILESDIR}"/Makefile switzerland/client

	sed -i \
		-e "s/= find_binary()/= dest/" \
		setup.py
}

src_compile() {
	cd switzerland/client
	emake CC=$(tc-getCC) || die "emake failed"

	cd "${S}"
	distutils_src_compile
}

src_install() {
	distutils_src_install

	dodoc BUGS.txt CREDITS

	keepdir /var/log/switzerland-pcaps
	keepdir /var/log/switzerland
}

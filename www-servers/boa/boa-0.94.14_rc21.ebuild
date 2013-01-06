# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/boa/boa-0.94.14_rc21.ebuild,v 1.6 2011/08/02 06:23:01 mattst88 Exp $

inherit eutils

MY_PV=${PV/_/}
DESCRIPTION="A very small and very fast http daemon."
SRC_URI="http://www.boa.org/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.boa.org/"

KEYWORDS="~x86 ~sparc ~mips ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="doc"
S=${WORKDIR}/${PN}-${MY_PV}

RDEPEND=""
DEPEND="sys-devel/bison
	sys-devel/flex
	doc? ( virtual/latex-base )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-texi.patch
	epatch "${FILESDIR}"/${P}-ENOSYS.patch
}

src_compile() {
	econf || die
	emake || die
	use doc || sed -i -e '/^all:/s/boa.dvi //' docs/Makefile
	emake docs || die
}

src_install() {
	dosbin src/boa
	doman docs/boa.8
	doinfo docs/boa.info
	if use doc; then
		dodoc docs/boa.html
		dodoc docs/boa_banner.png
		dodoc docs/boa.dvi
	fi

	keepdir /var/log/boa
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin
	dodir /var/www/localhost/icons

	newconfd "${FILESDIR}"/boa.conf.d boa

	exeinto /usr/lib/boa
	doexe src/boa_indexer

	newinitd "${FILESDIR}"/boa.rc6 boa

	dodir /etc/boa
	insinto /etc/boa
	doins "${FILESDIR}"/boa.conf
	doins "${FILESDIR}"/mime.types
}

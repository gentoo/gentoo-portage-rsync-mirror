# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/topal/topal-64.ebuild,v 1.4 2009/11/07 22:18:37 volkmar Exp $

EAPI=2

inherit toolchain-funcs eutils

DESCRIPTION="Topal is a 'glue' program that links GnuPG and Pine/Alpine."
HOMEPAGE="http://homepage.ntlworld.com/phil.brooke/topal/"
SRC_URI="http://homepage.ntlworld.com/phil.brooke/topal/rel-${PV}/topal-package-${PV}.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/ada"
RDEPEND=">=app-crypt/gnupg-2.0.7-r1
	|| ( net-mail/metamail app-misc/run-mailcap )
	|| ( app-text/dos2unix app-text/hd2u )"

src_prepare() {
	rm "${S}"/MIME-tool/mime-tool || die
	epatch "${FILESDIR}"/${PV}-Makefile.patch
}

src_compile() {
	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "make failed"
}

src_install() {
	emake install \
		INSTALLPATH="${D}"/usr \
		INSTALLPATHDOC="${D}"/usr/share/doc/${PF} \
			|| die "make install failed"
	dohtml "${S}"/README.html || die
}

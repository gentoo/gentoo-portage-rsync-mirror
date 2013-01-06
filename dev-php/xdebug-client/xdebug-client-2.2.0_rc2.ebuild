# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/xdebug-client/xdebug-client-2.2.0_rc2.ebuild,v 1.2 2012/09/09 17:37:25 armin76 Exp $

KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"

MY_PV="${PV/_/}"
MY_PV="${MY_PV/rc/RC}"

DESCRIPTION="Xdebug client for the Common Debugger Protocol (DBGP)."
HOMEPAGE="http://www.xdebug.org/"
SRC_URI="http://pecl.php.net/get/xdebug-${MY_PV}.tgz"
LICENSE="Xdebug"
SLOT="0"
IUSE="libedit"

S="${WORKDIR}/xdebug-${MY_PV}/debugclient"

DEPEND="libedit? ( dev-libs/libedit )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	chmod +x "${S}"/configure
}

src_compile() {
	econf $(use_with libedit) --disable-dependency-tracking
	emake || die "Build of debug client failed!"
}

src_install() {
	newbin debugclient xdebug
}

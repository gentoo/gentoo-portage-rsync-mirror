# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JavaScript-SpiderMonkey/JavaScript-SpiderMonkey-0.200.0.ebuild,v 1.3 2012/11/13 00:17:00 robbat2 Exp $

EAPI=4

MODULE_AUTHOR=TBUSCH
MODULE_VERSION=${PV%0.0}
inherit perl-module

DESCRIPTION="Perl interface to the JavaScript Engine"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/Log-Log4perl
	>=dev-lang/spidermonkey-1.5"
DEPEND="${RDEPEND}
	dev-perl/extutils-pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/mozjs185.patch
	perl-module_src_prepare
}

SRC_TEST=do

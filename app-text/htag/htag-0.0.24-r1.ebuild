# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htag/htag-0.0.24-r1.ebuild,v 1.1 2013/08/29 14:45:35 idella4 Exp $

EAPI=5

inherit perl-module

DESCRIPTION="random signature maker"
HOMEPAGE="http://www.earth.li/projectpurple/progs/htag.html"
SRC_URI="http://www.earth.li/projectpurple/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

src_install() {
	newbin htag.pl htag || die "newbin failed"
	# establish "${D}"usr/share/doc/${PF}, mv 2 folders in 1 line
	perl-module_src_install
	mv ./{example-scripts,docs/sample-config/} "${D}"usr/share/doc/${PF}/ || die
	dodoc docs/{MACRO_DESCRIPTION,README}

	insinto /usr/share/htag/plugins
	doins plugins/* || die "failed to install plugins"

	insinto "${VENDOR_LIB}"
	doins HtagPlugin/HtagPlugin.pm || die "failed to install perl module"
}

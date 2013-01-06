# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/htag/htag-0.0.24.ebuild,v 1.6 2012/02/02 07:23:30 jlec Exp $

inherit perl-app

DESCRIPTION="random signature maker"
HOMEPAGE="http://www.earth.li/projectpurple/progs/htag.html"
SRC_URI="http://www.earth.li/projectpurple/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ~sparc x86"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"

src_install() {
	newbin htag.pl htag || die "newbin failed"

	dodir /usr/share/doc/${PF}/
	mv docs/sample-config "${D}"/usr/share/doc/${PF}/
	dodoc docs/* || die
	docinto example-scripts
	dodoc example-scripts/* || die

	insinto /usr/share/htag/plugins
	doins plugins/* || die "failed to install plugins"

	insinto "${VENDOR_LIB}"
	doins HtagPlugin/HtagPlugin.pm || die "failed to install perl module"
}

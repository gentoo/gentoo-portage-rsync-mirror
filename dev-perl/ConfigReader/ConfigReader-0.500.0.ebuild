# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ConfigReader/ConfigReader-0.500.0.ebuild,v 1.2 2011/09/03 21:05:10 tove Exp $

EAPI=4

PERL_EXPORT_PHASE_FUNCTIONS=no
MODULE_AUTHOR=AMW
MODULE_VERSION=0.5
inherit perl-module

DESCRIPTION="Read directives from a configuration file."

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

src_install() {
	perlinfo
	insinto ${VENDOR_LIB}/${PN}
	doins "${S}"/*.pm || die
	insinto ${VENDOR_LIB}
	doins "${S}"/*.pod || die
	dodoc README || die
}

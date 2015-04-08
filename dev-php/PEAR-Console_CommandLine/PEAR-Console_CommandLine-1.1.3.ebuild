# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Console_CommandLine/PEAR-Console_CommandLine-1.1.3.ebuild,v 1.3 2011/08/21 03:31:52 phajdan.jr Exp $

EAPI="2"
inherit php-pear-r1

DESCRIPTION="A full featured command line options and arguments parser"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND=">=dev-php/pear-1.4"

RDEPEND="${DEPEND}"

src_install() {
	php-pear-r1_src_install
	rm -r "${D}"/usr/share/php/tests
	rm -r "${D}"/usr/share/php/docs
}

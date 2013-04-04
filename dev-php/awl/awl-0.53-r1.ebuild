# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/awl/awl-0.53-r1.ebuild,v 1.1 2013/04/04 20:26:04 mabi Exp $

EAPI=4

DESCRIPTION="Andrew McMillan's web libraries: A collection of generic classes
used by the davical calendar server"
HOMEPAGE="http://andrew.mcmillan.net.nz/projects/awl"
SRC_URI="http://debian.mcmillan.net.nz/packages/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( dev-php/PEAR-PhpDocumentor )"
RDEPEND="dev-lang/php[pdo,postgres,xml]"

DOCS="debian/README.Debian debian/changelog"

src_compile() {
	if use doc ; then
		ebegin "Generating documentation"
		phpdoc -c "docs/api/phpdoc.ini" || die "Documentation failed to build"
	fi
}

src_install() {
	use doc && dohtml -r "docs/api/"
	insinto "/usr/share/php/${PN}"
	doins -r dba inc scripts
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/awl/awl-0.53.ebuild,v 1.1 2012/07/17 07:07:32 patrick Exp $

EAPI=2

inherit depend.php php-lib-r1

DESCRIPTION="Andrew McMillan's web libraries: A collection of generic classes
used by the davical calendar server"
HOMEPAGE="http://andrew.mcmillan.net.nz/projects/awl"
SRC_URI="http://debian.mcmillan.net.nz/packages/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-lang/php[pdo,postgres,xml]
	doc? ( dev-php/PEAR-PhpDocumentor )"
RDEPEND="${DEPEND}"

need_php5

src_compile() {
	if use doc ; then
		ebegin "Generating documentation"
		phpdoc -c "docs/api/phpdoc.ini" || die "Documentation failed to build"
	fi
}

src_install() {
	local docs="debian/README.Debian debian/changelog"
	dodoc-php ${docs} || die "dodoc failed"

	if use doc ; then
		dohtml -r "docs/api/" || die "dohtml failed"
	fi

	php-lib-r1_src_install . dba/* inc/* scripts/*
}

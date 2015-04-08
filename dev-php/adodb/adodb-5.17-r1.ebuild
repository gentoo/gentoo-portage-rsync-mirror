# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-5.17-r1.ebuild,v 1.10 2014/08/10 20:59:07 slyfox Exp $

EAPI=4

inherit php-lib-r1 versionator

MY_PV=$(delete_all_version_separators "${PV}" )
DESCRIPTION="Active Data Objects Data Base library for PHP"
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/${PN}${MY_PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}"$(get_major_version)
DOCS="license.txt readme.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt docs/*htm"
need_php5

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_install() {
	# install php files
	php-lib-r1_src_install . $(find . -name '*.php' -print)

	# install xsl files
	php-lib-r1_src_install . xsl/*.xsl

	# install documentation
	dodoc-php *.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt
	dohtml-php docs/*.htm
}

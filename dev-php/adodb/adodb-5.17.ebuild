# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-5.17.ebuild,v 1.1 2012/06/10 12:12:11 mabi Exp $

EAPI=4

inherit versionator

MY_PV=$(delete_all_version_separators "${PV}" )
DESCRIPTION="Active Data Objects Data Base library for PHP."
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/${PN}${MY_PV}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}/${PN}"$(get_major_version)

DOCS="license.txt readme.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt docs/*htm"

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_install() {
	insinto "/usr/share/php/${PN}"
	doins $(find . -name '*.php' -print)
	doins xsl/*.xsl

	# do DOCS
	default_src_install
}

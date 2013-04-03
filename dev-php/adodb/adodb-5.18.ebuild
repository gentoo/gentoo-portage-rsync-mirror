# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/adodb/adodb-5.18.ebuild,v 1.2 2013/04/03 20:28:11 mabi Exp $

EAPI=4

inherit versionator

MY_PV=$(delete_all_version_separators "${PV}" )
DESCRIPTION="Active Data Objects Data Base library for PHP."
HOMEPAGE="http://adodb.sourceforge.net/"
SRC_URI="mirror://sourceforge/adodb/adodb-php5-only/${PN}-${MY_PV}-for-php5/${PN}${MY_PV}a.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/php"

S="${WORKDIR}/${PN}"$(get_major_version)
DOCS="license.txt readme.txt xmlschema.dtd session/adodb-sess.txt pear/readme.Auth.txt docs/*htm"

pkg_setup() {
	ewarn "ADODB requires some form of SQL or ODBC support in your PHP."
}

src_install() {
	# install php files
	local INSTDIR="/usr/share/php/${PN}"
	insinto "$INSTDIR"
	doins -r ./*

	for f in $DOCS ; do
		rm "${INSTDIR}/${f}"
	done
	rm -rf "${INSTDIR}/cute_icons_for_site"
	find "${D}" -type d -empty -exec rm -r {} \+

	default_src_install # copy DOCS
}

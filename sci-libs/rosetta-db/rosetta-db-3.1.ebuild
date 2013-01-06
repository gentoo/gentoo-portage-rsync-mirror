# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/rosetta-db/rosetta-db-3.1.ebuild,v 1.2 2010/07/04 08:06:36 jlec Exp $

DESCRIPTION="Essential database for rosetta"
HOMEPAGE="http://www.rosettacommons.org"
SRC_URI="rosetta3.1_database.tgz"

LICENSE="rosetta"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch binchecks strip"

S="${WORKDIR}"/rosetta3.1_database

pkg_nofetch() {
	einfo "Go to ${HOMEPAGE} and get ${A}"
	einfo "which must be placed in ${DISTDIR}"
}

src_install() {
	find . -type d -name ".svn" -exec rm -rf '{}' \; 2> /dev/null
	insinto /usr/share/${PN}
	doins -r * || die
}

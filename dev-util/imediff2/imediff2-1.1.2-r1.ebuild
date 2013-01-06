# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/imediff2/imediff2-1.1.2-r1.ebuild,v 1.2 2011/04/05 05:29:51 ulm Exp $

inherit eutils versionator

KEYWORDS="~amd64 ~x86"

MY_P=${PN}_$(replace_version_separator 3 -)

DESCRIPTION="An interactive, user friendly 2-way merge tool in text mode."
HOMEPAGE="http://elonen.iki.fi/code/imediff/"
SRC_URI="mirror://debian/pool/main/i/${PN}/${MY_P}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

pkg_setup() {
	if ! built_with_use --missing true dev-lang/python ncurses ; then
		eerror "dev-lang/python has to be built with ncurses support"
		die "Missing ncurses USE-flag for dev-lang/python"
	fi
}

src_compile() {
	# Otherwise the docs get regenerated :)
	einfo "Nothing to compile..."
}

src_install() {
	dobin imediff2
	dodoc AUTHORS README
	doman imediff2.1
}

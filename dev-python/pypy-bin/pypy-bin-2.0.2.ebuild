# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypy-bin/pypy-bin-2.0.2.ebuild,v 1.1 2013/07/19 15:00:21 idella4 Exp $

EAPI=5

inherit versionator

DESCRIPTION="Pre-built pypy binary for low memory systems"
HOMEPAGE="http://pypy.org/"
SRC_URI="http://dev.gentoo.org/~idella4/${P}.tbz2"

LICENSE="MIT"
SLOT=$(get_version_component_range 1-2 ${PV})
KEYWORDS="~amd64 ~amd64-linux"
IUSE="bzip2 ncurses sqlite ssl xml"

RDEPEND=">=sys-libs/zlib-1.1.3
	virtual/libffi
	virtual/libintl
	dev-libs/expat
	bzip2? ( app-arch/bzip2 )
	ncurses? ( sys-libs/ncurses )
	sqlite? ( dev-db/sqlite:3 )
	ssl? ( dev-libs/openssl )"
PDEPEND="app-admin/python-updater"
REQUIRED_USE="bzip2 ncurses sqlite ssl xml"

S="${WORKDIR}"

src_install() {
	mv "${WORKDIR}"/usr "${D}" || die
}

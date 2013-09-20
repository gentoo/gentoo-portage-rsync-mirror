# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/zmap/zmap-9999.ebuild,v 1.1 2013/09/20 16:02:31 jlec Exp $

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="Fast network scanner designed for Internet-wide network surveys"
HOMEPAGE="https://zmap.io/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zmap/zmap.git"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS=""
IUSE="json redis"

RDEPEND="
	dev-libs/gmp
	net-libs/libpcap
	json? ( dev-libs/json-c )
	redis? ( dev-libs/hiredis )"
DEPEND="${RDEPEND}
	dev-util/gengetopt"

PATCHES=( "${FILESDIR}"/${P}-cmake.patch )
EPATCH_OPTS="-p1"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with json)
		$(cmake-utils_use_with redis)
		)
	cmake-utils_src_configure
}

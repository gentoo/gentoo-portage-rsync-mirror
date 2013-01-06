# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libkolab/libkolab-0.2.0.ebuild,v 1.4 2012/12/01 14:41:53 kensington Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Advanced Kolab Object Handling Library"
HOMEPAGE="http://kolab.org"
SRC_URI="http://dev.gentoo.org/~creffett/distfiles/${P}.tar.gz"

LICENSE="LGPL-2+ LGPL-2.1+ LGPL-3+"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="test"

PATCHES=( "${FILESDIR}/libkolab-fix-include.patch" )

DEPEND="
	$(add_kdebase_dep kdepimlibs 'semantic-desktop')
	>=net-libs/libkolabxml-0.4.0
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with test BUILD_TESTS)
	)
	kde4-base_src_configure
}

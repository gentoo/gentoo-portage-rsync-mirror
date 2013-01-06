# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libh2oxx/libh2oxx-0.2.ebuild,v 1.1 2012/06/07 15:21:27 mgorny Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="C++ bindings for libh2o"
HOMEPAGE="https://bitbucket.org/mgorny/libh2oxx/"
SRC_URI="mirror://bitbucket/mgorny/${PN}/downloads/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs"

RDEPEND=">=sci-libs/libh2o-0.2"
DEPEND="${RDEPEND}"

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
	)

	autotools-utils_src_configure
}

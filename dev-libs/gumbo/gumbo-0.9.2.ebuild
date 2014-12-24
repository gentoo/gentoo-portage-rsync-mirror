# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gumbo/gumbo-0.9.2.ebuild,v 1.1 2014/12/24 06:51:31 graaff Exp $

EAPI=5

inherit autotools

DESCRIPTION="An implementation of the HTML5 parsing algorithm implemented as a pure C99 library"
HOMEPAGE="https://github.com/google/gumbo-parser#readme"
SRC_URI="https://github.com/google/gumbo-parser/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

IUSE="test"

S="${WORKDIR}/gumbo-parser-${PV}"

DEPEND="test? ( dev-cpp/gtest )"

src_prepare() {
	eautoreconf
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/liblognorm/liblognorm-0.3.6.ebuild,v 1.1 2013/04/07 19:14:32 maksbotan Exp $

EAPI=5

inherit  autotools-utils

DESCRIPTION="Fast samples-based log normalization library"
HOMEPAGE="http://www.liblognorm.com"
SRC_URI="http://www.liblognorm.com/files/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~x86 ~amd64-linux"
IUSE="debug static-libs"

RDEPEND="
	>=dev-libs/libestr-0.1.3
	>=dev-libs/libee-0.3.2
	"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	"
DOCS=( ChangeLog )

src_compile() {
	autotools-utils_src_compile -j1
}

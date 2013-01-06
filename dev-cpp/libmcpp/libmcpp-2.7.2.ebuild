# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libmcpp/libmcpp-2.7.2.ebuild,v 1.3 2009/11/19 14:32:11 fauli Exp $

inherit eutils

MY_P=${P/lib/}

DESCRIPTION="A portable C++ preprocessor"
HOMEPAGE="http://mcpp.sourceforge.net"
SRC_URI="mirror://sourceforge/mcpp/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm x86"
IUSE=""

DEPEND="app-arch/gzip"
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --enable-mcpplib
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}

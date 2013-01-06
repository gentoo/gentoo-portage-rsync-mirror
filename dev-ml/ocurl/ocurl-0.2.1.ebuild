# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocurl/ocurl-0.2.1.ebuild,v 1.4 2009/06/21 13:10:17 aballier Exp $

inherit eutils findlib

DESCRIPTION="OCaml interface to the libcurl library"
HOMEPAGE="http://sourceforge.net/projects/ocurl"
LICENSE="MIT"
SRC_URI="mirror://sourceforge/ocurl/${P}.tar.gz"

SLOT="0"
IUSE="doc"

DEPEND=">=net-misc/curl-7.9.8
dev-libs/openssl"
RDEPEND="$DEPEND"
KEYWORDS="~amd64 ppc x86"

src_compile()
{
	econf --with-findlib || die
	emake -j1 all || die
}

src_install()
{
	findlib_src_install
	use doc && dodoc examples/*.ml
}

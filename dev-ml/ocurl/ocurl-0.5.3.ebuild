# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocurl/ocurl-0.5.3.ebuild,v 1.3 2011/12/18 19:54:08 phajdan.jr Exp $

EAPI=2

inherit eutils findlib autotools

DESCRIPTION="OCaml interface to the libcurl library"
HOMEPAGE="http://sourceforge.net/projects/ocurl"
LICENSE="MIT"
SRC_URI="mirror://sourceforge/ocurl/${P}.tgz"

SLOT="0"
IUSE="examples"

DEPEND=">=net-misc/curl-7.9.8
dev-libs/openssl"
RDEPEND="$DEPEND"
KEYWORDS="amd64 ~ppc x86"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.5.1-asneeded.patch"
	eautoreconf
}

src_configure() {
	econf --with-findlib
}

src_compile()
{
	emake -j1 all || die
}

src_install()
{
	findlib_src_install
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/ypsilon/ypsilon-0.9.6_p3.ebuild,v 1.2 2009/12/21 14:33:49 ssuominen Exp $

inherit eutils flag-o-matic toolchain-funcs

MY_P="${P/_p/.update}"
DESCRIPTION="R6RS-compliant Scheme implementation for real-time applications"
HOMEPAGE="http://code.google.com/p/ypsilon/"
SRC_URI="http://ypsilon.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples threads"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
}

src_compile() {
	use threads && append-flags "-pthread"

	emake PREFIX="/usr" CXX="$(tc-getCXX)" \
		CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" install || die "Install failed"
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins example/* || die "Failed to install examples"
	fi
}

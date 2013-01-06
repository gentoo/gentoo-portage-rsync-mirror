# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/camomile/camomile-0.8.4.ebuild,v 1.3 2012/05/29 19:38:32 ranger Exp $

EAPI="2"

inherit findlib eutils

DESCRIPTION="Camomile is a comprehensive Unicode library for ocaml."
HOMEPAGE="http://github.com/yoriyuki/Camomile/wiki"
SRC_URI="http://github.com/downloads/yoriyuki/Camomile/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="debug +ocamlopt"

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt?]"
DEPEND="${RDEPEND}"

src_configure() {
	econf $(use_enable debug)
}

src_compile() {
	emake -j1 byte unidata unimaps charmap_data locale_data || die "failed to build"
	if use ocamlopt; then
		emake -j1 opt || die "failed to build native code"
	fi
}

src_install() {
	dodir /usr/bin
	findlib_src_install DATADIR="${D}/usr/share" BINDIR="${D}/usr/bin"
}

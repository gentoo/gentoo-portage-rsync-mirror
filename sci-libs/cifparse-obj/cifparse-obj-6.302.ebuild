# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cifparse-obj/cifparse-obj-6.302.ebuild,v 1.5 2011/08/26 16:18:55 jlec Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-v${PV}-prod-src"

DESCRIPTION="Provides an object-oriented application interface to information in mmCIF format"
HOMEPAGE="http://sw-tools.pdb.org/apps/CIFPARSE-OBJ/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/CIFPARSE-OBJ/${MY_P}.tar.gz"

LICENSE="PDB"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/respect-flags-and-add-gcc4.patch
	cd "${S}"

	sed \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-i "${S}"/etc/make.*
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dolib.a lib/*
	insinto /usr/include/rcsb
	doins include/*
}

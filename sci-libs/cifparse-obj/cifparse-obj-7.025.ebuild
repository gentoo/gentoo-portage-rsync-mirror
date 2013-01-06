# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/cifparse-obj/cifparse-obj-7.025.ebuild,v 1.8 2012/06/02 12:57:09 jlec Exp $

inherit eutils toolchain-funcs

MY_P="${PN}-v${PV}-prod-src"

DESCRIPTION="Provides an object-oriented application interface to information in mmCIF format"
HOMEPAGE="http://sw-tools.pdb.org/apps/CIFPARSE-OBJ/index.html"
SRC_URI="http://sw-tools.pdb.org/apps/CIFPARSE-OBJ/source/${MY_P}.tar.gz"

LICENSE="PDB"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-macos"
IUSE=""

RDEPEND=""
DEPEND="
	sys-devel/bison
	sys-devel/flex"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch \
		"${FILESDIR}"/${P}-makefile.patch \
		"${FILESDIR}"/${P}-gcc4.3.patch \
		"${FILESDIR}"/${P}-gcc4.7.patch

	sed -i \
		-e "s:^\(CC=\).*:\1$(tc-getCC):g" \
		-e "s:^\(CCC=\).*:\1$(tc-getCXX):g" \
		-e "s:^\(F77=\).*:\1${FORTRANC}:g" \
		-e "s:^\(F77_LINKER=\).*:\1${FORTRANC}:g" \
		"${S}"/etc/make.*  \
		|| die "Failed to fix makefile"
}

src_compile() {
	# parallel make fails
	emake -j1 || die "Failed to compile"
}

src_install() {
	dolib.a lib/* || die "Failed to install libs"
	insinto /usr/include/${PN}
	doins include/* || die "Failed to install include files"
}

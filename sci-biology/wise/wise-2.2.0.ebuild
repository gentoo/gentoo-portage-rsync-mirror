# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/wise/wise-2.2.0.ebuild,v 1.12 2010/10/02 15:08:42 dilfridge Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Intelligent algorithms for DNA searches"
HOMEPAGE="http://www.ebi.ac.uk/Wise2/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/unix/${PN}2/${PN}${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE=""
KEYWORDS="~alpha ia64 ~sparc x86 ~amd64"

RDEPEND="~sci-biology/hmmer-2.3.2"
DEPEND="${RDEPEND}
	app-shells/tcsh
	dev-lang/perl
	virtual/latex-base"

S="${WORKDIR}"/${PN}${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	cd "${S}"/src
#	if use threads; then
#		append-flags "-DPTHREAD"
#		sed -e "s/#EXTRALIBS = -lpthread/EXTRALIBS = -lpthread/" -i makefile || die
#	fi
	sed -e "s/CC = cc/CC = $(tc-getCC)/" \
		-e "s/CFLAGS = -c -O/CFLAGS = -c ${CFLAGS}/" \
		-i makefile || die
	cd "${S}"/docs
	cat "${S}"/src/models/*.tex "${S}"/src/dynlibsrc/*.tex | perl gettex.pl > temp.tex
	cat wise2api.tex temp.tex apiend.tex > api.tex
	epatch "${FILESDIR}"/${PN}-api.tex.patch
}

src_compile() {
	cd src
	make all || die
	cd "${S}"/docs
	for i in api appendix dynamite wise2 wise3arch; do
		latex ${i} || die
		latex ${i} || die
		dvips ${i}.dvi -o || die
	done
}

src_install() {
	dobin "${S}"/src/bin/* || die "Failed to install program"
	dolib "${S}"/src/base/libwisebase.a || die "Failed to install libwisebase"
	dolib "${S}"/src/dynlibsrc/libdyna.a || die "Failed to install libdyna"
	dobin "${S}"/src/dynlibsrc/testgendb || die "Failed to install testgendb"
	dolib "${S}"/src/models/libmodel.a || die "Failed to install libmodel"
	insinto /usr/share/${PN}
	doins -r "${S}"/wisecfg || die "Failed to install wisecfg"
	insinto /usr/share/doc/${PF}
	doins "${S}"/docs/*.ps || die "Failed to install documentation"
	newenvd "${FILESDIR}"/${PN}-env 24wise || die "Failed to install env file"
}

src_test() {
	cd "${S}"/src
	WISECONFIGDIR="${S}/wisecfg" make test || die
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/wise/wise-2.4.0_alpha.ebuild,v 1.2 2010/10/02 15:08:42 dilfridge Exp $

EAPI="3"

inherit eutils toolchain-funcs versionator

DESCRIPTION="Intelligent algorithms for DNA searches"
HOMEPAGE="http://www.ebi.ac.uk/Wise2/"
SRC_URI="ftp://ftp.ebi.ac.uk/pub/software/${PN}2/${PN}$(delete_version_separator 3).tar.gz"

LICENSE="BSD"
SLOT="0"
IUSE="doc"
KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"

RDEPEND="~sci-biology/hmmer-2.3.2"
DEPEND="
	${RDEPEND}
	app-shells/tcsh
	dev-lang/perl
	virtual/latex-base"

S="${WORKDIR}"/${PN}$(delete_version_separator 3)

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc-2.10.patch
	epatch "${FILESDIR}"/${P}-cflags.patch
	cd "${S}"/docs
	cat "${S}"/src/models/*.tex "${S}"/src/dynlibsrc/*.tex | perl gettex.pl > temp.tex
	cat wise2api.tex temp.tex apiend.tex > api.tex
	epatch "${FILESDIR}"/${PN}-api.tex.patch
}

src_compile() {
	emake \
		-C src \
		CC="$(tc-getCC)" \
		all || die
	if use doc; then
		cd "${S}"/docs
		for i in api appendix dynamite wise2 wise3arch; do
			latex ${i} || die
			latex ${i} || die
			dvips ${i}.dvi -o || die
		done
	fi
}

src_test() {
	cd "${S}"/src
	WISECONFIGDIR="${S}/wisecfg" make test || die
}

src_install() {
	dobin "${S}"/src/bin/* || die "Failed to install program"
	dolib.a "${S}"/src/base/libwisebase.a || die "Failed to install libwisebase"
	dolib.a "${S}"/src/dynlibsrc/libdyna.a || die "Failed to install libdyna"
	dobin "${S}"/src/dynlibsrc/testgendb || die "Failed to install testgendb"
	dolib.a "${S}"/src/models/libmodel.a || die "Failed to install libmodel"
	insinto /usr/share/${PN}
	doins -r "${S}"/wisecfg || die "Failed to install wisecfg"
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins "${S}"/docs/*.ps || die "Failed to install documentation"
	fi
	newenvd "${FILESDIR}"/${PN}-env 24wise || die "Failed to install env file"
}

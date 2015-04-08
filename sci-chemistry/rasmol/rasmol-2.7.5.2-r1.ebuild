# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/rasmol/rasmol-2.7.5.2-r1.ebuild,v 1.4 2015/03/28 21:40:24 ago Exp $

EAPI=5

inherit eutils fortran-2 multilib prefix toolchain-funcs

MY_P="RasMol_${PV}"
VERS="13May11"

DESCRIPTION="Molecular Graphics Visualisation Tool"
HOMEPAGE="http://www.openrasmol.org/"
#SRC_URI="http://www.rasmol.org/software/${MY_P}.tar.gz"
SRC_URI="mirror://sourceforge/open${PN}/RasMol/RasMol_2.7.5/${P}-${VERS}.tar.gz"
#SRC_URI="mirror://sourceforge/open${PN}/RasMol/RasMol_2.7.5/RasMol.tar.gz"

LICENSE="|| ( GPL-2 RASLIC )"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-libs/cvector
	dev-util/gtk-builder-convert
	>=sci-libs/cbflib-0.9.2
	>=sci-libs/cqrlib-1.1.2
	>=sci-libs/neartree-3.1.1
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/vte:0"
DEPEND="${RDEPEND}
	app-text/rman
	x11-misc/imake
	x11-proto/inputproto
	x11-proto/xextproto"

#S="${WORKDIR}/${PN}-2.7.5-${VERS}"
S="${WORKDIR}/RasMol-${PV}"

src_prepare() {
	cd src || die

	epatch \
		"${FILESDIR}"/${P}-glib.h.patch \
		"${FILESDIR}"/${P}-format-security.patch \
		"${FILESDIR}"/${P}-longlong.patch

	if use amd64 || use amd64-linux; then
		mv rasmol.h rasmol_amd64_save.h && \
		echo "#define _LONGLONG"|cat - rasmol_amd64_save.h > rasmol.h
	fi

	mv Imakefile_base Imakefile || die
	epatch "${FILESDIR}"/2.7.5-bundled-lib.patch

	eprefixify Imakefile

	xmkmf -DGTKWIN ${myconf} || die "xmkmf failed with ${myconf}"
}

src_compile() {
	emake -C src clean
	emake \
		-C src \
		DEPTHDEF=-DTHIRTYTWOBIT \
		CC="$(tc-getCC)" \
		CDEBUGFLAGS="${CFLAGS}" \
		EXTRA_LDOPTIONS="${LDFLAGS}"
}

src_install () {
	libdir=$(get_libdir)
	insinto /usr/${libdir}/${PN}
	doins doc/rasmol.hlp
	dobin src/rasmol
	dodoc PROJECTS {README,TODO}.txt doc/*.{ps,pdf}.gz doc/rasmol.txt.gz
	doman doc/rasmol.1
	insinto /usr/${libdir}/${PN}/databases
	doins data/*

	dohtml -r *html doc/*.html html_graphics
}

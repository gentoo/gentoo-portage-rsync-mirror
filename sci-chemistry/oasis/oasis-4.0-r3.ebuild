# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/oasis/oasis-4.0-r3.ebuild,v 1.6 2013/12/24 12:43:46 ago Exp $

EAPI=5

inherit eutils fortran-2 multilib toolchain-funcs

MY_P="${PN}${PV}_Linux"

DESCRIPTION="A direct-method program for SAD/SIR phasing"
HOMEPAGE="http://cryst.iphy.ac.cn/Project/protein/protein-I.html"
SRC_URI="http://dev.gentooexperimental.org/~jlec/distfiles/${MY_P}.zip"

SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
LICENSE="ccp4 oasis"
IUSE="examples +minimal"

RDEPEND="
	sci-chemistry/ccp4-apps
	sci-chemistry/pymol
	sci-libs/mmdb
	sci-visualization/gnuplot
	!minimal? (
		sci-chemistry/solve-resolve-bin
		sci-chemistry/arp-warp-bin
	)"
DEPEND="${RDEPEND}
	sci-libs/ccp4-libs"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	rm bin/{fnp2fp,gnuplot,oasis4-0,seq} || die
	epatch "${FILESDIR}"/${PV}-makefile.patch
}

src_compile() {
	emake \
		-C src \
		F77="$(tc-getFC)" \
		CFLAGS="${FFLAGS}" \
		CCP4_LIB="${EPREFIX}/usr/$(get_libdir)" \
		Linux
}

src_install() {
	exeinto /usr/libexec/ccp4/bin/
	doexe src/{${PN},fnp2fp}

	exeinto /usr/$(get_libdir)/${PN}
	doexe bin/*.*sh

	insinto /usr/share/doc/${PF}/html
	doins bin/html/*
	dosym ../../share/doc/${PF}/html /usr/$(get_libdir)/${PN}/html
	chmod 755 "${ED}"/usr/share/doc/${PF}/html/*.{*sh,awk} || die

	if use examples; then
		insinto /usr/share/${PN}
		doins -r examples
	fi

	cat >> "${T}"/25oasis <<- EOF
	oasisbin="${EPREFIX}/usr/$(get_libdir)/${PN}"
	EOF

	doenvd "${T}"/25oasis
}

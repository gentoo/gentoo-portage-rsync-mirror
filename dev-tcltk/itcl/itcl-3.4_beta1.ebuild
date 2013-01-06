# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/itcl/itcl-3.4_beta1.ebuild,v 1.8 2011/06/04 18:56:46 armin76 Exp $

EAPI="3"

inherit eutils multilib versionator

MY_P="${PN}${PV/_beta/b}"

DESCRIPTION="Object Oriented Enhancements for Tcl/Tk"
HOMEPAGE="http://incrtcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/incrtcl/%5BIncr%20Tcl_Tk%5D-source/$(get_version_component_range 1-2)/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~x86-macos"

RDEPEND="dev-lang/tcl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}$(get_version_component_range 1-2)"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-test.patch
}

src_compile() {
	# adjust install_name on darwin
	if [[ ${CHOST} == *-darwin* ]]; then
		sed -i \
			-e 's:^\(SHLIB_LD\W.*\)$:\1 -install_name ${pkglibdir}/$@:' \
			"${S}"/Makefile || die 'sed failed'
	fi

	sed 's:-pipe::g' -i Makefile || die

	emake CFLAGS_DEFAULT="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc CHANGES ChangeLog INCOMPATIBLE README TODO || die

	cat >> "${T}"/34${PN} <<- EOF
	LDPATH="${EPREFIX}/usr/$(get_libdir)/${PN}$(get_version_component_range 1-2)/"
	EOF
	doenvd "${T}"/34${PN} || die
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.38.ebuild,v 1.1 2014/02/13 08:19:23 radhermit Exp $

EAPI="4"

inherit eutils flag-o-matic toolchain-funcs

if [[ ${PV} == *_p* ]] ; then
	DEB_DIFF=${PN}_${PV/_p/-}
fi
MY_P=${P%_p*}

DESCRIPTION="The Fast Lexical Analyzer"
HOMEPAGE="http://flex.sourceforge.net/"
SRC_URI="mirror://sourceforge/flex/${MY_P}.tar.bz2
	${DEB_DIFF:+mirror://debian/pool/main/f/flex/${DEB_DIFF}.diff.gz}"

LICENSE="FLEX"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~arm-linux ~x86-linux"
IUSE="nls static test"

# We want bison explicitly and not yacc in general #381273
RDEPEND="sys-devel/m4"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	test? ( sys-devel/bison )"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog NEWS ONEWS README* THANKS TODO"

src_prepare() {
	[[ -n ${DEB_DIFF} ]] && epatch "${WORKDIR}"/${DEB_DIFF}.diff
	sed -i "/^AR =/s:=.*:= $(tc-getAR):" Makefile.in || die #444086
}

src_configure() {
	use static && append-ldflags -static
	econf \
		$(use_enable nls) \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	default
	rm "${ED}"/usr/share/doc/${PF}/{COPYING,flex.pdf} || die
	dosym flex /usr/bin/lex
}

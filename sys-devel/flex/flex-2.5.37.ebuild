# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/flex/flex-2.5.37.ebuild,v 1.12 2013/01/01 19:22:36 armin76 Exp $

EAPI="3"

inherit eutils flag-o-matic

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
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="nls static test"

# We want bison explicitly and not yacc in general #381273
RDEPEND="sys-devel/m4"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	test? ( sys-devel/bison )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	[[ -n ${DEB_DIFF} ]] && epatch "${WORKDIR}"/${DEB_DIFF}.diff
	epatch "${FILESDIR}"/${P}-proto.patch
	epatch "${FILESDIR}"/${P}-tests.patch #429954
}

src_configure() {
	use static && append-ldflags -static
	econf \
		$(use_enable nls) \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake install DESTDIR="${D}" || die
	rm "${D}"/usr/share/doc/${PF}/{COPYING,flex.pdf} || die
	dodoc AUTHORS ChangeLog NEWS ONEWS README* THANKS TODO
	dosym flex /usr/bin/lex
}

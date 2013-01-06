# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-latex/pidgin-latex-1.3.4.ebuild,v 1.7 2012/05/05 05:12:00 jdhore Exp $

EAPI="2"
inherit multilib toolchain-funcs

DESCRIPTION="Pidgin plugin that renders latex formulae"
HOMEPAGE="http://sourceforge.net/projects/pidgin-latex/"
SRC_URI="mirror://sourceforge/pidgin-latex/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

COMMON_DEPEND="
	net-im/pidgin[gtk]
	x11-libs/gtk+:2"
DEPEND="${COMMON_DEPEND}
	sys-devel/libtool
	virtual/pkgconfig"
RDEPEND="${COMMON_DEPEND}
	virtual/latex-base
	app-text/dvipng"

S=${WORKDIR}/${PN}

src_prepare() {
	sed -e "s:\(CC.*=\).*:\1 $(tc-getCC):" \
		-e "/LIB_INSTALL_DIR/{s:/lib/pidgin:/$(get_libdir)/pidgin:;}" \
		-e "s:-shared:\$(LDFLAGS) &:" \
			-i Makefile || die
}

src_compile() {
	emake PREFIX=/usr || die
}

src_install() {
	emake PREFIX="${D}/usr" install || die "make install failed"
	dodoc README CHANGELOG TODO || die
}

pkg_postinst() {
	elog 'Note, to see formulas either disable "Conversation Colors" plugin or'
	elog 'switch off "ignore incoming format" option in plugin configuration.'
	elog 'For details, take a look (and vote) at http://developer.pidgin.im/ticket/2772'
}

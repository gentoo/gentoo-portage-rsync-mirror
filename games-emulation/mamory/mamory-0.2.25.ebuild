# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/mamory/mamory-0.2.25.ebuild,v 1.4 2012/04/25 16:25:16 jlec Exp $

inherit autotools games

DESCRIPTION="ROM management tools and library"
HOMEPAGE="http://mamory.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="dev-libs/expat"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Make sure the system expat is used
	sed -i \
		-e 's/#ifdef.*SYSEXPAT/#if 1/' \
		mamory/amlxml.c mamory/amlxml.h \
		|| die "sed amlxml failed"

	# Remove hardcoded CFLAGS options
	sed -i \
		-e '/AC_ARG_ENABLE(debug,/ {N;N;N;d}' \
		configure.ac \
		|| die "sed configure.ac failed"

	# Make it possible for eautoreconf to fix fPIC etc.
	sed -i \
		-e '/libcommon_la_LDFLAGS= -static/d' \
		common/Makefile.am \
		|| die "sed Makefile.am failed"

	AT_M4DIR="config" eautoreconf
}

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--includedir=/usr/include || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README TODO
	dohtml DOCS/mamory.html
	prepgamesdirs
}

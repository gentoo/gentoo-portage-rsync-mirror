# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/freewnn/freewnn-1.1.1_alpha20.ebuild,v 1.14 2007/04/28 15:42:16 tove Exp $

MY_P="FreeWnn-${PV/_alpha/-a0}"

DESCRIPTION="Network-Extensible Kana-to-Kanji Conversion System"
HOMEPAGE="http://www.freewnn.org/"
SRC_URI="ftp://ftp.freewnn.org/pub/FreeWnn/alpha/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha -amd64 ia64"
IUSE="X ipv6"

DEPEND="X? ( x11-libs/libX11 x11-libs/libXmu x11-libs/libXt )"

S="${WORKDIR}/FreeWnn-1.10-pl020"

src_unpack() {
	unpack ${A}

	#Change WNNOWNER to root so we don't need to add wnn user
	mv "${S}"/makerule.mk.in "${T}"
	sed -e "s/WNNOWNER = wnn/WNNOWNER = root/" \
		"${T}"/makerule.mk.in > "${S}"/makerule.mk.in
}

src_compile() {
	econf \
		--disable-cWnn \
		--disable-kWnn \
		--without-termcap \
		`use_with X x` \
		`use_with ipv6` || die "./configure failed"

	emake -j1 || die
	#make || die
}

src_install() {
	# install executables, libs ,dictionaries
	make DESTDIR="${D}" install || die "installation failed"
	# install man pages
	make DESTDIR="${D}" install.man || die "installation of manpages failed"
	# install docs
	dodoc ChangeLog* INSTALL* CONTRIBUTORS
	# install rc script
	newinitd "${FILESDIR}"/freewnn.initd freewnn
}

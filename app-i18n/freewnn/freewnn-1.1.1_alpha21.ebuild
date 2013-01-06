# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/freewnn/freewnn-1.1.1_alpha21.ebuild,v 1.11 2007/07/12 13:04:22 armin76 Exp $

inherit eutils

MY_P="FreeWnn-${PV/_alpha/-a0}"

DESCRIPTION="Network-Extensible Kana-to-Kanji Conversion System"
HOMEPAGE="http://freewnn.sourceforge.jp/
	http://www.freewnn.org/"
SRC_URI="mirror://sourceforge.jp/freewnn/17724/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 ~sparc x86"
IUSE="X ipv6"

DEPEND="X? ( x11-libs/libX11 x11-libs/libXmu x11-libs/libXt )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd "${S}"
	#Change WNNOWNER to root so we don't need to add wnn user
	sed -i -e "s/WNNOWNER = wnn/WNNOWNER = root/" makerule.mk.in || die
}

src_compile() {
	econf \
		--disable-cWnn \
		--disable-kWnn \
		--without-termcap \
		$(use_with X x) \
		$(use_with ipv6) \
		|| die "./configure failed"
	emake -j1 || die
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

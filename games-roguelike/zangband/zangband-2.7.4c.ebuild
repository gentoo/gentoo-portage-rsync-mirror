# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-roguelike/zangband/zangband-2.7.4c.ebuild,v 1.11 2010/03/04 00:52:42 nyhm Exp $

EAPI=2
inherit autotools eutils games

DESCRIPTION="An enhanced version of the Roguelike game Angband"
HOMEPAGE="http://www.zangband.org/"
SRC_URI="ftp://ftp.sunet.se/pub/games/Angband/Variant/ZAngband/${P}.tar.gz"

LICENSE="Moria"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE="tk"

RDEPEND="tk? (
		dev-lang/tcl
		dev-lang/tk )
	x11-libs/libXaw"
DEPEND="${RDEPEND}
	x11-proto/xextproto"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-tk85.patch \
		"${FILESDIR}"/${P}-rng.patch
	eautoreconf
}

src_configure() {
	egamesconf \
		--datadir="${GAMES_DATADIR_BASE}" \
		--with-setgid="${GAMES_GROUP}" \
		--without-gtk \
		$(use_with tk tcltk)
}

src_install() {
	# Keep some important dirs we want to chmod later
	keepdir "${GAMES_DATADIR}"/${PN}/lib/apex \
		"${GAMES_DATADIR}"/${PN}/lib/user \
		"${GAMES_DATADIR}"/${PN}/lib/save

	# Install the basic files but remove unneeded crap
	emake DESTDIR="${D}/${GAMES_DATADIR}"/${PN}/ installbase \
		|| die "emake installbase failed"
	rm "${D}${GAMES_DATADIR}"/${PN}/{angdos.cfg,readme,z_faq.txt,z_update.txt}

	# Install everything else and fix the permissions
	dogamesbin zangband || die "dogamesbin failed"
	dodoc readme z_faq.txt z_update.txt || die "dodoc failed"
	find "${D}${GAMES_DATADIR}/zangband/lib" -type f -exec chmod a-x \{\} \;

	prepgamesdirs
	# All users in the games group need write permissions to
	# some important dirs
	fperms -R g+w "${GAMES_DATADIR}"/zangband/lib/{apex,data,save,user}
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/freecnc/freecnc-0.2.1.31072003.ebuild,v 1.19 2015/03/25 06:29:36 mr_bones_ Exp $

EAPI=5
inherit flag-o-matic eutils games

DESCRIPTION="SDL-rewrite of the classical real time strategy hit Command & Conquer"
HOMEPAGE="http://www.freecnc.org/"
#mirror://sourceforge/freecnc/freecnc++-${PV}-src.tar.bz2
SRC_URI="mirror://gentoo/freecnc++-${PV}-src.tar.bz2
	nocd? ( ftp://ftp.westwood.com/pub/cc1/previews/demo/cc1demo1.zip
			ftp://ftp.westwood.com/pub/cc1/previews/demo/cc1demo2.zip )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE="nocd"

RDEPEND="media-libs/libsdl[sound,video]
	media-libs/sdl-net"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/freecnc++

src_unpack() {
	unpack freecnc++-${PV}-src.tar.bz2
	if use nocd ; then
		mkdir data && cd data || die
		unpack cc1demo1.zip cc1demo2.zip
		for f in * ; do
			mv ${f} $(echo ${f} | awk '{print tolower($1)}') || die
		done
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-makefile-cflags.patch \
		"${FILESDIR}"/${PV}-remove-root.patch \
		"${FILESDIR}"/${PV}-gentoo-paths.patch \
		"${FILESDIR}"/${P}-gcc4.patch \
		"${FILESDIR}"/${P}-gcc42.patch \
		"${FILESDIR}"/${P}-glibc2.10.patch \
		"${FILESDIR}"/${P}-as-needed.patch \
		"${FILESDIR}"/${P}-underlink.patch
	sed -i \
		-e "s:GENTOO_LOGDIR:${GAMES_LOGDIR}:" \
		-e "s:GENTOO_CONFDIR:${GAMES_SYSCONFDIR}/${PN}/:" \
		-e "s:GENTOO_DATADIR:${GAMES_DATADIR}/${PN}/:" \
		src/{freecnc,vfs/vfs}.cpp tools/audplay/audplay.cpp || die
	sed -i \
		-e 's/-Werror//' \
		-e 's/ -j2//' \
		$(grep -rl Werror .) || die
	sed -i \
		-e '/^DEBUG_FLAGS/s/$/ -fPIC/' \
		src/vfs/vfs_tgz/Makefile \
		src/vfs/vfs_mix/Makefile || die
}

src_compile() {
	emake linux EXTRACFLAGS="${CFLAGS}"
}

src_install() {
	exeinto "$(games_get_libdir)"/${PN}
	doexe freecnc *.vfs audplay shpview tmpinied
	games_make_wrapper ${PN} ./freecnc "$(games_get_libdir)"/${PN}
	insinto "${GAMES_DATADIR}"/${PN}/conf
	doins conf/*
	insinto "${GAMES_SYSCONFDIR}"/${PN}
	doins conf/*
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	if use nocd ; then
		cd "${WORKDIR}"/data
		insinto "${GAMES_DATADIR}"/${PN}
		doins *.mix *.aud
		dodoc *.txt
	fi
	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	if ! use nocd ; then
		elog "If you have the C&C games, then just copy the .mix"
		elog "to ${GAMES_DATADIR}/${PN}"
		elog "Otherwise, re-emerge freecnc with 'nocd' in your USE."
	fi
}

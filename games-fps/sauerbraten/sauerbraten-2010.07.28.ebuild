# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/sauerbraten/sauerbraten-2010.07.28.ebuild,v 1.5 2012/12/04 15:37:45 ago Exp $

EAPI=2
inherit eutils flag-o-matic games

EDITION="justice_edition"
DESCRIPTION="Cube 2: Sauerbraten is an open source game engine (Cube 2) with freeware game data (Sauerbraten)"
HOMEPAGE="http://sauerbraten.org/"
SRC_URI="mirror://sourceforge/sauerbraten/2010_07_19/sauerbraten_${PV//./_}_${EDITION}_linux.tar.bz2"

LICENSE="ZLIB freedist"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug dedicated"

DEPEND="
	sys-libs/zlib
	net-libs/enet:1.3
	!dedicated? (
		media-libs/libsdl[X,opengl]
		media-libs/sdl-mixer[vorbis]
		media-libs/sdl-image[png,jpeg]
		virtual/opengl
		virtual/glu )"

S=${WORKDIR}/${PN}

src_prepare() {
	ecvs_clean
	rm -rf sauerbraten_unix bin_unix src/{include,lib,vcpp}

	# Patch makefile to use system enet instead of bundled
	epatch "${FILESDIR}"/${P}-system-enet.patch

	# Fix links so they point to the correct directory
	sed -i \
		-e 's:docs/::' \
		README.html \
		|| die
	# Honor CXXFLAGS and LDFLAGS
	sed -i \
		-e 's/[[:space:]]*$//' \
		-e '/^CXXFLAGS=/d' \
		-e '/-o .*LIBS/s/$/ $(LDFLAGS)/' \
		src/Makefile \
		|| die
}

src_compile() {
	use debug && append-flags "-D_DEBUG"
	emake -C src master server $(use dedicated || echo client) \
		|| die
}

src_install() {
	local LIBEXECDIR="${GAMES_PREFIX}/lib"
	local DATADIR="${GAMES_DATADIR}/${PN}"
	local STATEDIR="${GAMES_STATEDIR}/${PN}"

	if ! use dedicated ; then
		# Install the game data
		insinto "${DATADIR}"
		doins -r data packages || die

		# Install the client executable
		exeinto "${LIBEXECDIR}"
		doexe src/sauer_client || die

		# Install the client wrapper
		games_make_wrapper "${PN}-client" "${LIBEXECDIR}/sauer_client -q\$HOME/.${PN} -r" "${DATADIR}"

		# Create menu entry
		newicon data/cube.png ${PN}.png
		make_desktop_entry "${PN}-client" "Cube 2: Sauerbraten"
	fi

	# Install the server config files
	insinto "${STATEDIR}"
	doins "server-init.cfg" || die

	# Install the server executables
	exeinto "${LIBEXECDIR}"
	doexe src/sauer_{server,master} || die

	games_make_wrapper "${PN}-server" \
		"${LIBEXECDIR}/sauer_server -k${DATADIR} -q${STATEDIR}"
	games_make_wrapper "${PN}-master" \
		"${LIBEXECDIR}/sauer_master ${STATEDIR}"

	# Install the server init script
	keepdir "${GAMES_STATEDIR}/run/${PN}"
	cp "${FILESDIR}"/${PN}.init "${T}"
	sed -i \
		-e "s:%SYSCONFDIR%:${STATEDIR}:g" \
		-e "s:%LIBEXECDIR%:${LIBEXECDIR}:g" \
		-e "s:%GAMES_STATEDIR%:${GAMES_STATEDIR}:g" \
		"${T}"/${PN}.init || die
	newinitd "${T}"/${PN}.init ${PN} || die
	cp "${FILESDIR}"/${PN}.conf "${T}"
	sed -i \
		-e "s:%SYSCONFDIR%:${STATEDIR}:g" \
		-e "s:%LIBEXECDIR%:${LIBEXECDIR}:g" \
		-e "s:%GAMES_USER_DED%:${GAMES_USER_DED}:g" \
		-e "s:%GAMES_GROUP%:${GAMES_GROUP}:g" \
		"${T}"/${PN}.conf || die
	newconfd "${T}"/${PN}.conf ${PN} || die

	dodoc src/*.txt docs/dev/*.txt
	dohtml -r README.html docs/*

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	elog "If you plan to use map editor feature copy all map data from ${DATADIR}"
	elog "to corresponding folder in your HOME/.${PN}"
}

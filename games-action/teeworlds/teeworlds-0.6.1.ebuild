# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/teeworlds/teeworlds-0.6.1.ebuild,v 1.3 2012/06/15 15:41:08 mr_bones_ Exp $

EAPI=3
PYTHON_DEPEND="2"
inherit eutils multiprocessing python toolchain-funcs games

REVISION="b177-r50edfd37"

DESCRIPTION="Online multi-player platform 2D shooter"
HOMEPAGE="http://www.teeworlds.com/"
SRC_URI="http://www.teeworlds.com/files/${P}-source.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug dedicated"

RDEPEND="
	!dedicated? ( media-libs/pnglite
		media-libs/libsdl[X,audio,opengl,video]
		media-sound/wavpack
		virtual/opengl
		app-arch/bzip2
		media-libs/freetype
		virtual/glu
		x11-libs/libX11 )
	sys-libs/zlib"
DEPEND="${RDEPEND}
	~dev-util/bam-0.4.0"

S=${WORKDIR}/${PN}-${REVISION}-source

pkg_setup() {
	python_set_active_version 2
	games_pkg_setup
}

src_prepare() {
	# 01 & 02 from pull request: https://github.com/oy/teeworlds/pull/493
	EPATCH_SOURCE="${FILESDIR}/${PV}" EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" \
		epatch

	cat <<- __EOF__ > "${S}/gentoo.lua"
		function addSettings(settings)
			print("Adding Gentoo settings")
			settings.optimize = 0
			settings.cc.exe_c = "$(tc-getCC)"
			settings.cc.exe_cxx = "$(tc-getCXX)"
			settings.cc.flags_c:Add("${CFLAGS}")
			settings.cc.flags_cxx:Add("${CXXFLAGS}")
			settings.link.exe = "$(tc-getCXX)"
			settings.link.flags:Add("${LDFLAGS}")
		end
	__EOF__

	sed -i \
		-e '/^function build(settings)/a dofile("gentoo.lua") addSettings(settings)' \
		bam.lua || die
}

src_configure() {
	bam config || die
}

src_compile() {
	local myopt

	if use debug; then
		myopt=" server_debug"
	else
		myopt=" server_release"
	fi
	if ! use dedicated; then
		if use debug; then
			myopt+=" client_debug"
		else
			myopt+=" client_release"
		fi
	fi

	bam -a -j $(makeopts_jobs) ${myopt} || die
}

src_install() {
	if use debug; then
		newgamesbin ${PN}_srv_d ${PN}_srv || die
	else
		dogamesbin ${PN}_srv || die
	fi
	if ! use dedicated; then
		if use debug; then
			newgamesbin ${PN}_d ${PN} || die
		else
			dogamesbin ${PN} || die
		fi

		doicon "${FILESDIR}"/${PN}.xpm || die
		make_desktop_entry ${PN} Teeworlds

		insinto "${GAMES_DATADIR}"/${PN}/data
		doins -r data/* || die
	else
		insinto "${GAMES_DATADIR}"/${PN}/data/maps
		doins -r data/maps/* || die
	fi
	newinitd "${FILESDIR}"/${PN}-init.d ${PN}
	insinto "/etc/${PN}"
	doins "${FILESDIR}"/teeworlds_srv.cfg

	dodoc readme.txt || die

	prepgamesdirs
}

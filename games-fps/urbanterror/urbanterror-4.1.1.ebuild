# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/urbanterror/urbanterror-4.1.1.ebuild,v 1.8 2013/09/01 20:43:19 hasufell Exp $

EAPI=4

inherit eutils gnome2-utils games

MY_PV=${PV//./}
IOQ3_SVN=1807
IOQ3_PATCH=ioq3-${IOQ3_SVN}-urt-251210-git-nobumpy

DESCRIPTION="Hollywood tactical shooter based on the ioquake3 engine"
HOMEPAGE="http://www.urbanterror.info/home/"
SRC_URI="http://dev.gentoo.org/~hasufell/distfiles/ioquake3-${IOQ3_SVN}.tar.bz2
	http://dev.gentoo.org/~hasufell/distfiles/${IOQ3_PATCH}.tar.xz
	ftp://ftp.snt.utwente.nl/pub/games/${PN}/old/UrbanTerror_${MY_PV:0:2}_FULL.zip
	http://upload.wikimedia.org/wikipedia/en/5/56/Urbanterror.svg -> ${PN}.svg"

LICENSE="GPL-2 Q3AEULA-20000111"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="+curl dedicated openal server speex vorbis"
RESTRICT="mirror"

RDEPEND="
	sys-libs/zlib[minizip]
	!dedicated? (
		media-libs/ftgl
		media-libs/freetype
		media-libs/libsdl[X,opengl]
		virtual/opengl
		curl? ( net-misc/curl )
		openal? ( media-libs/openal )
		speex? ( media-libs/speex )
		vorbis? ( media-libs/libogg media-libs/libvorbis )
	)"
# server target needs libsdl and some
# other headers for build-time
# added them for dedicated useflag
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig
	dedicated? (
		media-libs/libsdl
		curl? ( net-misc/curl )
		speex? ( media-libs/speex )
	)"

S=${WORKDIR}/ioquake3

src_prepare() {
	epatch "${FILESDIR}"/${P}-minizip.patch \
		"${WORKDIR}"/${IOQ3_PATCH}.patch \
		"${FILESDIR}"/${P}-build.patch

	# unbundle
	rm -r code/zlib || die
	rm code/qcommon/unzip.{c,h}  || die
	rm code/qcommon/ioapi.{c,h}  || die
	rm -r code/{FTGL,FT2,SDL12,libs/win32} || die

	# set svn version
	sed \
		-e 's/SVN_REV=$(shell LANG=C svnversion .)/SVN_REV='${IOQ3_SVN}'M/' \
		-i Makefile || die "setting svn version failed"

	# fix case sensitivity
	mv "${WORKDIR}/UrbanTerror/q3ut4/demos/tutorial.dm_68" \
		"${WORKDIR}/UrbanTerror/q3ut4/demos/TUTORIAL.dm_68" || die
}

src_compile() {
	buildit() { use $1 && echo 1 || echo 0 ; }
	nobuildit() { use $1 && echo 0 || echo 1 ; }

	emake \
		ARCH=$(usex amd64 "x86_64" "i386") \
		DEFAULT_BASEDIR="${GAMES_DATADIR}/${PN}" \
		BUILD_CLIENT=$(nobuildit dedicated) \
		BUILD_CLIENT_SMP=$(nobuildit dedicated) \
		BUILD_SERVER=$(usex dedicated "1" "$(buildit server)") \
		USE_CODEC_VORBIS=$(buildit vorbis) \
		USE_VOIP=$(buildit speex) \
		USE_OPENAL=$(buildit openal) \
		USE_CURL=$(buildit curl) \
		USE_INTERNAL_SPEEX=0 \
		USE_INTERNAL_ZLIB=0 \
		USE_LOCAL_HEADERS=0 \
		OPTIMIZEVM="" \
		Q="" \
		release
}

src_install() {
	local my_arch=$(usex amd64 "x86_64" "i386")

	doicon -s scalable "${DISTDIR}"/${PN}.svg

	dodoc ChangeLog NOTTODO README TODO {md4,voip}-readme.txt

	insinto "${GAMES_DATADIR}"/${PN}/q3ut4
	doins -r "${WORKDIR}"/UrbanTerror/q3ut4/{*.pk3,demos/,description.txt}

	if use !dedicated ; then
		newgamesbin build/release-linux-${my_arch}/ioquake3-smp.${my_arch} ${PN}
		make_desktop_entry ${PN} "UrbanTerror"
	fi

	if use dedicated || use server ; then
		newgamesbin build/release-linux-${my_arch}/ioq3ded.${my_arch} ${PN}-dedicated
		newins "${WORKDIR}"/UrbanTerror/q3ut4/mapcycle.txt mapcycle.txt.example
		newins "${WORKDIR}"/UrbanTerror/q3ut4/server.cfg q3config_server.cfg.example
	fi

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

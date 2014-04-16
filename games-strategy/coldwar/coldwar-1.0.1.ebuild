# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/coldwar/coldwar-1.0.1.ebuild,v 1.5 2014/04/16 17:11:40 ulm Exp $

inherit eutils unpacker cdrom versionator games

PV_MAJOR=$(get_version_component_range 1-2)
MY_P=${PN}-${PV_MAJOR}-${PV}

DESCRIPTION="Third-person sneaker like Splinter Cell"
HOMEPAGE="http://linuxgamepublishing.com/info.php?id=coldwar"
SRC_URI="http://updatefiles.linuxgamepublishing.com/${PN}/${MY_P}-x86.run"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_de linguas_fr linguas_ru"
RESTRICT="mirror bindist strip"

RDEPEND="virtual/opengl
	x86? (
		media-libs/libogg
		media-libs/openal
		media-libs/libvorbis
		media-libs/smpeg
		dev-libs/glib
		x11-libs/libX11
		x11-libs/libXext )
	amd64? (
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-medialibs )"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	cdrom_get_cds bin/Linux/x86/${PN}
	ln -sfn "${CDROM_ROOT}"/data cd
	unpack "./cd/data.tar.gz"
	use linguas_de && unpack "./cd/langpack_de.tar.gz"
	use linguas_fr && unpack "./cd/langpack_fr.tar.gz"
	use linguas_ru && unpack "./cd/langpack_ru.tar.gz"
	rm -f cd

	cp -rf "${CDROM_ROOT}"/bin/Linux/x86/* . || die "cp exes failed"
	cp -f "${CDROM_ROOT}"/{READ*,icon*} . || die "cp READ* failed"

	mkdir -p patch
	cd patch
	unpack_makeself ${MY_P}-x86.run
	bin/Linux/x86/loki_patch patch.dat "${S}" || die "loki_patch failed"
	cd "${S}"
	rm -rf patch
}

src_install() {
	dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r * || die "doins -r failed"

	exeinto "${dir}"
	doexe ${PN} || die "doexe ${PN} failed"

	exeinto "${dir}"/bin
	doexe bin/{launch*,meng} || die "doexe bin failed"

	exeinto "${dir}"/lib
	doexe lib/lib* || die "doexe lib/* failed"

	games_make_wrapper ${PN} ./${PN} "${dir}"
	newicon "${CDROM_ROOT}"/icon.xpm ${PN}.xpm || die "newicon failed"
	make_desktop_entry ${PN} "Cold War" ${PN}

	prepgamesdirs
}

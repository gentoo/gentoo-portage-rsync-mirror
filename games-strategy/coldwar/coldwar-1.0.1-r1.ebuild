# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/coldwar/coldwar-1.0.1-r1.ebuild,v 1.3 2014/08/29 17:58:08 mr_bones_ Exp $

EAPI=5

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

RDEPEND="
	|| (
		(
			>=dev-libs/glib-2.34.3[abi_x86_32(-)]
			>=media-libs/libogg-1.3.0[abi_x86_32(-)]
			>=media-libs/libvorbis-1.3.3-r1[abi_x86_32(-)]
			>=media-libs/openal-1.15.1[abi_x86_32(-)]
			>=media-libs/smpeg-0.4.4-r10[abi_x86_32(-)]
			>=virtual/opengl-7.0-r1[abi_x86_32(-)]
			>=x11-libs/libX11-1.6.2[abi_x86_32(-)]
			>=x11-libs/libXext-1.3.2[abi_x86_32(-)]
		)
		amd64? (
			(
				app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)]
				app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
			)
		)
	)"
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

	cp -rf "${CDROM_ROOT}"/bin/Linux/x86/* . || die
	cp -f "${CDROM_ROOT}"/{READ*,icon*} . || die

	mkdir -p patch_dir
	cd patch_dir
	unpack_makeself ${MY_P}-x86.run
	bin/Linux/x86/loki_patch patch.dat "${S}" || die
	cd "${S}"
	rm -rf patch_dir
}

src_install() {
	dir=${GAMES_PREFIX_OPT}/${PN}

	insinto "${dir}"
	doins -r *

	exeinto "${dir}"
	doexe ${PN}

	exeinto "${dir}"/bin
	doexe bin/{launch*,meng}

	exeinto "${dir}"/lib
	doexe lib/lib*

	games_make_wrapper ${PN} ./${PN} "${dir}"
	newicon "${CDROM_ROOT}"/icon.xpm ${PN}.xpm
	make_desktop_entry ${PN} "Cold War" ${PN}

	prepgamesdirs
}

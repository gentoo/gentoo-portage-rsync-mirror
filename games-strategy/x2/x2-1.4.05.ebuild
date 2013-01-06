# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/x2/x2-1.4.05.ebuild,v 1.6 2012/02/05 06:25:47 vapier Exp $

EAPI=2
inherit eutils unpacker cdrom games

MY_PV="1.4.04-${PV}"
MY_UPD="http://updatefiles.linuxgamepublishing.com/${PN}"

DESCRIPTION="Open-ended space opera with trading, building & fighting"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=x2"
# Patches are in http://updatefiles.linuxgamepublishing.com/x2/
SRC_URI="${MY_UPD}/${PN}-1.4-1.4.01-x86.run
	${MY_UPD}/${PN}-1.4.01-1.4.02-x86.run
	${MY_UPD}/${PN}-1.4.02-1.4.03-x86.run
	${MY_UPD}/${PN}-1.4.03-1.4.04-x86.run
	${MY_UPD}/${PN}-${MY_PV}-x86.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bonusscripts dynamic langpacks linguas_de modkit"
RESTRICT="strip"

RDEPEND="media-libs/alsa-lib
	sys-libs/glibc
	x86? (
		media-libs/libsdl
		media-libs/openal
		sys-libs/zlib
		x11-libs/gtk+:2
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi )
	amd64? (
		app-emulation/emul-linux-x86-gtklibs
		app-emulation/emul-linux-x86-sdl )"
DEPEND=""

S=${WORKDIR}

unpackit() {
	unpack "./cd/${1}.tar.gz"
}

src_unpack() {
	cdrom_get_cds bin/Linux/x86/${PN}
	ln -sfn "${CDROM_ROOT}"/data cd

	unpackit data
	use bonusscripts && unpackit bonusscripts
	use linguas_de && unpackit german
	use langpacks && unpackit langpacks
	use modkit && unpackit modkit

	rm -f cd

	cp -rf "${CDROM_ROOT}"/bin/Linux/x86/* . || die "cp exes"
	cp -f "${CDROM_ROOT}"/{READ*,icon*} . || die "cp READ*"

	# Apply the patches
	local p
	for p in 1.4-1.4.01 1.4.01-1.4.02 1.4.02-1.4.03 1.4.03-1.4.04 \
		"${MY_PV}" ; do
		einfo "Applying patch ${p}"
		mkdir patch
		cd patch
		unpack_makeself "${PN}-${p}-x86.run"
		bin/Linux/x86/loki_patch patch.dat "${S}" \
			|| die "loki_patch ${p}"
		cp -f README.txt "${S}/ChangeLog" || die "cp README.txt"
		cd "${S}"
		rm -rf patch
	done

	# These files do not get installed
	[[ -e modkit ]] && rm -f modkit/x2*.debug
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	# Whether to use static (default) or dynamic binaries
	local dyn
	use dynamic && dyn=".dynamic"

	insinto "${dir}"
	doins -r * || die "doins -r"
	keepdir "${dir}"/Database

	exeinto "${dir}"
	doexe x2{,.dynamic} || die "doexe x2"

	if use modkit ; then
		exeinto "${dir}"/modkit
		doexe modkit/x2{build,tool}{,.dynamic} || die "doexe modkit"
		local f
		for f in build tool ; do
			games_make_wrapper "x2${f}" "${dir}/modkit/x2${f}${dyn}"
		done
	fi

	games_make_wrapper ${PN} "./${PN}${dyn}" "${dir}"
	newicon "${CDROM_ROOT}"/icon.xpm ${PN}.xpm || die "newicon"
	make_desktop_entry ${PN} "X2 - The Threat" ${PN}

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if use dynamic ; then
		elog "Please try without the 'dynamic' USE flag, before reporting bugs."
	fi
}

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake4-bin/quake4-bin-1.4.2.ebuild,v 1.6 2012/02/08 21:20:12 vapier Exp $

inherit eutils unpacker games

DESCRIPTION="Sequel to Quake 2, an id Software 3D first-person shooter"
HOMEPAGE="http://www.quake4game.com/"
SRC_URI="mirror://idsoftware/quake4/linux/quake4-linux-${PV}.x86.run"

LICENSE="QUAKE4"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="alsa cdinstall dedicated linguas_cs linguas_fr linguas_it linguas_pl linguas_ru opengl"
RESTRICT="strip"

UIDEPEND="virtual/opengl
	x86? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		media-libs/libsdl )
	amd64? (
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1 ) )
	alsa? ( >=media-libs/alsa-lib-1.0.6 )"

RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	cdinstall? ( games-fps/quake4-data )
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/quake4
Ddir=${D}/${dir}

QA_TEXTRELS="${dir:1}/pb/pbag.so
	${dir:1}/pb/pbags.so
	${dir:1}/pb/pbcl.so
	${dir:1}/pb/pbcls.so
	${dir:1}/pb/pbsv.so
	${dir:1}/libSDL-1.2.id.so.0"
QA_EXECSTACK="${dir:1}/quake4.x86
	${dir:1}/quake4smp.x86
	${dir:1}/q4ded.x86
	${dir:1}/libgcc_s.so.1
	${dir:1}/libSDL-1.2.id.so.0
	${dir:1}/libstdc++.so.6"

zpaklang() {
	if ! use linguas_${1} ; then
		einfo "Removing ${2} zpak files"
		rm -f q4base/zpak_${2}*
	fi
}

src_unpack() {
	unpack_makeself ${A}

	mv q4icon.bmp quake4.bmp || die

	# Am including the Spanish files because Spanish is the default language
	#zpaklang es spanish
	zpaklang cs czech
	zpaklang fr french
	zpaklang it italian
	zpaklang pl polish
	zpaklang ru russian

	# Rename the .off files, so they will be used
	cd q4base
	if [[ ! -z $(ls *.off 2> /dev/null) ]] ; then
		local f
		for f in *.off ; do
			einfo "Renaming ${f}"
			mv "${f}" "${f%.off}" || die "mv ${f}"
		done
	fi
}

src_install() {
	insinto "${dir}"
	doins *.{htm,txt} README us/version.info || die "docs"
	doins -r pb q4mp || die "doins pb q4mp"

	exeinto "${dir}"
	doexe openurl.sh || die "openurl.sh"
	doexe bin/Linux/x86/{quake4{,smp}.x86,q4ded.x86,*.so.?} \
		|| die "doexe x86 exes/libs"

	insinto "${dir}"/q4base
	doins q4base/* us/q4base/* || die "doins q4base"
	if use dedicated ; then
		games_make_wrapper quake4-ded ./q4ded.x86 "${dir}" "${dir}"
	fi

	if use opengl || ! use dedicated ; then
		doicon quake4.bmp || die "doicon"
		games_make_wrapper quake4 "./quake4.x86" "${dir}" "${dir}"
		games_make_wrapper quake4-smp ./quake4smp.x86 "${dir}" "${dir}"
		icon_path="quake4"
		if [ -e "${FILESDIR}"/quake4.png ]
		then
			doicon "${FILESDIR}"/quake4.png || die "copying icon"
		elif [ -e "${DISTDIR}"/quake4.png ]
		then
			doicon "${DISTDIR}"/quake4.png || die "copying icon"
		else
			icon_path=/usr/share/pixmaps/quake4.bmp
		fi
		make_desktop_entry quake4 "Quake IV" ${icon_path}
		make_desktop_entry quake4-smp "Quake IV (SMP)" ${icon_path}
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst

	if ! use cdinstall ; then
		elog "You need to copy pak001.pk4 through pak012.pk4, along with"
		elog "zpak*.pk4 from either your installation media or your hard drive"
		elog "to ${dir}/q4base before running the game."
		echo
	fi
	if use opengl || ! use dedicated ; then
		elog "To play the game, run:  quake4"
		elog
		# The default language is Spanish!
		elog "To reset the language from Spanish to English, run:"
		elog " sed -i 's:spanish:english:' ~/.quake4/q4base/Quake4Config.cfg"
		elog
		elog "Saved games from previous Quake 4 versions might not be compatible."
		echo
	fi
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-action/descent3/descent3-1.4.0b-r1.ebuild,v 1.19 2013/08/14 11:27:41 patrick Exp $

inherit eutils unpacker cdrom multilib games

IUSE="nocd videos"
DESCRIPTION="Descent 3 - 3-Dimensional indoor/outdoor spaceship combat"
HOMEPAGE="http://www.lokigames.com/products/descent3/"
SRC_URI="mirror://lokigames/${PN}/${PN}-1.4.0a-x86.run
	mirror://lokigames/${PN}/${P}-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="strip"

DEPEND=""
RDEPEND="sys-libs/glibc
	virtual/opengl
	sys-libs/lib-compat-loki
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		=media-libs/libsdl-1.2* )
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-compat
		app-emulation/emul-linux-x86-sdl
		>=sys-libs/lib-compat-loki-0.2 )"

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
	if use videos ; then
		ewarn "The installed game takes about 1.2GB of space!"
	elif use nocd ; then
		ewarn "The installed game takes about 510MB of space!"
	else
		ewarn "The installed game takes about 220MB of space!"
	fi
}

src_unpack() {
	if use videos ; then
		cdrom_get_cds missions/d3.mn3 movies/level1.mve
	else
		cdrom_get_cds missions/d3.mn3
	fi
	mkdir -p "${S}"/{a,b}
	cd "${S}"/a
	unpack_makeself ${PN}-1.4.0a-x86.run
	cd "${S}"/b
	unpack_makeself ${P}-x86.run
}

src_install() {
	einfo "Copying files... this may take a while..."
	exeinto "${dir}"
	doexe ${CDROM_ROOT}/bin/x86/glibc-2.1/{${PN},nettest} \
		|| die "copying executables"
	insinto "${dir}"
	doins ${CDROM_ROOT}/{FAQ.txt,README{,.mercenary},d3.hog,icon.{bmp,xpm}} \
		|| die "copying files"

	cd "${Ddir}"
	# TODO: move this to src_unpack where it belongs
	tar xzf ${CDROM_ROOT}/data.tar.gz || die "uncompressing data"
	tar xzf ${CDROM_ROOT}/shared.tar.gz || die "uncompressing shared"

	if use nocd; then
		doins -r ${CDROM_ROOT}/missions || die "copying missions"
	fi

	if use videos ; then
		cdrom_load_next_cd
		doins -r ${CDROM_ROOT}/movies || die "copying movies"
	fi

	cd "${S}"/a
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat "${Ddir}" >& /dev/null || die "patching a"
	cd "${S}"/b
	bin/Linux/x86/loki_patch --verify patch.dat
	bin/Linux/x86/loki_patch patch.dat "${Ddir}" >& /dev/null || die "patching b"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find "${Ddir}" -exec touch '{}' \;

	dosym /usr/$(get_libdir)/loki_libsmpeg-0.4.so.0 \
		"${dir}"/libsmpeg-0.4.so.0 || die "failed compatibility symlink"

	games_make_wrapper descent3 ./descent3.dynamic "${dir}" "${dir}"
	newicon ${CDROM_ROOT}/icon.xpm ${PN}.xpm

	# Fix for 2.6 kernel crash
	cd "${Ddir}"
	ln -sf ppics.hog PPics.Hog

	prepgamesdirs
	make_desktop_entry ${PN} "Descent 3" ${PN}
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " descent3"
	echo
}

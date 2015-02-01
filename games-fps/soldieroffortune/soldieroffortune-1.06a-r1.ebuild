# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/soldieroffortune/soldieroffortune-1.06a-r1.ebuild,v 1.3 2015/02/01 11:26:54 zlogene Exp $

EAPI=5
inherit eutils unpacker cdrom games

DESCRIPTION="First-person shooter based on the mercenary trade"
HOMEPAGE="http://www.lokigames.com/products/sof/"
SRC_URI="mirror://lokigames/sof/sof-${PV}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="strip"
IUSE=""

DEPEND="games-util/loki_patch"
RDEPEND="sys-libs/glibc
	amd64? ( sys-libs/glibc[multilib] )
	|| (
		(
			virtual/opengl[abi_x86_32(-)]
			media-libs/libsdl[X,opengl,sound,abi_x86_32(-)]
			x11-libs/libXrender[abi_x86_32(-)]
			x11-libs/libXrandr[abi_x86_32(-)]
			media-libs/smpeg[abi_x86_32(-)]
		)
		(
			app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-sdl[-abi_x86_32(-)]
			app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)]
		)
	)"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${ED}/${dir}

pkg_pretend() {
	ewarn "The installed game takes about 725MB of space!"
}

src_unpack() {
	cdrom_get_cds sof.xpm
	unpack_makeself
	tar xzf "${CDROM_ROOT}"/paks.tar.gz -C "${T}" \
		|| die "uncompressing data"
	tar xzf "${CDROM_ROOT}"/binaries.tar.gz -C "${T}" \
		|| die "uncompressing binaries"
}

src_install() {
	einfo "Copying files... this may take a while..."
	exeinto "${dir}"
	doexe "${CDROM_ROOT}"/bin/x86/glibc-2.1/sof
	insinto "${dir}"
	doins -r "${T}"/*
	doins "${CDROM_ROOT}"/{README,kver.pub,sof.xpm}

	cd "${S}"
	export _POSIX2_VERSION=199209
	loki_patch --verify patch.dat
	loki_patch patch.dat "${Ddir}" >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find "${Ddir}" -exec touch '{}' \;

	games_make_wrapper sof ./sof "${dir}" "${dir}"

	# fix buffer overflow
	sed -i -e 's/^exec/i \
export MESA_EXTENSION_MAX_YEAR=2003 \
export __GL_ExtensionStringVersion=17700' \
		"${ED}/${GAMES_BINDIR}/sof" || die

	doicon "${CDROM_ROOT}"/sof.xpm
	make_desktop_entry sof "Soldier of Fortune" sof

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " sof"
}

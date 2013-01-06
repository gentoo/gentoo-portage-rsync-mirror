# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/soldieroffortune/soldieroffortune-1.06a.ebuild,v 1.30 2012/09/19 15:16:06 mr_bones_ Exp $

inherit eutils unpacker cdrom games

DESCRIPTION="First-person shooter based on the mercenary trade"
HOMEPAGE="http://www.lokigames.com/products/sof/"
SRC_URI="mirror://lokigames/sof/sof-${PV}-cdrom-x86.run"

LICENSE="LOKI-EULA"
SLOT="0"
KEYWORDS="amd64 x86"
RESTRICT="strip"
IUSE=""

DEPEND="sys-libs/glibc
	games-util/loki_patch"
RDEPEND="virtual/opengl
	x86? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXau
		x11-libs/libXdmcp
		media-libs/libvorbis
		media-libs/libogg
		media-libs/smpeg )
	amd64? (
		app-emulation/emul-linux-x86-baselibs
		app-emulation/emul-linux-x86-xlibs
		app-emulation/emul-linux-x86-sdl
		app-emulation/emul-linux-x86-soundlibs )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

pkg_setup() {
	games_pkg_setup
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
	doexe "${CDROM_ROOT}"/bin/x86/glibc-2.1/sof || die "doexe"
	insinto "${dir}"
	doins -r "${T}"/* || die "doins data"
	doins "${CDROM_ROOT}"/{README,kver.pub,sof.xpm} || die "doins"

	cd "${S}"
	export _POSIX2_VERSION=199209
	loki_patch --verify patch.dat
	loki_patch patch.dat "${Ddir}" >& /dev/null || die "patching"

	# now, since these files are coming off a cd, the times/sizes/md5sums wont
	# be different ... that means portage will try to unmerge some files (!)
	# we run touch on ${D} so as to make sure portage doesnt do any such thing
	find "${Ddir}" -exec touch '{}' \;

	games_make_wrapper sof ./sof "${dir}" "${dir}"
	sed -i \
		-e 's/^exec /__GL_ExtensionStringVersion=17700 exec /' \
		"${D}/${GAMES_BINDIR}/sof" || die
	doicon "${CDROM_ROOT}"/sof.xpm
	make_desktop_entry sof "Soldier of Fortune" sof

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	elog "To play the game run:"
	elog " sof"
}

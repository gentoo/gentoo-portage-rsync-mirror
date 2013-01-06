# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/knights-demo/knights-demo-1.32.ebuild,v 1.3 2012/02/05 06:24:05 vapier Exp $

inherit eutils unpacker games

DESCRIPTION="Anglo-Saxon medieval army battles and resource management"
HOMEPAGE="http://www.linuxgamepublishing.com/info.php?id=knights"
# Unversioned upstream filename
SRC_URI="mirror://gentoo/${P}.run"

LICENSE="knights-demo"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="strip"

RDEPEND="sys-libs/glibc
	x86? (
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXi )
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

src_unpack() {
	unpack_makeself ${P}.run
	mv -f data{,-temp}
	unpack ./data-temp/data.tar.gz
	rm -rf data-temp lgp_* setup*
}

src_install() {
	local dir=${GAMES_PREFIX_OPT}/${PN}

	exeinto "${dir}"
	doexe bin/Linux/x86/${PN}{,.dynamic} || die "doexe failed"

	insinto "${dir}"
	doins -r data || die "doins -r failed"
	doins EULA icon.xpm README{,.licenses} || die "doins failed"

	# We don't support the dynamic version, even though we install it.
	games_make_wrapper ${PN} ./${PN} "${dir}" "${dir}"
	newicon icon.xpm ${PN}.xpm || die "newicon failed"
	make_desktop_entry ${PN} "Knights and Merchants (Demo)" ${PN}
	prepgamesdirs
}

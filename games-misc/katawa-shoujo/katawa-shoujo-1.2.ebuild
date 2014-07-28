# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/katawa-shoujo/katawa-shoujo-1.2.ebuild,v 1.1 2014/07/28 22:36:17 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils games

DESCRIPTION="Bishoujo-style visual novel set in the fictional Yamaku High School for disabled children"
HOMEPAGE="http://katawa-shoujo.com/"
SRC_URI="http://dl.katawa-shoujo.com/gold_1.2/%5b4ls%5d_katawa_shoujo_1.2-%5blinux-x86%5d%5b8F3BA490%5d.tar.bz2 -> ${P}.tar.bz2
	http://dev.gentoo.org/~hasufell/distfiles/katawa-shoujo-48.png
	http://dev.gentoo.org/~hasufell/distfiles/katawa-shoujo-256.png"

LICENSE="CC-BY-NC-ND-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc system-renpy"

# make system-renpy optional due to #459742 :(
RDEPEND="system-renpy? ( games-engines/renpy )
	!system-renpy? (
		|| (
			>=sys-libs/zlib-1.2.8-r1[abi_x86_32(-)]
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
		)
	)" #495270

QA_PREBUILT="${GAMES_PREFIX_OPT}/${PN}/lib/*"

S="${WORKDIR}/Katawa Shoujo-linux-x86"

src_install() {
	if use system-renpy ; then
		insinto "${GAMES_DATADIR}/${PN}"
		doins -r game/.
		games_make_wrapper ${PN} "renpy '${GAMES_DATADIR}/${PN}'"
	else
		insinto "${GAMES_PREFIX_OPT}"/${PN}
		doins -r common game lib renpy "Katawa Shoujo.py" "Katawa Shoujo.sh"
		games_make_wrapper ${PN} "./Katawa\ Shoujo.sh" "${GAMES_PREFIX_OPT}/${PN}"
		fperms +x "${GAMES_PREFIX_OPT}/${PN}"/lib/{python,linux-x86/python.real} \
			"${GAMES_PREFIX_OPT}/${PN}/Katawa Shoujo.sh" \
			"${GAMES_PREFIX_OPT}/${PN}/Katawa Shoujo.py"
	fi

	local i
	for i in 48 256; do
		newicon -s ${i} "${DISTDIR}"/${PN}-${i}.png ${PN}.png
	done

	make_desktop_entry ${PN} "Katawa Shoujo"

	if use doc ; then
		newdoc "Game Manual.pdf" manual.pdf
	fi

	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	elog "Savegames from system-renpy and the bundled version are incompatible"

	if use system-renpy; then
		ewarn "system-renpy is unstable and not supported upstream"
	fi

	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

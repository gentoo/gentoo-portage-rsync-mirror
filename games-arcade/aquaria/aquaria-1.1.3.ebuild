# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/aquaria/aquaria-1.1.3.ebuild,v 1.3 2010/11/09 15:29:21 tupone Exp $

inherit eutils games

DESCRIPTION="A 2D scroller set in a massive ocean world"
HOMEPAGE="http://www.bit-blot.com/aquaria/"
SRC_URI="aquaria-lnx-humble-bundle.mojo.run"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip fetch"

DEPEND="app-arch/unzip"
RDEPEND="x86? ( media-libs/libsdl >=media-libs/openal-1.5 )
	amd64? ( app-emulation/emul-linux-x86-sdl )"

S="${WORKDIR}/data"

pkg_nofetch() {
	echo
	elog "Download ${SRC_URI} from ${HOMEPAGE} and place it in ${DISTDIR}"
	echo
}

src_unpack() {
	# self unpacking zip archive; unzip warns about the exe stuff
	local a="${DISTDIR}/${A}"
	echo ">>> Unpacking ${a} to ${PWD}"
	unzip -q "${a}"
	[ $? -gt 1 ] && die "unpacking failed"
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}/${PN}"

	insinto "${dir}"
	exeinto "${dir}"

	doins -r *.xml */ || die
	doexe "${PN}" || die
	doicon "${PN}.png" || die

	dodoc README-linux.txt || die
	mv "${D}/${dir}"/docs "${D}/usr/share/doc/${PF}/html" || die
	dosym /usr/share/doc/${PF}/html "${dir}"/docs || die

	games_make_wrapper "${PN}" "./${PN}" "${dir}" || die
	make_desktop_entry "${PN}" "Aquaria" || die

	prepgamesdirs
}

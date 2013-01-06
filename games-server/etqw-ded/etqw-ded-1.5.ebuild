# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-server/etqw-ded/etqw-ded-1.5.ebuild,v 1.3 2011/12/14 17:31:07 vapier Exp $

inherit games

DESCRIPTION="Enemy Territory: Quake Wars dedicated server"
HOMEPAGE="http://zerowing.idsoftware.com/linux/etqw/"
SRC_URI="ETQW-server-${PV}-full.x86.run"

LICENSE="ETQW"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch strip"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	amd64? ( app-emulation/emul-linux-x86-baselibs )"

S=${WORKDIR}/data
dir=${GAMES_PREFIX_OPT}/${PN}

QA_TEXTRELS="${dir:1}/pb/*.so"
QA_EXECSTACK="${dir:1}/*.x86
	${dir:1}/*.so*"

pkg_nofetch() {
	einfo "Please download ${A} from"
	einfo "${HOMEPAGE} (requires a BitTorrent client)"
	einfo "and copy it to ${DISTDIR}"
}

src_unpack() {
	tail -c +194885 "${DISTDIR}"/${A} > ${A}.zip
	unpack ./${A}.zip
	rm -f ${A}.zip
}

src_install() {
	insinto "${dir}"
	doins -r base pb *.txt || die "doins failed"
	exeinto "${dir}"
	doexe etqwded.x86 *.so* || die "doexe failed"
	games_make_wrapper ${PN} ./etqwded.x86 "${dir}" "${dir}"
	prepgamesdirs
}

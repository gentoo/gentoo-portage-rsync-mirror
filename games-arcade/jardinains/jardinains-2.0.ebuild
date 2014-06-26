# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/jardinains/jardinains-2.0.ebuild,v 1.11 2014/06/26 19:09:40 axs Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Arkanoid with Gnomes"
HOMEPAGE="http://www.jardinains2.com"
SRC_URI="mirror://gentoo/JN2_1_FREE_LIN.tar.gz"

LICENSE="jardinains"
SLOT="0"
KEYWORDS="-* ~amd64 x86"
IUSE=""
RESTRICT="strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/jardinains/jardinains"

DEPEND=""
RDEPEND="virtual/opengl
	virtual/glu
	virtual/libstdc++
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-1.0-r1 )"

dir=${GAMES_PREFIX_OPT}/${PN}
QA_PREBUILT="${dir:1}/${PN}"

PATCHES=( "${FILESDIR}"/strings-pt.patch )

src_unpack() {
	unpack JN2_1_FREE_LIN.tar.gz
	cd "${WORKDIR}"
	mv "Jardinains 2!" ${P}
}

src_prepare() {
	# clean Mac fork files (bug #295782)
	find . -type f -name "._*" -exec rm -f '{}' +
}

src_install() {
	exeinto "${dir}"
	doexe jardinains || die
	insinto "${dir}"
	doins -r LICENSE.txt data help || die "doins failed"

	games_make_wrapper jardinains ./jardinains "${dir}" "${dir}"

	make_desktop_entry jardinains "Jardinains 2"
	touch "${D}${dir}/data/prefs.xml"
	prepgamesdirs
	chmod g+rw "${D}${dir}/data/prefs.xml"
	chmod -R g+rw "${D}${dir}/data/players"
}

pkg_postinst() {
	games_pkg_postinst
	elog "Due to the way this software is designed all user preferences for"
	elog "graphics, audio and other in game data are shared among all users"
	elog "of the computer. For that reason some files in the instalation   "
	elog "folder are writable by any user in the games group."
}

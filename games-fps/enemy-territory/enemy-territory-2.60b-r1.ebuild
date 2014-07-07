# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/enemy-territory/enemy-territory-2.60b-r1.ebuild,v 1.1 2014/07/07 19:05:33 axs Exp $

EAPI=5
inherit eutils unpacker games

DESCRIPTION="standalone multi-player game based on Return to Castle Wolfenstein"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://3dgamers/wolfensteinet/et-linux-2.60.x86.run
	mirror://idsoftware/et/linux/et-linux-2.60.x86.run
	ftp://ftp.red.telefonica-wholesale.net/GAMES/ET/linux/et-linux-2.60.x86.run
	mirror://idsoftware/et/ET-${PV}.zip
	dedicated? (
		http://dev.gentoo.org/~wolf31o2/sources/dump/${PN}-all-0.1.tar.bz2
		mirror://gentoo/${PN}-all-0.1.tar.bz2
	)"

LICENSE="RTCW-ETEULA"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="dedicated opengl"
RESTRICT="mirror strip"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	amd64? ( sys-libs/glibc[multilib] )
	dedicated? ( app-misc/screen )
	opengl? ( || ( virtual/opengl[abi_x86_32(-)]
		app-emulation/emul-linux-x86-opengl[-abi_x86_32(-)]
	) )
	!dedicated? ( || (
		(
			x11-libs/libX11[abi_x86_32(-)]
			x11-libs/libXext[abi_x86_32(-)]
		)
		app-emulation/emul-linux-x86-xlibs[-abi_x86_32(-)]
	) )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/${PN}
Ddir=${D}/${dir}

QA_TEXTRELS="${dir:1}/pb/pbags.so
	${dir:1}/pb/pbcls.so
	${dir:1}/pb/pbag.so
	${dir:1}/pb/pbcl.so
	${dir:1}/pb/pbsv.so"
QA_EXECSTACK="${dir:1}/et.x86
	${dir:1}/etmain/cgame.mp.i386.so
	${dir:1}/etmain/qagame.mp.i386.so
	${dir:1}/etmain/ui.mp.i386.so"
QA_FLAGS_IGNORED="${QA_TEXTRELS}
	${QA_EXECSTACK}
	${dir:1}/pb/pbweb.x86"
QA_EXECSTACK_x86=${QA_EXECSTACK}
QA_EXECSTACK_amd64=${QA_EXECSTACK}

src_unpack() {
	unpack_makeself et-linux-2.60.x86.run
	if use dedicated; then
		unpack ${PN}-all-0.1.tar.bz2 || die
	fi
	unpack ET-${PV}.zip
}

src_install() {
	exeinto "${dir}"
	doexe openurl.sh || die "doexe failed"
	doexe "Enemy Territory 2.60b"/linux/et.x86 || die "doexe et"
	insinto "${dir}"
	dodoc CHANGES README || die "doins failed"
	doicon ET.xpm

	cp -r Docs pb etmain "${Ddir}" || die "cp failed"
	chmod og+x "${Ddir}"/pb/pbweb.x86 || die "chmod failed"

	games_make_wrapper et ./et.x86 "${dir}" "${dir}"

	if use dedicated ; then
		doexe "Enemy Territory 2.60b"/linux/etded.x86 || die "doexe failed"
		games_make_wrapper et-ded ./etded.x86 "${dir}"
		newinitd "${S}"/et-ded.rc et-ded || die "newinitd failed"
		sed -i \
			-e "s:GAMES_USER_DED:${GAMES_USER_DED}:" \
			-e "s:GENTOO_DIR:${GAMES_BINDIR}:" \
			"${D}"/etc/init.d/et-ded \
			|| die "sed failed"
		newconfd "${S}"/et-ded.conf.d et-ded || die "newconfd failed"
		# TODO: move this to /var/ perhaps ?
		keepdir "${dir}/etwolf-homedir"
		chmod g+rw "${Ddir}/etwolf-homedir"
		dosym "${dir}/etwolf-homedir" "${GAMES_PREFIX}/.etwolf"
	fi

	make_desktop_entry et "Enemy Territory" ET

	prepgamesdirs
	chmod g+rw "${Ddir}" "${Ddir}/etmain"
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "There are two possible security bugs in this package, both causing a"
	ewarn "denial of service.  One affects the game when running a server, the"
	ewarn "other when running as a client."
	ewarn "For more information, see bug #82149."
	echo
	elog "To play the game run:"
	elog " et"
	echo
	if use dedicated; then
		elog "To start a dedicated server run:"
		elog " /etc/init.d/et-ded start"
		echo
		elog "To run the dedicated server at boot, type:"
		elog " rc-update add et-ded default"
		echo
		elog "The dedicated server is started under the ${GAMES_USER_DED} user account."
		echo
		ewarn "Store your configurations under ${dir}/etwolf-homedir or they"
		ewarn "will be erased on the next upgrade."
		ewarn "See bug #132795 for more info."
		echo
	fi
	if use amd64; then
		elog "If you are running an amd64 system and using ALSA, you must have"
		elog "ALSA 32-bit emulation enabled in your kernel for this to function properly."
		echo
	fi
}

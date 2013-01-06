# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-bin/quake3-bin-1.32c-r1.ebuild,v 1.15 2012/12/22 11:00:19 ago Exp $

EAPI=2
inherit eutils unpacker games

DESCRIPTION="3rd installment of the classic id 3D first-person shooter"
HOMEPAGE="http://www.idsoftware.com/"
SRC_URI="mirror://idsoftware/quake3/linux/linuxq3apoint-1.32b-3.x86.run
	mirror://idsoftware/quake3/quake3-1.32c.zip"

LICENSE="Q3AEULA GPL-2" #gpl for init script bug #425942
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE="cdinstall dedicated opengl teamarena"
RESTRICT="strip"

UIDEPEND="virtual/opengl
	x86? (
		x11-libs/libXext
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXdmcp
	)
	amd64? (
		app-emulation/emul-linux-x86-xlibs
		|| (
			>=app-emulation/emul-linux-x86-xlibs-7.0
			x11-drivers/nvidia-drivers
			>=x11-drivers/ati-drivers-8.8.25-r1
		)
	)"
DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	dedicated? ( app-misc/screen )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	opengl? ( ${UIDEPEND} )
	cdinstall? (
		games-fps/quake3-data[cdinstall]
		teamarena? ( games-fps/quake3-teamarena )
	)
	!dedicated? ( !opengl? ( ${UIDEPEND} ) )"

S=${WORKDIR}

dir=${GAMES_PREFIX_OPT}/quake3
Ddir=${D}/${dir}

QA_TEXTRELS="${dir:1}/pb/pbag.so
	${dir:1}/pb/pbcl.so
	${dir:1}/pb/pbsv.so"

default_client() {
	# Use opengl by default
	if use opengl || ! use dedicated ; then
		return 0
	fi
	return 1
}

src_unpack() {
	unpack_makeself linuxq3apoint-1.32b-3.x86.run
	unpack quake3-1.32c.zip
}

src_install() {
	dodir "${dir}"/{baseq3,missionpack}
	if use cdinstall ; then
		dosym "${GAMES_DATADIR}"/quake3/baseq3/pak0.pk3 "${dir}"/baseq3/pak0.pk3
		use teamarena && dosym "${GAMES_DATADIR}"/quake3/missionpack/pak0.pk3 \
			"${dir}"/missionpack/pak0.pk3
	fi
	for pk3 in baseq3/*.pk3 missionpack/*.pk3 ; do
		dosym "${GAMES_DATADIR}"/quake3/${pk3} "${dir}"/${pk3}
	done

	insinto "${dir}"
	doins -r Docs pb || die "ins docs/pb"

	exeinto "${dir}"
	doins quake3.xpm README* Q3A_EULA.txt
	if default_client ; then
		doexe "Quake III Arena 1.32c"/linux/quake3*.x86 || die "doexe"
		games_make_wrapper ${PN} ./quake3.x86 "${dir}" "${dir}"
		newicon quake3.xpm ${PN}.xpm
		make_desktop_entry ${PN} "Quake III Arena (binary)"
		if use teamarena ; then
			games_make_wrapper ${PN}-teamarena \
				"./quake3.x86 +set fs_game missionpack" "${dir}" "${dir}"
			make_desktop_entry ${PN}-teamarena \
				"Quake III Team Arena (binary)" quake3-bin
		fi
	fi
	if use dedicated ; then
		doexe "Quake III Arena 1.32c"/linux/q3ded || die "doexe q3ded"
		games_make_wrapper quake3-ded ./q3ded "${dir}" "${dir}"
		newinitd "${FILESDIR}"/q3ded.rc quake3-ded
		newconfd "${FILESDIR}"/q3ded.conf.d quake3-ded
	fi

	prepgamesdirs
}

pkg_postinst() {
	games_pkg_postinst
	ewarn "There are two possible security bugs in this package, both causing a"
	ewarn "denial of service. One affects the game when running a server, the"
	ewarn "other when running as a client."
	ewarn "For more information, please see bug #82149."
	if use dedicated ; then
		echo
		elog "To start a dedicated server, run"
		elog "  /etc/init.d/quake3-ded start"
		elog
		elog "The dedicated server is started under the ${GAMES_USER_DED} user account."
	fi

	# IA32 Emulation required for amd64
	if use amd64 ; then
		echo
		ewarn "NOTE: IA32 Emulation must be compiled into your kernel for Quake3 to run."
	fi
}

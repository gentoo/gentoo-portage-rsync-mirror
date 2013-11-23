# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/duke3d-data/duke3d-data-1.0-r1.ebuild,v 1.2 2013/11/22 23:06:53 hasufell Exp $

EAPI=5

CDROM_OPTIONAL="yes"
inherit eutils cdrom games

DESCRIPTION="Duke Nukem 3D data files"
HOMEPAGE="http://www.3drealms.com/"
SRC_URI="gog? ( setup_duke3d_2.0.0.84.exe )"

LICENSE="DUKE3D"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="gog"
REQUIRED_USE="^^ ( cdinstall gog )"

DEPEND="gog? ( app-arch/innoextract )"
RDEPEND="|| ( games-fps/eduke32 games-fps/duke3d )"

S=${WORKDIR}

src_unpack() {
	if use cdinstall ; then
		export CDROM_NAME_SET=(
			"Existing Install"
			"Duke Nukem 3D CD"
			"Duke Nukem 3D Atomic Edition CD"
			)
		cdrom_get_cds duke3d.grp:dvd/dn3dinst/duke3d.grp:atominst/duke3d.grp

		if [[ ${CDROM_SET} -ne 0
			&& ${CDROM_SET} -ne 1
			&& ${CDROM_SET} -ne 2 ]]
		then
			die "Error locating data files.";
		fi
	else
		innoextract --lowercase "${DISTDIR}"/setup_duke3d_2.0.0.84.exe
	fi
}

src_install() {
	local DATAROOT

	insinto "${GAMES_DATADIR}"/duke3d

	if use cdinstall ; then
		case ${CDROM_SET} in
		0) DATAROOT="" ;;
		1) DATAROOT="dn3dinst/" ;;
		2) DATAROOT="atominst/" ;;
		esac

		# avoid double slash
		doins "${CDROM_ROOT}"/${DATAROOT}{duke3d.grp,duke.rts,game.con,user.con,demo?.dmo,defs.con}
	else
		doins app/{duke3d.grp,duke.rts,game.con,user.con,demo?.dmo,defs.con}
	fi

	prepgamesdirs
}

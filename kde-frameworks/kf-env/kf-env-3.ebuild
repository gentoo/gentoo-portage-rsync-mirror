# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-frameworks/kf-env/kf-env-3.ebuild,v 1.1 2014/10/15 13:29:45 kensington Exp $

EAPI=5

DESCRIPTION="Environment setting required for all KDE Frameworks apps to run"
HOMEPAGE="http://community.kde.org/Frameworks"
SRC_URI=""

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	x11-misc/xdg-utils
"

S=${WORKDIR}

src_install() {
	einfo "Installing environment file..."

	# higher number to be sure not to kill kde4 env
	local envfile="${T}/78kf"

	echo "CONFIG_PROTECT=${EPREFIX}/usr/share/config" >> ${envfile}
	doenvd ${envfile}
}

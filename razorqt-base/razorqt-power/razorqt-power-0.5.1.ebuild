# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/razorqt-base/razorqt-power/razorqt-power-0.5.1.ebuild,v 1.6 2014/05/31 20:46:45 ssuominen Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="Razor-qt module for power management (logout/shutdown/reboot/suspend/hibernate)"
HOMEPAGE="http://razor-qt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/Razor-qt/razor-qt.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	SRC_URI="mirror://github/Razor-qt/razor-qt/razorqt-${PV}.tar.bz2"
	KEYWORDS="amd64 ~ppc x86"
	S="${WORKDIR}/razorqt-${PV}"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE=""

DEPEND="razorqt-base/razorqt-libs"
RDEPEND="${DEPEND}
	razorqt-base/razorqt-data
	|| ( >=sys-power/upower-0.9.23 sys-power/upower-pm-utils )"

src_configure() {
	local mycmakeargs=(
		-DSPLIT_BUILD=On
		-DMODULE_POWER=On
	)
	cmake-utils_src_configure
}

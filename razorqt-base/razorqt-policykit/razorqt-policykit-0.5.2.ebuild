# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/razorqt-base/razorqt-policykit/razorqt-policykit-0.5.2.ebuild,v 1.3 2013/04/05 14:40:58 ago Exp $

EAPI=4
inherit cmake-utils

DESCRIPTION="A lightweight Qt-based PolicyKit agent"
HOMEPAGE="http://razor-qt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/Razor-qt/razor-qt.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
else
	SRC_URI="http://www.razor-qt.org/downloads/files/razorqt-${PV}.tar.bz2"
	KEYWORDS="amd64 ~ppc x86"
	S="${WORKDIR}/razorqt-${PV}"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
IUSE=""

DEPEND="dev-libs/glib:2
	razorqt-base/razorqt-libs
	sys-auth/polkit-qt"
RDEPEND="${DEPEND}
	razorqt-base/razorqt-data"

src_configure() {
	local mycmakeargs=(
		-DSPLIT_BUILD=On
		-DMODULE_POLICYKIT=On
	)
	cmake-utils_src_configure
}

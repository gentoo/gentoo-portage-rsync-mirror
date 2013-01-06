# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/kdevplatform/kdevplatform-1.4.1.ebuild,v 1.5 2012/12/22 13:54:43 ago Exp $

EAPI=4

KMNAME="kdevelop"
KDE_MINIMAL="4.7"
KDE_LINGUAS="bs ca ca@valencia da de el en_GB es et fi fr gl it nb nds nl pl pt
pt_BR sl sv th uk zh_CN zh_TW"
VIRTUALDBUS_TEST="true"
VIRTUALX_REQUIRED="test"
EGIT_REPONAME="${PN}"

inherit kde4-base

DESCRIPTION="KDE development support libraries and apps"
LICENSE="GPL-2 LGPL-2"
IUSE="cvs debug reviewboard subversion"

if [[ $PV == *9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="amd64 ppc x86"
fi

DEPEND="
	dev-libs/boost
	reviewboard? ( dev-libs/qjson )
	subversion? (
		dev-libs/apr
		dev-libs/apr-util
		dev-vcs/subversion
	)
"
RDEPEND="${DEPEND}
	!<dev-util/kdevelop-${KDEVELOP_VERSION}:4
	$(add_kdebase_dep konsole)
	cvs? ( dev-vcs/cvs )
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_build cvs)
		$(cmake-utils_use_build reviewboard)
		$(cmake-utils_use_build subversion)
	)

	kde4-base_src_configure
}

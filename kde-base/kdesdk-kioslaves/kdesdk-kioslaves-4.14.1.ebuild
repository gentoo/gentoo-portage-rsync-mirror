# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-kioslaves/kdesdk-kioslaves-4.14.1.ebuild,v 1.1 2014/09/16 18:17:26 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="kioslaves from kdesdk package"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug subversion"
KMNAME="kdesdk-kioslaves"

DEPEND="
	subversion? (
		dev-libs/apr
		dev-vcs/subversion
	)
"
RDEPEND="${DEPEND}
	subversion? ( !>=dev-vcs/kdesvn-1.5.2:4 )
"

src_configure() {
	local mycmakeargs=(
		-DAPRCONFIG_EXECUTABLE="${EPREFIX}"/usr/bin/apr-1-config
		$(cmake-utils_use_with subversion SVN)
	)

	kde4-base_src_configure
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mplayerthumbs/mplayerthumbs-4.14.3.ebuild,v 1.5 2015/02/17 11:06:40 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="A Thumbnail Generator for Video Files on KDE filemanagers"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep kdebase-kioslaves)
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_PHONON_SUPPORT=ON
	)

	kde4-base_src_configure
}

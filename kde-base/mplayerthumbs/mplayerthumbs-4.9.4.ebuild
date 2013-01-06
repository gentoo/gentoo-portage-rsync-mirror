# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/mplayerthumbs/mplayerthumbs-4.9.4.ebuild,v 1.2 2012/12/23 11:20:54 maekke Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="A Thumbnail Generator for Video Files on KDE filemanagers."
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	|| (
		$(add_kdebase_dep dolphin)
		$(add_kdebase_dep konqueror)
	)
"

src_configure() {
	mycmakeargs=(
		-DENABLE_PHONON_SUPPORT=ON
	)

	kde4-base_src_configure
}

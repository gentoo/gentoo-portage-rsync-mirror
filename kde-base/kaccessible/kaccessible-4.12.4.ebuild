# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kaccessible/kaccessible-4.12.4.ebuild,v 1.1 2014/04/01 18:09:32 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Provides accessibility services like focus tracking"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +speechd"

DEPEND="speechd? ( app-accessibility/speech-dispatcher )"
RDEPEND=${DEPEND}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with speechd)
	)
	kde4-base_src_configure
}

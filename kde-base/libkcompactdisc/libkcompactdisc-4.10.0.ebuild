# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.10.0.ebuild,v 1.1 2013/02/07 04:57:33 alexxy Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa debug"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	kde4-base_src_configure
}

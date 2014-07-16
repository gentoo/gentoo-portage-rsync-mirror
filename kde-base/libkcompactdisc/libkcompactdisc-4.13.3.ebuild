# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcompactdisc/libkcompactdisc-4.13.3.ebuild,v 1.1 2014/07/16 17:40:40 johu Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE library for playing & ripping CDs"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="alsa debug"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with alsa)
	)
	kde4-base_src_configure
}

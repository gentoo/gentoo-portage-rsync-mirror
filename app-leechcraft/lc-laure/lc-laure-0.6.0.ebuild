# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-leechcraft/lc-laure/lc-laure-0.6.0.ebuild,v 1.1 2013/09/24 15:46:44 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="VLC-based audio/video player for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~app-leechcraft/lc-core-${PV}
	sys-apps/file
	>=media-video/vlc-2.0.0"
RDEPEND="${DEPEND}"

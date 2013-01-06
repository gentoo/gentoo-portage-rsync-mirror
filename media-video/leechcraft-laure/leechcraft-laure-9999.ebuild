# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/leechcraft-laure/leechcraft-laure-9999.ebuild,v 1.2 2012/03/06 21:37:09 mr_bones_ Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="VLC-based audio/video player for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	sys-apps/file
	>=media-video/vlc-2.0.0"
RDEPEND="${DEPEND}"

# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-lastfmscrobble/leechcraft-lastfmscrobble-9999.ebuild,v 1.3 2012/07/07 20:09:59 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Last.FM scrobbler plugin for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	media-libs/liblastfm"
RDEPEND="${DEPEND}"

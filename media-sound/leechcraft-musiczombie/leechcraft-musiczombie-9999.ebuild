# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-musiczombie/leechcraft-musiczombie-9999.ebuild,v 1.1 2012/12/18 18:52:18 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="MusicBrainz client plugin for LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"

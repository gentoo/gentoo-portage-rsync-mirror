# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/leechcraft-musiczombie/leechcraft-musiczombie-0.5.90.ebuild,v 1.1 2012/12/25 16:39:22 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="MusicBrainz client plugin for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}"

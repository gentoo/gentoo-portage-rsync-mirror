# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kscd/kscd-4.14.3.ebuild,v 1.3 2015/02/14 14:35:09 ago Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="KDE CD player"
HOMEPAGE="http://www.kde.org/applications/multimedia/kscd/"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep libkcddb)
	$(add_kdebase_dep libkcompactdisc)
	media-libs/musicbrainz:3
"
RDEPEND="${DEPEND}"

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/leechcraft-deadlyrics/leechcraft-deadlyrics-9999.ebuild,v 1.2 2011/12/16 18:50:44 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Searches for song lyrics and displays them in LeechCraft"

SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}
		virtual/leechcraft-search-show
		virtual/leechcraft-downloader-http"

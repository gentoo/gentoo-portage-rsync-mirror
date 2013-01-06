# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/etrophy/etrophy-0.5.1.ebuild,v 1.2 2012/12/21 17:40:00 tommy Exp $

EAPI=2

inherit enlightenment

DESCRIPTION="Library for managing scores, trophies and unlockables,stores them and provides views to display them"

SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"
LICENSE="BSD-2"

KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND=">=dev-libs/ecore-1.7.0
	>=dev-libs/eet-1.7.0
	>=dev-libs/eina-1.7.0
	>=media-libs/elementary-1.7.0
	>=media-libs/evas-1.7.0"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_configure() {
	MY_ECONF="
		$(use_enable doc)
		"

	enlightenment_src_configure
}

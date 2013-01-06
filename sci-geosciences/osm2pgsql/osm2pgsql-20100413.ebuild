# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2pgsql/osm2pgsql-20100413.ebuild,v 1.7 2011/11/27 13:54:44 swegener Exp $

EAPI=4

inherit autotools

DESCRIPTION="Converts OSM data to SQL and insert into PostgreSQL db"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Osm2pgsql"
SRC_URI="http://gentoo.ccss.cz/${P}svn.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	app-arch/bzip2
	dev-libs/libxml2:2
	sci-libs/geos
	sci-libs/proj
	sys-libs/zlib
	dev-db/postgresql-base
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}

DOCS=( README.txt 900913.sql )

src_prepare() {
	eautoreconf
}

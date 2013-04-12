# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2pgsql/osm2pgsql-99999999.ebuild,v 1.8 2013/04/12 07:47:02 swegener Exp $

EAPI=4

inherit autotools git-2

EGIT_REPO_URI="git://github.com/openstreetmap/osm2pgsql.git"
EGIT_BOOTSTRAP="eautoreconf"

DESCRIPTION="Converts OSM data to SQL and insert into PostgreSQL db"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Osm2pgsql"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+pbf"

DEPEND="
	app-arch/bzip2
	dev-libs/libxml2:2
	sci-libs/geos
	sci-libs/proj
	sys-libs/zlib
	dev-db/postgresql-base
	pbf? ( dev-libs/protobuf-c )
"
RDEPEND="${DEPEND}"

DOCS=( README 900913.sql )

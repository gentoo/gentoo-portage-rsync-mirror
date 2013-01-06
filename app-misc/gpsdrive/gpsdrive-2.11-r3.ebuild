# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gpsdrive/gpsdrive-2.11-r3.ebuild,v 1.5 2012/11/04 17:30:58 ottxor Exp $

EAPI=4

inherit cmake-utils eutils fdo-mime flag-o-matic versionator

DESCRIPTION="GPS navigation system with NMEA and Garmin support, zoomable map display, waypoints, etc."
HOMEPAGE="http://www.gpsdrive.de/"
SRC_URI="${HOMEPAGE}/packages/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE="dbus debug kismet gdal mapnik scripts -speech"

COMMON_DEP="
	dev-db/sqlite:3
	dev-libs/libxml2:2
	net-misc/curl
	>=sci-geosciences/gpsd-2.96
	x11-libs/gtk+:2
	x11-libs/gdk-pixbuf:2
	dbus? ( dev-libs/dbus-glib )
	gdal? ( sci-libs/gdal )
	kismet? ( net-wireless/kismet )
	mapnik? (
		>=sci-geosciences/mapnik-0.7.0[postgres]
		>=dev-db/postgis-1.5.2
	)
	speech? ( >=app-accessibility/speech-dispatcher-0.6.7 )
"

DEPEND="${COMMON_DEP}
	virtual/pkgconfig
"

RDEPEND="${COMMON_DEP}
	media-fonts/dejavu
	sci-geosciences/openstreetmap-icons
	sci-geosciences/mapnik-world-boundaries
"

S=${WORKDIR}/${P/_/}

src_prepare() {
	# Get rid of the package's FindBoost.
	rm "${S}"/cmake/Modules/FindBoost.cmake

	# Update mapnik font path...
	sed -i \
		-e "s:truetype/ttf-dejavu:dejavu:g" \
		-e "s:mapnik/0.5:mapnik:g" \
		tests/gpsdriverc-in \
		src/gpsdrive_config.c || die "sed failed"

	# update OSM icon paths
	sed -i \
		-e "s:icons/map-icons:osm:g" \
		cmake/Modules/DefineInstallationPaths.cmake \
		scripts/osm/perl_lib/Geo/Gpsdrive/DB_Defaults.pm \
		scripts/osm/perl_lib/Geo/Gpsdrive/OSM.pm \
		src/gpsdrive_config.c \
		src/icons.c \
		|| die "sed failed"

	# Fix desktop file...
	sed -i -e "s:gpsicon:/usr/share/icons/gpsdrive.png:g" \
		-e "s:Graphics;Network;Geography:Education;Science;Geography;GPS:g" \
		data/gpsdrive.desktop || die "sed failed"

	epatch \
		"${FILESDIR}"/${P}_DefineOptions_gpsd.patch \
		"${FILESDIR}"/${P}-add-gdk-pixbuf2.patch \
		"${FILESDIR}"/${P}-gpsd-2.96.patch \
		"${FILESDIR}"/${P}-mapnik-2.0api.patch \
		"${FILESDIR}"/${P}-as-needed.patch
}

src_configure() {
	cat >> cmake/Modules/DefineProjectDefaults.cmake <<- _EOF_

		# set policy for new linker paths
		cmake_policy(SET CMP0003 NEW) # or cmake_policy(VERSION 2.6)
_EOF_

	if use mapnik ; then
		local PGINC="-DPOSTGRESQL_INCLUDE_DIR=$(pg_config --includedir)"
		elog "using PG include dir: ${PGINC}"
		append-flags -DBOOST_FILESYSTEM_VERSION=2
	fi

	local mycmakeargs=(
		$(cmake-utils_use_with scripts SCRIPTS)
		$(cmake-utils_use_with mapnik MAPNIK)
		$(cmake-utils_use_with mapnik POSTGIS)
		$(cmake-utils_use_with kismet KISMET)
		$(cmake-utils_use_with dbus DBUS)
		$(cmake-utils_use_with speech SPEECH)
		$(cmake-utils_use_with gdal GDAL)
		-DWITH_GDA3=OFF ${PGINC}
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc AUTHORS ChangeLog README \
		Documentation/{CREDITS.i18n,FAQ.gpsdrive,FAQ.gpsdrive.fr,LEEME} \
		Documentation/{LISEZMOI,NMEA.txt,LISEZMOI.kismet,TODO} \
		Documentation/README.{Bluetooth,lib_map,nasamaps,tracks,kismet}
	if use mapnik ; then
		dodoc Documentation/install-mapnik-osm.txt
	else
		rm -f "${ED}"usr/bin/gpsdrive_mapnik_gentiles.py
		rm -f "${ED}"usr/share/gpsdrive/osm-template.xml
	fi
	if use scripts ; then
		dodoc Documentation/README.gpspoint2gspdrive
		use gdal || rm -f "${ED}"usr/bin/{gdal_slice,nasaconv}.sh
	else
		rm -f "${ED}"usr/share/man/man1/gpsd_nmea.sh.1
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	elog
	elog "Be sure to see the README files in /usr/share/doc/${PF}"
	elog "for information on using Kismet with gpsdrive."
	elog
	if use mapnik ; then
		elog "Using mapnik to render online maps requires you to load"
		elog "data into the postgis database. Follow the instructions"
		elog "on http://wiki.openstreetmap.org/index.php/Mapnik"
	fi
	elog
	elog "This version also now depends on the gpsd package, and"
	elog "specific devices are supported there.  Start gpsd first,"
	elog "otherwise gpsdrive will only run in simulation mode (which"
	elog "is handy for downloading maps for another location, but"
	elog "not much else)."
	elog
	elog "openstreetmap-icons now installs to a more appropriate"
	elog "location, so if you have trouble starting gpsdrive, you"
	elog "should probably update your ~/.gpsdrive/gpsdriverc file"
	elog "and change the path to the geoinfofile to reflect this:"
	elog "   geoinfofile = /usr/share/osm/geoinfo.db"
	elog
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}

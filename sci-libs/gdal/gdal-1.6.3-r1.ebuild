# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.6.3-r1.ebuild,v 1.24 2012/05/19 20:01:03 ssuominen Exp $

EAPI=3

WANT_AUTOCONF="2.5"

RUBY_OPTIONAL="yes"
USE_RUBY="ruby18"

PYTHON_DEPEND="python? 2"

inherit autotools eutils perl-module python ruby toolchain-funcs

DESCRIPTION="Translator library for raster geospatial data formats (includes OGR support)"
HOMEPAGE="http://www.gdal.org/"
SRC_URI="http://download.osgeo.org/gdal/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="curl debug doc ecwj2k fits geos gif gml hdf hdf5 jpeg jpeg2k mysql netcdf odbc png ogdi perl postgres python ruby sqlite threads"

RDEPEND="
	dev-libs/expat
	media-libs/tiff:0
	sci-libs/libgeotiff
	sys-libs/zlib
	curl? ( net-misc/curl )
	jpeg? ( virtual/jpeg )
	gif? ( media-libs/giflib )
	png? ( media-libs/libpng )
	perl? ( dev-lang/perl )
	python? ( dev-python/numpy )
	ruby? ( >=dev-lang/ruby-1.8.4.20060226 )
	fits? ( sci-libs/cfitsio )
	ogdi? ( sci-libs/ogdi )
	gml? ( >=dev-libs/xerces-c-3 )
	hdf5? ( >=sci-libs/hdf5-1.6.4 )
	postgres? ( dev-db/postgresql-base )
	|| (
		netcdf? ( sci-libs/netcdf )
		hdf? ( sci-libs/hdf )
	)
	|| (
		jpeg2k? ( media-libs/jasper )
		ecwj2k? ( sci-libs/libecwj2 )
	)
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	geos? ( >=sci-libs/geos-2.2.1 )
	sqlite? ( >=dev-db/sqlite-3 )"

DEPEND="${RDEPEND}
	perl? ( >=dev-lang/swig-1.3.32 )
	python? ( >=dev-lang/swig-1.3.32 )
	ruby? ( >=dev-lang/swig-1.3.32 )
	doc? ( app-doc/doxygen )"

AT_M4DIR="${S}/m4"

pkg_setup() {
	if [ -n "${GDAL_CONFIGURE_OPTS}" ]; then
		elog "User-specified configure options are ${GDAL_CONFIGURE_OPTS}."
	else
		elog "User-specified configure options are not set."
		elog "If needed, set GDAL_CONFIGURE_OPTS to enable grass support."
	fi
	python_set_active_version 2
}

src_prepare() {
	eaclocal
	eautoconf

	epatch \
		"${FILESDIR}"/${PN}-1.4.2-datadir.patch \
		"${FILESDIR}"/${PN}-1.5.1-python-install.patch \
		"${FILESDIR}"/${PN}-1.6.0-swig-fix.patch \
		"${FILESDIR}"/${PN}-1.6.1-ruby-make.patch \
		"${FILESDIR}"/${PN}-1.6.3-libpng15.patch

	[[ ${CHOST} == *-darwin* ]] \
		&& epatch "${FILESDIR}"/${PN}-1.5.0-install_name.patch \
		|| epatch "${FILESDIR}"/${PN}-1.5.0-soname.patch

	has_version '>=sys-libs/zlib-1.2.5.1-r1' && \
		sed -i -e '1i#define OF(x) x' port/cpl_minizip_ioapi.h
}

src_configure() {
	local pkg_conf="${GDAL_CONFIGURE_OPTS}"
	local use_conf=""

	pkg_conf="${pkg_conf} --enable-shared=yes --with-pic \
		--with-libgrass=no --without-libtool --with-expat=${EPREFIX}/usr"

	if use hdf && use netcdf; then
		ewarn "Netcdf and HDF4 are incompatible due to certain tools in"
		ewarn "common; HDF5 is now the preferred choice for HDF data."
		ewarn "Disabling hdf4 in favor of NetCDF..."
		use_conf="--with-netcdf --with-hdf4=no"
	elif use hdf && ! use netcdf; then
		use_conf="--with-netcdf=no --with-hdf4"
	else
		use_conf="$(use_with netcdf)"
	fi

	use_conf="$(use_with jpeg) $(use_with png) $(use_with mysql) \
	 $(use_with gml xerces) $(use_with hdf5) $(use_with curl) \
	 $(use_with postgres pg) $(use_with python) $(use_with ruby) \
	 $(use_with threads) $(use_with fits cfitsio) $(use_with perl) \
	 $(use_with sqlite sqlite3 ="${EPREFIX}"/usr) $(use_with geos) \
	 $(use_with jpeg2k jasper) $(use_with odbc) $(use_enable debug)"

	# It can't find this
	if use ogdi ; then
		use_conf="--with-ogdi=${EPREFIX}/usr ${use_conf}"
	fi

	if use mysql ; then
		use_conf="--with-mysql=${EPREFIX}/usr/bin/mysql_config ${use_conf}"
	fi

	if use gif ; then
		use_conf="--with-gif=internal ${use_conf}"
	else
		use_conf="--with-gif=no ${use_conf}"
	fi

	if use python ; then
		use_conf="--with-pymoddir=${EPREFIX}/$(python_get_sitedir) \
		${use_conf}"
	fi

	# Fix doc path just in case
	sed \
		-e "s:@exec_prefix@/doc:@exec_prefix@/share/doc/${PF}/html:g" \
		-i GDALmake.opt.in || die "sed gdalmake.opt failed"

	econf ${pkg_conf} ${use_conf}

	# mysql-config puts this in (and boy is it a PITA to get it out)
	sed \
	 -i -r -e '/^LDFLAGS/ s/(-(Wl|O1),|,-(Wl|O1))//g' \
	 -i -e '/^MYSQL_LIB/ s:-Wl,-O1 -rdynamic::' \
	 GDALmake.opt || die "sed LIBS failed"
}

src_compile() {
	local i
	for i in perl ruby python; do
		if use $i; then
			rm "${S}"/swig/$i/*_wrap.cpp
			emake -C "${S}"/swig/$i generate || \
				die "make generate failed for swig/$i"
		fi
	done

	# parallel makes fail on the ogr stuff (C++, what can I say?)
	# also failing with gcc4 in libcsf
	emake -j1 || die "emake failed"

	if use python; then
	 sed -i -e "s#library_dirs = #library_dirs = ${EPREFIX}/usr/$(get_libdir):#g" \
		swig/python/setup.cfg || die "sed python setup.cfg failed"
	 sed -i -e "s:\$(DESTDIR)\$(prefix):\$(DESTDIR)\$(INST_PREFIX):g" \
		swig/python/GNUmakefile || die "sed python makefile failed"
	fi

	if use perl ; then
		cd "${S}"/swig/perl
		perl-module_src_prep
		perl-module_src_compile
		cd "${S}"
	fi

	if use doc ; then
		make docs || die "make docs failed"
	fi
}

src_install() {
	if use perl ; then
		cd "${S}"/swig/perl
		perl-module_src_install
		sed -i -e "s:BINDINGS = python ruby perl:BINDINGS = python ruby:g" \
		GDALmake.opt
		cd "${S}"
	fi

	# einstall causes sandbox violations on /usr/lib/libgdal.so
	emake DESTDIR="${D}" install \
	 || die "make install failed"

	dodoc Doxyfile HOWTO-RELEASE NEWS

	if use doc ; then
		dohtml html/* || die "install html failed"
		docinto ogr
		dohtml ogr/html/* || die "install ogr html failed"
	fi

	if use python; then
	 newdoc swig/python/README.txt README-python.txt
	 dodir /usr/share/${PN}/samples
	 insinto /usr/share/${PN}/samples
	 doins swig/python/samples/*
	fi

	use perl && fixlocalpod
}

pkg_postinst() {
	echo
	elog "If you need libgrass support, then you must rebuild gdal, after"
	elog "installing the latest Grass, and set the following option:"
	echo
	elog "GDAL_CONFIGURE_OPTS=--with-grass=\$GRASS_HOME emerge gdal"
	echo
	elog "GDAL is most useful with full graphics support enabled via various"
	elog "USE flags: png, jpeg, gif, jpeg2k, etc. Also python, fits, ogdi,"
	elog "geos, and support for either netcdf or HDF4 is available, as well as"
	elog "grass, and mysql, sqlite, or postgres (grass support requires grass 6"
	elog "and rebuilding gdal). HDF5 support is now included."
	echo
	elog "Note: tiff and geotiff are now hard depends, so no USE flags."
	elog "Also, this package will check for netcdf before hdf, so if you"
	elog "prefer hdf, please emerge hdf with USE=szip prior to emerging"
	elog "gdal. Detailed API docs require doxygen (man pages are free)."
	echo
	elog "Check available image and data formats after building with"
	elog "gdalinfo and ogrinfo (using the --formats switch)."
	echo
}

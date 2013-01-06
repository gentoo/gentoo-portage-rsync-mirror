# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gdal/gdal-1.8.1-r1.ebuild,v 1.5 2012/06/05 21:08:15 ranger Exp $

EAPI=3

WANT_AUTOCONF="2.5"

RUBY_OPTIONAL="yes"
USE_RUBY="ruby18"

PYTHON_DEPEND="python? 2:2.6"

inherit autotools eutils libtool perl-module python ruby-ng toolchain-funcs

DESCRIPTION="Translator library for raster geospatial data formats (includes OGR support)"
HOMEPAGE="http://www.gdal.org/"
SRC_URI="http://download.osgeo.org/gdal/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="+aux_xml curl debug doc ecwj2k fits geos gif gml hdf5 jpeg jpeg2k mysql netcdf odbc ogdi pdf perl png postgres python ruby sqlite threads"

RDEPEND="
	dev-libs/expat
	media-libs/tiff
	sci-libs/libgeotiff
	( || ( <sys-libs/zlib-1.2.5.1-r1 >=sys-libs/zlib-1.2.5.1-r2[minizip] ) )
	curl? ( net-misc/curl )
	ecwj2k? ( sci-libs/libecwj2 )
	fits? ( sci-libs/cfitsio )
	geos?   ( >=sci-libs/geos-2.2.1 )
	gif? ( media-libs/giflib )
	gml? ( >=dev-libs/xerces-c-3 )
	hdf5? ( >=sci-libs/hdf5-1.6.4[szip] )
	jpeg? ( virtual/jpeg )
	jpeg2k? ( media-libs/jasper )
	mysql? ( virtual/mysql )
	netcdf? ( sci-libs/netcdf )
	odbc?   ( dev-db/unixODBC )
	ogdi? ( sci-libs/ogdi )
	pdf? ( app-text/poppler )
	perl? ( dev-lang/perl )
	png? ( media-libs/libpng )
	postgres? ( >=dev-db/postgresql-base-8.4 )
	python? ( dev-python/numpy )
	ruby? ( $(ruby_implementation_depend ruby18) )
	sqlite? ( >=dev-db/sqlite-3 )"

SWIG_DEP=">=dev-lang/swig-2.0.2"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	perl? ( ${SWIG_DEP} )
	python? ( ${SWIG_DEP} )
	ruby? ( ${SWIG_DEP} )"

AT_M4DIR="${S}/m4"
MAKEOPTS+=" -j1"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
}

src_unpack() {
	# prevent ruby-ng.eclass from messing with the src path
	default
}

src_prepare() {
	# fix datadir and docdir placement
	sed -i \
		-e "s:@datadir@:@datadir@/gdal:" \
		-e "s:@exec_prefix@/doc:@exec_prefix@/share/doc/${PF}/html:g" \
		GDALmake.opt.in || die

	# the second sed expression should fix bug 371075
	sed -i \
		-e "s:setup.py install:setup.py install --root=\$(DESTDIR):" \
		-e "s:--prefix=\$(DESTDIR):--prefix=:" \
		swig/python/GNUmakefile || die

	epatch "${FILESDIR}"/1.7.2-ruby_cflags.patch

	# -soname is only accepted by GNU ld/ELF
	[[ ${CHOST} == *-darwin* ]] \
		&& epatch "${FILESDIR}"/${PN}-1.5.0-install_name.patch \
		|| epatch "${FILESDIR}"/${PN}-1.5.0-soname.patch

	# Update for zlib header changes (see bug #383569)
	epatch "${FILESDIR}"/${P}-zlib_header_fix.patch

	# Fix ldflags when building with ruby
	sed -e '/^LDFLAGS/s/-Xcompiler//' -i swig/ruby/RubyMakefile.mk || die

	# autoheader fail
	eaclocal
	eautoconf
	eautomake
	elibtoolize
}

src_configure() {
	if use ruby; then
		RUBY_MOD_DIR="$(ruby18 -r rbconfig -e 'print Config::CONFIG["sitearchdir"]')"
		echo "Ruby module dir is: $RUBY_MOD_DIR"
	fi

	# pcidsk is internal, because there is no such library yet released
	#     also that thing is developed by the gdal people
	# kakadu, mrsid jp2mrsid - another jpeg2k stuff, ignore
	# bsb - legal issues
	# oracle - disabled, i dont have and can't test
	# ingres - same story as oracle oci
	# tiff is a hard dep
	econf \
		--enable-shared \
		--disable-static \
		--with-expat \
		--without-grass \
		--without-hdf4 \
		--without-fme \
		--without-pcraster \
		--without-kakadu \
		--without-mrsid \
		--without-jp2mrsid \
		--without-msg \
		--without-bsb \
		--without-dods-root \
		--without-oci \
		--without-ingres \
		--without-spatialite \
		--without-dwgdirect \
		--without-epsilon \
		--without-idb \
		--without-sde \
		--without-libtool \
		--with-libz="${EPREFIX}/usr/" \
		--with-ogr \
		--with-grib \
		--with-vfk \
		--with-libtiff=external \
		--with-geotiff=external \
		$(use_enable debug) \
		$(use_with postgres pg) \
		$(use_with fits cfitsio) \
		$(use_with netcdf) \
		$(use_with png) \
		$(use_with jpeg) \
		$(use_with jpeg pcidsk) \
		$(use_with gif) \
		$(use_with ogdi ogdi "${EPREFIX}"/usr) \
		$(use_with hdf5) \
		$(use_with jpeg2k jasper) \
		$(use_with ecwj2k ecw) \
		$(use_with gml xerces) \
		$(use_with odbc) \
		$(use_with curl) \
		$(use_with sqlite sqlite3 "${EPREFIX}"/usr) \
		$(use_with mysql mysql "${EPREFIX}"/usr/bin/mysql_config) \
		$(use_with geos) \
		$(use_with aux_xml pam) \
		$(use_with pdf poppler) \
		$(use_with perl) \
		$(use_with ruby) \
		$(use_with python) \
		$(use_with threads) \
		--with-pymoddir="${EPREFIX}"/$(python_get_sitedir)

	# mysql-config puts this in (and boy is it a PITA to get it out)
	if use mysql; then
		sed -i \
			-e "s: -rdynamic : :" \
			GDALmake.opt || die "sed LIBS failed"
	fi

	# updated for newer swig (must specify the path to input files)
	if use python; then
		sed -i \
			-e "s: gdal_array.i: ../include/gdal_array.i:" \
			-e "s:\$(DESTDIR)\$(prefix):\$(DESTDIR)\$(INST_PREFIX):g" \
			swig/python/GNUmakefile || die "sed python makefile failed"
		sed -i \
			-e "s:library_dirs = :library_dirs = /usr/$(get_libdir):g" \
			swig/python/setup.cfg || die "sed python setup.cfg failed"
	fi
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

	emake || die "emake failed"

	if use perl ; then
		pushd "${S}"/swig/perl > /dev/null
		perl-module_src_prep
		perl-module_src_compile
		popd > /dev/null
	fi

	if use doc ; then
		emake docs || die "make docs failed"
	fi
}

src_install() {
	if use perl ; then
		pushd "${S}"/swig/perl > /dev/null
		perl-module_src_install
		popd > /dev/null
		sed -i \
			-e "s:BINDINGS        =       python ruby perl:BINDINGS        =       python ruby:g" \
			GDALmake.opt || die
	fi

	emake DESTDIR="${D}" install || die "make install failed"

	if use ruby ; then
		# weird reinstall collision; needs manual intervention...
		pushd "${S}"/swig/ruby > /dev/null
		rm -rf "${D}"${RUBY_MOD_DIR}/gdal
		exeinto ${RUBY_MOD_DIR}/gdal
		doexe *.so || die "doins ruby modules failed"
		popd > /dev/null
	fi

	use perl && fixlocalpod

	dodoc Doxyfile HOWTO-RELEASE NEWS || die

	if use doc ; then
		dohtml html/* || die "install html failed"
		docinto ogr
		dohtml ogr/html/* || die "install ogr html failed"
	fi

	if use python; then
		newdoc swig/python/README.txt README-python.txt || die
		insinto /usr/share/${PN}/samples
		doins swig/python/samples/* || die
	fi
}

pkg_postinst() {
	if use python; then
		python_need_rebuild
		python_mod_optimize osgeo
	fi
	echo
	elog "Check available image and data formats after building with"
	elog "gdalinfo and ogrinfo (using the --formats switch)."
}

pkg_postrm() {
	if use python; then
		python_mod_cleanup osgeo
	fi
}

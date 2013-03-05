# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povray/povray-3.7.0_rc3.ebuild,v 1.12 2013/03/05 01:34:02 ottxor Exp $

EAPI="3"

inherit autotools eutils flag-o-matic versionator

POVRAY_MAJOR_VER=$(get_version_component_range 1-3)
POVRAY_MINOR_VER=$(get_version_component_range 4)
if [ -n "$POVRAY_MINOR_VER" ]; then
	POVRAY_MINOR_VER=${POVRAY_MINOR_VER/rc/RC}
	MY_PV="${POVRAY_MAJOR_VER}.${POVRAY_MINOR_VER}"
else
	MY_PV=${POVRAY_MAJOR_VER}
fi

DESCRIPTION="The Persistence of Vision Raytracer"
HOMEPAGE="http://www.povray.org/"
SRC_URI="http://www.povray.org/redirect/www.povray.org/beta/source/${PN}-${MY_PV}.tar.bz2"

LICENSE="povlegal-3.6"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="debug openexr tiff X"

DEPEND="
	>=dev-libs/boost-1.41
	virtual/jpeg
	media-libs/libpng:0
	sys-libs/zlib
	openexr? (
		media-libs/ilmbase
		media-libs/openexr )
	tiff? ( >=media-libs/tiff-3.6.1:0 )
	X? ( media-libs/libsdl )"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	# Change some destination directories that cannot be adjusted via configure
	cp configure.ac configure.ac.orig
	sed \
		-e 's:${povsysconfdir}/$PACKAGE/$VERSION_BASE:${povsysconfdir}/'${PN}':g' \
		-e 's:${povdatadir}/$PACKAGE-$VERSION_BASE:${povdatadir}/'${PN}':g' \
		-e 's:${povdatadir}/doc/$PACKAGE-$VERSION_BASE:${povdatadir}/doc/'${PF}':g' \
		-i configure.ac || die

	cp Makefile.am Makefile.am.orig
	sed \
		-e "s:^povlibdir = .*:povlibdir = @datadir@/${PN}:" \
		-e "s:^povdocdir = .*:povdocdir = @datadir@/doc/${PF}:" \
		-e "s:^povconfdir = .*:povconfdir = @sysconfdir@/${PN}:" \
		-i Makefile.am || die

	# The "+p" option on the test command line causes a pause and
	# prompts the user to interact, so remove it.
	sed -i -e "s:biscuit.pov -f +d +p:biscuit.pov -f +d:" Makefile.am || die

	epatch "${FILESDIR}"/${PV}-user-conf.patch

	eautoreconf
}

src_configure() {
	local non_redist_conf

	# Fixes bug 71255
	if [[ $(get-flag march) == k6-2 ]]; then
		filter-flags -fomit-frame-pointer
	fi

	# The config files are installed correctly (e.g. povray.conf),
	# but the code compiles using incorrect [default] paths
	# (based on /usr/local...), so povray will not find the system
	# config files without the following fix:
	append-flags -DPOVLIBDIR=\\\"${EROOT}usr/share/${PN}\\\"
	append-flags -DPOVCONFDIR=\\\"${EROOT}etc/${PN}\\\"

	#460238, included in the patch for povray-3.7.0_rc6
	has_version ">=dev-libs/boost-1.52" && \
		append-flags "-lboost_system" "-lboost_date_time" "-DTIME_UTC=TIME_UTC_"

	if ! use tiff ; then
		non_redist_conf="NON_REDISTRIBUTABLE_BUILD=yes"
	else
		non_redist_conf=""
	fi

	econf \
		${non_redist_conf} \
		COMPILED_BY="Portage (Gentoo `uname`) on `hostname -f`" \
		$(use_enable debug) \
		$(use_with openexr) \
		--without-libmkl \
		$(use_with tiff libtiff) \
		$(use_with X libsdl) \
		$(use_with X x) \
		--disable-strip \
		--disable-optimiz \
		--disable-optimiz-arch \
		--with-boost-libdir="${EPREFIX}/usr/$(get_libdir)"
}

src_test() {
	# For the beta releases, we generate a license extension in case needed
	POVRAY_BETA=`./unix/povray --betacode 2>&1` emake check || die "Test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_preinst() {
	# Copy the old config files if they are in the old location
	# but do not yet exist in the new location.
	# This way, they can be treated by CONFIG_PROTECT as normal.
	for conf_file in $(ls "${ED}/etc/${PN}"); do
		if [ ! -e "${EROOT}etc/${PN}/${conf_file}" ]; then
			for version_dir in $(ls "${EROOT}etc/${PN}" | grep "^[0-9]" | sort -rn); do
				if [ -e "${EROOT}etc/${PN}/${version_dir}/${conf_file}" ]; then
					mv "${EROOT}etc/${PN}/${version_dir}/${conf_file}" "${EROOT}etc/${PN}"
					elog "Note: ${conf_file} moved from ${EROOT}etc/povray/${version_dir}/ to ${EROOT}etc/povray/"
					break
				fi
			done
		fi
	done
}

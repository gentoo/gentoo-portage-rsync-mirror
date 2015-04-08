# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povray/povray-3.7.0_rc6.ebuild,v 1.6 2013/03/05 01:34:02 ottxor Exp $

EAPI=4

inherit autotools eutils flag-o-matic versionator multilib

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
SRC_URI="http://www.povray.org/redirect/www.povray.org/beta/source/${PN}-${MY_PV}.tar.gz"

LICENSE="povlegal-3.6"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="debug mkl openexr tiff X"

DEPEND="
	>=dev-libs/boost-1.50.0[threads(+)]
	media-libs/libpng:0
	sys-libs/zlib
	virtual/jpeg
	mkl? ( sci-libs/mkl )
	openexr? (
		media-libs/ilmbase
		media-libs/openexr )
	tiff? ( media-libs/tiff:0 )
	X? ( media-libs/libsdl )"
RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
	sys-devel/boost-m4"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/3.7.0_rc3-user-conf.patch \
		"${FILESDIR}"/${PN}-3.7.0_rc5+boost-1.50.patch \
		"${FILESDIR}"/${PN}-3.7.0_rc5-automagic.patch

	[[ ${CHOST} == *-darwin* ]] && \
		epatch "${FILESDIR}"/${PN}-3.7.0_rc6-darwin-defaults.patch

	# Change some destination directories that cannot be adjusted via configure
	sed \
		-e 's:${povsysconfdir}/$PACKAGE/$VERSION_BASE:${povsysconfdir}/'${PN}':g' \
		-e 's:${povdatadir}/$PACKAGE-$VERSION_BASE:${povdatadir}/'${PN}':g' \
		-e 's:${povdatadir}/doc/$PACKAGE-$VERSION_BASE:${povdatadir}/doc/'${PF}':g' \
		-e 's:BOOST_THREAD_LIBS $LIBS:BOOST_THREAD_LIBS $LIBS -lboost_date_time:g' \
		-i configure.ac || die

	sed \
		-e "s:^povlibdir = .*:povlibdir = @datadir@/${PN}:" \
		-e "s:^povdocdir = .*:povdocdir = @datadir@/doc/${PF}:" \
		-e "s:^povconfdir = .*:povconfdir = @sysconfdir@/${PN}:" \
		-e 's:mkdir_p:MKDIR_P:g' \
		-i Makefile.am || die

	# The "+p" option on the test command line causes a pause and
	# prompts the user to interact, so remove it.
	sed -i -e "s:biscuit.pov -f +d +p:biscuit.pov -f +d:" Makefile.am || die

	epatch_user

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
	append-cppflags -DPOVLIBDIR=\\\"${EROOT}usr/share/${PN}\\\" -DPOVCONFDIR=\\\"${EROOT}etc/${PN}\\\"

	if ! use tiff ; then
		non_redist_conf="NON_REDISTRIBUTABLE_BUILD=yes"
	else
		non_redist_conf=""
	fi

	econf \
		${non_redist_conf} \
		COMPILED_BY="Portage (Gentoo `uname`) on `hostname -f`" \
		$(use_enable debug) \
		$(use_with openexr openexr "${EPREFIX}/usr/$(get_libdir)") \
		$(use_with mkl libmkl "${EPREFIX}/usr/$(get_libdir)") \
		$(use_with tiff libtiff "${EPREFIX}/usr/$(get_libdir)") \
		$(use_with X libsdl "${EPREFIX}/usr/$(get_libdir)") \
		$(use_with X x "${EPREFIX}/usr/$(get_libdir)") \
		--disable-strip \
		--disable-optimiz \
		--disable-optimiz-arch
}

src_test() {
	# For the beta releases, we generate a license extension in case needed
	POVRAY_BETA=`./unix/povray --betacode 2>&1` emake check
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

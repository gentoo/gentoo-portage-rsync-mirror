# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icedtea-web/icedtea-web-1.3.2.ebuild,v 1.1 2013/07/23 21:08:15 caster Exp $
# Build written by Andrew John Hughes (ahughes@redhat.com)

EAPI="4"

inherit autotools eutils java-pkg-2 java-vm-2

DESCRIPTION="FOSS Java browser plugin and Web Start implementation"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="http://icedtea.classpath.org/download/source/${P}.tar.gz"

LICENSE="GPL-2 GPL-2-with-linking-exception LGPL-2"
SLOT="6"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~x86"

IUSE="build doc javascript +nsplugin test"

COMMON_DEP="
	dev-java/icedtea:${SLOT}
	nsplugin? (
		>=dev-libs/glib-2.16
	)"
RDEPEND="${COMMON_DEP}"
# Need system junit 4.8+. Bug #389795
DEPEND="${COMMON_DEP}
	virtual/pkgconfig
	javascript? ( dev-java/rhino:1.6 )
	nsplugin? ( net-misc/npapi-sdk )
	test? (	>=dev-java/junit-4.8:4 )"

pkg_setup() {
	JAVA_PKG_WANT_BUILD_VM="icedtea-${SLOT} icedtea${SLOT}"
	JAVA_PKG_WANT_SOURCE="1.6"
	JAVA_PKG_WANT_TARGET="1.6"

	java-vm-2_pkg_setup
	java-pkg-2_pkg_setup

	VMHANDLE="icedtea-${SLOT}"
}

src_prepare() {
	# bug #356645
	epatch "${FILESDIR}"/0002-Respect-LDFLAGS.patch
	epatch "${FILESDIR}"/${P}-openjdk-build-25.patch
	eautoreconf
}

src_configure() {
	local vmhome=$(java-config -O)

	if use build; then
		icedteadir="${ICEDTEA_BIN_DIR}"
		[[ -z ${icedteadir} ]] && die "USE=build is an internal flag and should not be enabled"
		installdir="/opt/icedtea-web-bin-${SLOT}"
	else
		icedteadir="/usr/$(get_libdir)/icedtea${SLOT}"
		installdir="/usr/$(get_libdir)/icedtea${SLOT}-web"
		[[ "${vmhome}" == "${icedteadir}" ]] \
			|| die "Unexpected install location of IcedTea ${SLOT} '${vmhome}'"
	fi

	einfo "Installing IcedTea-Web in '${installdir}'"
	einfo "Installing IcedTea-Web for IcedTea${SLOT} in '${icedteadir}'"

	local myconf=(
		# we need to override all *dir variables that econf sets.
		# man page (javaws) is installed directly to icedteadir because it's
		# easier than symlinking, as we don't know the suffix the man page will
		# end up compressed with, anyway
		--prefix="${installdir}"
		--mandir="${icedteadir}"/man
		--infodir="${installdir}"/share/info
		--datadir="${installdir}"/share
		--with-jdk-home="${icedteadir}"
		$(use_enable doc docs)
		$(use_enable nsplugin plugin)
		$(use_with javascript rhino)
	)

	unset JAVA_HOME JDK_HOME CLASSPATH JAVAC JAVACFLAGS
	econf "${myconf[@]}"
}

src_compile() {
	# we need this to override the src_compile from java-pkg-2
	default
}

src_install() {
	# bug #440906
	MAKEOPTS+=" -j1" default

	if use nsplugin; then
		install_mozilla_plugin "${installdir}/$(get_libdir)/IcedTeaPlugin.so";
	fi

	for binary in javaws itweb-settings; do
		dosym ${installdir}/bin/${binary} ${icedteadir}/bin/${binary}
		dosym ${installdir}/bin/${binary} ${icedteadir}/jre/bin/${binary}
	done
}

pkg_postinst() {
	java-vm_check-nsplugin
	java_mozilla_clean_

	if use nsplugin; then
		elog "The icedtea browser plugin (NPPlugin) can be enabled using eselect java-nsplugin"
	fi
}

pkg_prerm() {
	# override the java-vm-2 eclass check for removing a system VM, as it
	# doesn't make sense here.
	:;
}

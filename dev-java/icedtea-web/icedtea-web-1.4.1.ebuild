# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/icedtea-web/icedtea-web-1.4.1.ebuild,v 1.1 2013/10/25 04:36:59 sera Exp $
# Build written by Andrew John Hughes (ahughes@redhat.com)

EAPI="5"

inherit autotools eutils readme.gentoo java-pkg-2 java-vm-2

DESCRIPTION="FOSS Java browser plugin and Web Start implementation"
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="http://icedtea.classpath.org/download/source/${P}.tar.gz"

LICENSE="GPL-2 GPL-2-with-linking-exception LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="doc javascript +nsplugin test"

COMMON_DEP="
	|| (
		dev-java/icedtea:7 dev-java/icedtea-bin:7
		dev-java/icedtea:6 dev-java/icedtea-bin:6
	)
	app-admin/eselect-java
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

# http://mail.openjdk.java.net/pipermail/distro-pkg-dev/2010-December/011221.html
pkg_setup() {
	JAVA_PKG_WANT_BUILD_VM="icedtea-7 icedtea-bin-7 icedtea-6 icedtea-bin-6"
	JAVA_PKG_WANT_SOURCE="1.6"
	JAVA_PKG_WANT_TARGET="1.6"

	java-pkg-2_pkg_setup
	java-vm-2_pkg_setup
}

src_prepare() {
	epatch "${FILESDIR}"/0001-Fix-parallel-install.-BGO-440906.patch
	epatch "${FILESDIR}"/0002-Respect-LDFLAGS.patch # bug #356645
	eautoreconf
}

src_configure() {
	local config=(
		# javaws is managed by eselect java-vm and symlinked to by icedtea so
		# move it out of the way and symlink itweb-settings back to bin
		--bindir="${EPREFIX}"/usr/libexec/${PN}
		--with-jdk-home="${JAVA_HOME}"
		$(use_enable doc docs)
		$(use_enable nsplugin plugin)
		$(use_with javascript rhino)
	)

	unset JAVA_HOME JDK_HOME CLASSPATH JAVAC JAVACFLAGS
	econf "${config[@]}"
}

src_compile() {
	default
}

src_install() {
	default

	if use nsplugin; then
		install_mozilla_plugin "/usr/$(get_libdir)/IcedTeaPlugin.so"
	fi

	mkdir -p "${ED}"/usr/bin || die
	dosym /usr/libexec/${PN}/itweb-settings /usr/bin/itweb-settings || die

	# Should we patch system default lookup instead?
	mkdir -p "${ED}"/etc/.java/deployment/ || die
	echo "deployment.jre.dir=/etc/java-config-2/current-icedtea-web-vm" \
		> "${ED}"/etc/.java/deployment/deployment.properties || die

	readme.gentoo_create_doc
}

pkg_postinst() {
	java-vm_check-nsplugin
	java_mozilla_clean_
	readme.gentoo_print_elog
}

pkg_prerm() {
	# override the java-vm-2 eclass check for removing a system VM, as it
	# doesn't make sense here.
	:;
}

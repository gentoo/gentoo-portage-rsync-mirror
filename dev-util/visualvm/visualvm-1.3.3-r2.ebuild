# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/visualvm/visualvm-1.3.3-r2.ebuild,v 1.1 2012/05/01 09:01:07 sera Exp $

EAPI="4"

inherit eutils autotools

VISUALVM_PKG="visualvm_harness-1.3"
VISUALVM_TARBALL="visualvm_133-src.tar.gz"
NETBEANS_PROFILER_TARBALL="netbeans-profiler-visualvm_release701.tar.gz"

DESCRIPTION="Integrates commandline JDK tools and profiling capabilites."
HOMEPAGE="http://icedtea.classpath.org"
SRC_URI="
	http://icedtea.classpath.org/download/visualvm/${VISUALVM_PKG}.tar.gz
	http://icedtea.classpath.org/download/visualvm/${VISUALVM_TARBALL}
	http://icedtea.classpath.org/download/visualvm/${NETBEANS_PROFILER_TARBALL}"

LICENSE="GPL-2-with-linking-exception"
SLOT="6"
KEYWORDS="~amd64"
IUSE=""

COMMON_DEP="
	dev-java/icedtea:${SLOT}
	dev-java/netbeans-harness:7.1
	dev-java/netbeans-platform:7.1"
RDEPEND="${COMMON_DEP}"
DEPEND="${COMMON_DEP}
	dev-java/ant-core
	dev-java/ant-nodeps"

S="${WORKDIR}/${VISUALVM_PKG}"

src_unpack() {
	unpack ${VISUALVM_PKG}.tar.gz
}

src_prepare() {
	epatch "${FILESDIR}"/netbeans-platform-version.patch
	eautoreconf

	unset JAVA_HOME JDK_HOME CLASSPATH JAVAC JAVACFLAGS

	export ANT_RESPECT_JAVA_HOME=TRUE
	export ANT_TASKS=ant-nodeps
}

src_configure() {
	local vmhome
	vmhome=$(get_vmhome) || die

	econf NB_PLATFORM=platform \
		--bindir="${vmhome}"/bin \
		--libdir="${vmhome}"/lib \
		--sysconfdir="${vmhome}"/lib/visualvm/etc \
		--with-netbeans-profiler-zip="${DISTDIR}"/${NETBEANS_PROFILER_TARBALL} \
		--with-visualvm-zip="${DISTDIR}"/${VISUALVM_TARBALL} \
		--with-visualvm-version=${PV} \
		--with-netbeans-home="${EPREFIX}"/usr/share/netbeans-nb-7.1 \
		--with-jdk-home="${vmhome}"
}

src_install() {
	emake DESTDIR="${D}" install

	# Don't install default .desktop, file collision.
	local vmhome
	vmhome=$(get_vmhome) || die
	rm -r "${ED}"/usr/share || die
	make_desktop_entry "${vmhome}/bin/jvisualvm" "OpenJDK ${SLOT} VisualVM" "java" "Development;Java;"
}

get_vmhome() {
	local vmhandle=icedtea-${SLOT}
	has_version "<=dev-java/icedtea-6.1.10.4:6" && vmhandle=icedtea6

	local vmhome
	vmhome="$(GENTOO_VM=${vmhandle} java-config -O)" || return 1

	echo "${vmhome}"
}

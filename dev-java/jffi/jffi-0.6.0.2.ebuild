# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jffi/jffi-0.6.0.2.ebuild,v 1.2 2012/08/25 19:09:47 thev00d00 Exp $

# Probably best to leave the CFLAGS as they are here. See...
# http://weblogs.java.net/blog/kellyohair/archive/2006/01/compilation_of_1.html

EAPI="2"
JAVA_PKG_IUSE="source test"
WANT_ANT_TASKS="ant-nodeps"
inherit java-pkg-2 java-ant-2 toolchain-funcs flag-o-matic

DESCRIPTION="An optimized Java interface to libffi"
HOMEPAGE="http://kenai.com/projects/jffi"
SRC_URI="mirror://gentoo//${P}.tar.bz2"
LICENSE="LGPL-3"
SLOT="0.4"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5
	virtual/libffi"

DEPEND=">=virtual/jdk-1.5
	virtual/libffi
	test? ( dev-java/ant-junit4 )"

JAVA_PKG_BSFIX_NAME="build-impl.xml"

java_prepare() {
	# Delete the bundled JARs.
	find lib -name "*.jar" -delete || die
	# Delete the bundled libffi
	rm -rf jni/libffi || die

	# bug #271533 and #272058
	epatch "${FILESDIR}/${PV}-makefile-flags.patch"

	# bug #272058
	append-cflags $(pkg-config --cflags-only-I libffi)

	# any better function for this, excluding get_system_arch in java-vm-2 which is incorrect to inherit ?
	local arch=""
	use x86 && arch="i386"
	use amd64 && arch="x86_64"
	use ppc && arch="ppc"

	# Fetch our own prebuilt libffi.
	mkdir -p "build/jni/libffi-${arch}-linux/.libs" || die

	ln -snf "/usr/$(get_libdir)/libffi.so" \
		"build/jni/libffi-${arch}-linux/.libs/libffi_convenience.a" || die

	# Don't include prebuilt files for other archs.
	sed -i '/<zipfileset src="archive\//d' custom-build.xml || die
	sed -i '/libs.CopyLibs.classpath/d' lib/nblibraries.properties || die
	sed -i '/copylibstask.jar/d' lib/nblibraries.properties || die

	# Fix build with GCC 4.7 #421501
	sed -i -e "s|-mimpure-text||g" jni/GNUmakefile || die
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use source && java-pkg_dosrc src/*
}

src_test() {
	ANT_TASKS="ant-junit4 ant-nodeps" eant test \
		-Dlibs.junit_4.classpath="$(java-pkg_getjars --with-dependencies junit-4)"
}

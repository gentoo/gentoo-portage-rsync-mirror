# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/joda-time/joda-time-1.5.2.ebuild,v 1.2 2009/02/04 21:44:25 maekke Exp $

JAVA_PKG_IUSE="doc examples source test"

inherit java-pkg-2 java-ant-2

MY_P="${P}-src"

DESCRIPTION="A quality open-source replacement for the Java Date and Time classes."
HOMEPAGE="http://joda-time.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

COMMON_DEP="elibc_glibc? ( >=sys-libs/timezone-data-2007h ) "

DEPEND="
	>=virtual/jdk-1.4
	test? ( dev-java/ant-junit )
	${COMMON_DEP}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -v *.jar || die
	# https://sourceforge.net/tracker/index.php?func=detail&aid=1855430&group_id=97367&atid=617889
	epatch "${FILESDIR}/1.5.1-ecj.patch"
}

# chokes on static inner class making instance of non-static inner class
EANT_FILTER_COMPILER="jikes"
# little trick so it doesn't try to download junit
EANT_EXTRA_ARGS="-Djunit.ant=1 -Djunit.present=1"

src_test() {
	if has_version "<sys-libs/timezone-data-2007c"; then
		ewarn "Tests are known to fail with older versions of"
		ewarn "sys-libs/timezone-data. Please update to the latest stable"
		ewarn "version. We don't force it because not all libc"
		ewarn "implementations use that package. See bugzilla for details:"
		ewarn "https://bugs.gentoo.org/show_bug.cgi?id=170189"
	fi

	ANT_TASKS="ant-junit" eant -Djunit.jar="$(java-pkg_getjars junit)" test
}

src_install() {
	java-pkg_newjar build/${P}.jar

	dodoc LICENSE.txt NOTICE.txt RELEASE-NOTES.txt ToDo.txt || die
	use doc && java-pkg_dojavadoc build/docs
	use examples && java-pkg_doexamples src/example
	use source && java-pkg_dosrc src/java/org
}

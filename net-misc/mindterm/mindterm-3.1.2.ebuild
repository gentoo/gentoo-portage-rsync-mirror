# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mindterm/mindterm-3.1.2.ebuild,v 1.4 2007/08/14 07:16:41 opfer Exp $

WANT_ANT_TASKS="ant-nodeps"

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="A Java SSH Client"
HOMEPAGE="http://www.appgate.com/products/80_MindTerm/"
SRC_URI="http://www.appgate.com/products/80_MindTerm/110_MindTerm_Download/${P/-/_}-src.zip"

LICENSE="mindterm"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="doc examples"
COMMON_DEP="dev-java/jzlib"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	${COMMON_DEP}"
S=${WORKDIR}/${P/-/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	java-ant_rewrite-classpath
	rm -vr com/jcraft || die "Failed to remove bundled jcraft"
}

EANT_BUILD_TARGET="mindterm.jar lite"
EANT_DOC_TARGET="doc"
EANT_GENTOO_CLASSPATH="jzlib"

# Don't even compile
RESTRICT="test"
src_test() {
	ANT_TASKS="ant-junit ant-nodeps" eant test \
		-Dgentoo.classpath="$(java-pkg_getjars jzlib,junit):mindterm.jar"
}

src_install() {
	java-pkg_dojar *.jar

	java-pkg_dolauncher ${PN} --main com.mindbright.application.MindTerm

	dodoc README.txt RELEASE_NOTES.txt CHANGES || die
	use doc && java-pkg_dojavadoc javadoc
	use examples && java-pkg_doexamples "${S}/examples/"
}

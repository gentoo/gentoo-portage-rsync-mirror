# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jdom/jdom-1.0_beta10-r6.ebuild,v 1.8 2009/08/19 08:27:24 elvanor Exp $

JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2

MY_PN="jdom"
MY_PV="b10"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Java API to manipulate XML data"
SRC_URI="http://www.jdom.org/dist/source/archive/${MY_P}.tar.gz"
HOMEPAGE="http://www.jdom.org"
LICENSE="JDOM"
SLOT="${PV}"
KEYWORDS="amd64 ppc ppc64 ~x86"
COMMON_DEP="dev-java/saxpath
		>=dev-java/xerces-2.7"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	${COMMON_DEP}"
PDEPEND="~dev-java/jdom-jaxen-${PV}"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	rm -v build/*.jar lib/*.jar || die
	rm -rf build/{apidocs,samples} || die

	rm -v src/java/org/jdom/xpath/JaxenXPath.java \
		|| die "Unable to remove Jaxen Binding class."

	cd "${S}/lib"
	java-pkg_jar-from saxpath,xerces-2
}

src_compile() {
	# to prevent a newer jdom from going into cp
	# (EANT_ANT_TASKS doesn't work with none)
	ANT_TASKS="none" eant package $(use_doc)
}

src_install() {
	java-pkg_dojar build/*.jar

	java-pkg_register-dependency "jdom-jaxen-${SLOT}"

	dodoc CHANGES.txt COMMITTERS.txt README.txt TODO.txt || die
	use doc && java-pkg_dojavadoc build/apidocs
	use examples && java-pkg_doexamples samples
	use source && java-pkg_dosrc src/java/org
}

pkg_postinst() {
	if ! has_version '=dev-java/jaxen-1.1*'; then
		elog ""
		elog "If you want jaxen support for jdom then"
		elog "please emerge =dev-java/jaxen-1.1* first and"
		elog "re-emerge jdom.  Sorry for the"
		elog "inconvenience, this is to break out of the"
		elog "circular dependencies."
		elog ""
	fi
}

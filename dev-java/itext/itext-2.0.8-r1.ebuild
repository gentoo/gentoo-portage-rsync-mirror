# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-2.0.8-r1.ebuild,v 1.1 2013/08/15 13:45:51 tomwij Exp $

EAPI=1

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

DESCRIPTION="A Java library that generate documents in the Portable Document Format (PDF) and/or HTML."
HOMEPAGE="http://www.lowagie.com/iText/"
DISTFILE="${PN/it/iT}-src-${PV}.tar.gz"
ASIANJAR="iTextAsian.jar"
ASIANCMAPSJAR="iTextAsianCmaps.jar"
SRC_URI="mirror://sourceforge/itext/${DISTFILE}
	cjk? ( mirror://sourceforge/itext/${ASIANJAR}
		mirror://sourceforge/itext/${ASIANCMAPSJAR} )"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="cjk"

BCV="1.38"

COMMON_DEPEND="dev-java/bcmail:${BCV}
	dev-java/bcprov:${BCV}"
DEPEND="|| ( =virtual/jdk-1.6* =virtual/jdk-1.5* =virtual/jdk-1.4* )
	cjk? ( app-arch/unzip )
	${COMMON_DEPEND}"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"

S=${WORKDIR}

src_unpack() {
	mkdir "${WORKDIR}/src" && cd "${WORKDIR}/src"
	unpack ${DISTFILE}

	if use cjk; then
		cp "${DISTDIR}/${ASIANJAR}" "${DISTDIR}/${ASIANCMAPSJAR}" "${S}" || die "Could not copy asian fonts"
	fi

	epatch "${FILESDIR}"/2.0.8-site_xml.patch
	java-ant_bsfix_files ant/*.xml || die "failed to rewrite build xml files"

	mkdir -p "${WORKDIR}/lib" || die "Failed to create ${WORKDIR}/lib"
	cd "${WORKDIR}/lib" || die "Could not cd ${WORKDIR}/lib"
	java-pkg_jar-from bcmail-${BCV} bcmail.jar "bcmail-jdk14-${BCV/./}.jar"
	java-pkg_jar-from bcprov-${BCV} bcprov.jar "bcprov-jdk14-${BCV/./}.jar"
}

EANT_BUILD_XML="src/build.xml"

src_install() {
	java-pkg_dojar lib/iText.jar
	if use cjk; then
		java-pkg_dojar "${ASIANJAR}"
		java-pkg_dojar "${ASIANCMAPSJAR}"
	fi

	use source && java-pkg_dosrc src/core/com src/rups/com
	use doc && java-pkg_dojavadoc build/docs
}

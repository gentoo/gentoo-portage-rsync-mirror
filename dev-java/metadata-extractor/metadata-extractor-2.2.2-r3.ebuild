# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/metadata-extractor/metadata-extractor-2.2.2-r3.ebuild,v 1.1 2009/01/31 13:46:36 serkan Exp $

EAPI=1
inherit java-pkg-2 java-ant-2 eutils

DESCRIPTION="A general metadata extraction framework. Support currently exists for Exif and Iptc metadata segments. Extraction of these segments is provided for Jpeg files"
HOMEPAGE="http://www.drewnoakes.com/code/exif/"
SRC_URI="http://www.drewnoakes.com/code/exif/metadata-extractor-${PV}-src.jar"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

DEPEND="|| ( =virtual/jdk-1.6* =virtual/jdk-1.5* =virtual/jdk-1.4* )
	test? ( dev-java/junit:0 )
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.4"
S=${WORKDIR}/

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${P}-buildfix.patch
	mv metadata-extractor.build build.xml

	use test && java-pkg_jar-from --build-only --into lib/ junit junit.jar
}

EANT_DOC_TARGET=""
EANT_BUILD_TARGET="dist-binaries"

src_install() {
	dodoc ReleaseNotes.txt || die "dodoc failed"
	java-pkg_newjar dist/*.jar "${PN}.jar"
}

src_test() {
	ANT_TASKS="ant-junit" eant test
}

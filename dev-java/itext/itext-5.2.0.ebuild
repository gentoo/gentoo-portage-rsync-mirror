# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/itext/itext-5.2.0.ebuild,v 1.3 2014/08/10 20:15:26 slyfox Exp $

EAPI="4"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java library that generate documents in the Portable Document Format (PDF) and/or HTML"
HOMEPAGE="http://itextpdf.com"
SRC_URI="mirror://sourceforge/${PN}/${P}.zip"

LICENSE="AGPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEP="
	dev-java/bcmail:0
	dev-java/bcprov:0
	dev-java/bctsp:0"
RDEPEND="${COMMON_DEP}
	>=virtual/jre-1.5"
DEPEND="${COMMON_DEP}
	>=virtual/jdk-1.5
	app-arch/unzip"

src_unpack() {
	default
	unpack ./${PN}{pdf,-xtra}-${PV}-sources.jar
}

java_prepare() {
	# Extract resources from precompiled jar
	mkdir target/classes -p || die
	pushd target/classes > /dev/null || die
		declare -a resources
		resources=( $(jar -tf "${WORKDIR}"/${PN}pdf-${PV}.jar \
			| sed -e '/class$/d' -e '/\/$/d' -e '/META-INF/d') )
		assert
		jar -xf "${WORKDIR}"/${PN}pdf-${PV}.jar "${resources[@]}" || die
	popd > /dev/null

	find "${WORKDIR}" -name '*.jar' -exec rm -v {} + || die
}

JAVA_GENTOO_CLASSPATH="bcmail,bcprov,bctsp"

src_install() {
	java-pkg-simple_src_install
}

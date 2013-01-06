# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weka/weka-3.5.7.ebuild,v 1.5 2008/07/01 20:24:10 ken69267 Exp $

JAVA_PKG_IUSE="doc source"

inherit eutils java-pkg-2 versionator

MY_P="${PN}-$(replace_all_version_separators '-')"
DESCRIPTION="A Java data mining package"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
HOMEPAGE="http://www.cs.waikato.ac.nz/ml/weka/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc x86"
DEPEND="|| ( =virtual/jdk-1.6* =virtual/jdk-1.5* )
	app-arch/unzip"
RDEPEND=">=virtual/jre-1.5"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	unzip -qq "${PN}-src.jar" -d src || die "Failed to unpack the source"

	rm -v *.jar || die
}

src_compile() {
	mkdir build dist
	echo "Compiling sources"
	# We need to set the maximum heap size to 128m to avoid
	#	OutOfMemoryErrors
	local mem=128
	use amd64 && mem=256
	find src/ -name "*.java" | xargs javac -J-Xmx${mem}m -d build \
		$(java-pkg_javac-args) -sourcepath src/ -nowarn \
		|| die "Failed to compile sources"

	echo "Copying resources"
	cd src
	find . -type f -not -name '*.java' -and -not -name "*.MF" -print | \
	while read file; do
		mkdir -p $(dirname "../build/${file}")
		cp "${file}" "../build/${file}" || die "Failed to extract resources"
	done
	cd ..

	echo "Creating JAR"
	jar cf dist/${PN}.jar -C build . || die "Failed to create JAR archive"

	if use doc ; then
		mkdir -p dist/doc
		echo "Generating javadocs"
		find src/ -name "*.java" | xargs javadoc -d dist/doc/ \
		-J-Xmx${mem}m -quiet || die "Failed to generate javadoc"
	fi
}

src_install() {
	java-pkg_dojar dist/*.jar

	java-pkg_dolauncher weka --main "${PN}.gui.GUIChooser"
	# Really need a virtual to list all available drivers and pull the ones
	# instaled
	java-pkg_register-optional-dependency hsqldb,jdbc-mysql,mckoi-1

	use source && java-pkg_dosrc src/weka

	dodoc README || die
	use doc && java-pkg_dojavadoc dist/doc/

	dodir /usr/share/${PN}/data/
	insinto /usr/share/${PN}/data/
	doins data/*
}

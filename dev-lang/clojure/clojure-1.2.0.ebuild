# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/clojure/clojure-1.2.0.ebuild,v 1.5 2010/11/24 19:58:37 darkside Exp $

EAPI=2
JAVA_PKG_IUSE="source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Clojure is a dynamic programming language that targets the Java Virtual Machine"
HOMEPAGE="http://clojure.org/"
SRC_URI="http://github.com/downloads/clojure/clojure/${P}.zip"

LICENSE="EPL-1.0"
SLOT="1.2"
KEYWORDS="amd64 x86 ~x86-linux"
IUSE="source"

RDEPEND=">=virtual/jre-1.5"
DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

java_prepare() {
	rm -v ${PN}.jar || die "Failed to remove compile jar."
}

src_test() {
	java-pkg-2_src_test
}

src_install() {
	java-pkg_newjar ${P/_/-}.jar
	java-pkg_dolauncher  ${PN}-${SLOT} --main clojure.main
	dodoc changes.txt readme.txt || die

	if use source; then
		local zip_name="${PN}-src.zip"
		local zip_path="${T}/${zip_name}"
		pushd src/jvm >/dev/null || die "Problem entering Java source directory"
		zip -q -r ${zip_path} . -i '*.java'
		popd >/dev/null
		pushd src/clj >/dev/null || die "Problem entering Clojure source directory"
		zip -q -r ${zip_path} . -i '*.clj'
		popd >/dev/null

		INSDESTTREE=${JAVA_PKG_SOURCESPATH} \
			doins ${zip_path} || die "Failed to install source"

		JAVA_SOURCES="${JAVA_PKG_SOURCESPATH}/${zip_name}"
		java-pkg_do_write_
	fi
}

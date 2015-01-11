# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/scala-bin/scala-bin-1.2.0.1.ebuild,v 1.9 2015/01/11 20:42:54 monsieurp Exp $

inherit java-pkg-2

DESCRIPTION="The Scala Programming Language"
HOMEPAGE="http://scala.epfl.ch/"
SRC_URI="http://scala.epfl.ch/downloads/distrib/files/scala-1.2.0.1.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
DEPEND=""
RDEPEND=">=virtual/jre-1.4
	!dev-lang/scala"
S=${WORKDIR}/scala-${PV}

src_compile() {

	jars=/usr/share/${PN}/lib

sed -e "s#RUNTIME_SOURCES=.*#RUNTIME_SOURCES=\"/usr/share/${PF}/src\";#;
				s#RUNTIME_CLASSES=.*#RUNTIME_CLASSES=\"${jars}/scala.jar\";#;
				s#TOOLS_CLASSES=.*#TOOLS_CLASSES=\"${jars}/tools.jar\";#;
				s#FJBG_CLASSES=.*#FJBG_CLASSES=\"${jars}/fjbg.jar\";#;
				s#MSIL_CLASSES=.*#MSIL_CLASSES=\"${jars}/msil.jar\";#" \
	< bin/.scala_wrapper \
	> scala_wrapper

:; }

src_install() {

	exeinto /usr/lib/${PN}
	doexe scala_wrapper

	dodir /usr/bin

	for x in dtd2scala scalac scala-debug scaladoc-debug scalaint scalap scalarun-debug \
		scala scalac-debug scaladoc scala-info scalaint-debug scalarun scalatest ; do
		dosym /usr/lib/${PN}/scala_wrapper /usr/bin/$x
	done

	java-pkg_dojar lib/*.jar

	java-pkg_dohtml -r doc/api
	cp -r examples "${D}"/usr/share/doc/${PF}
	dodoc doc/*.pdf
	dodoc README VERSION

	dodir /usr/share/${PF}
	cp -r src support "${D}"/usr/share/${PF}

}

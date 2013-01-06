# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jupidator/jupidator-0.3.0.ebuild,v 1.3 2009/07/05 15:37:04 maekke Exp $

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-ant-2

MY_P="${PN}.${PV}"

DESCRIPTION="Jupidator is a library/tool in Java for automatic updating of applications"
HOMEPAGE="http://www.sourceforge.net/projects/jupidator"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="nls"

RDEPEND=">=virtual/jre-1.5
	dev-java/ant-core"
DEPEND=">=virtual/jdk-1.5
	dev-java/ant-core
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}" || die
	rm -v dist/*.jar || die
	rm -v src/java/com/panayotis/jupidator/i18n/*.class || die
	rm -rv src/java/org/apache/tools/bzip2 || die
	#Bundled ant classes
	java-ant_rewrite-classpath nbproject/build-impl.xml
}

src_compile() {
	eant -Dgentoo.classpath="$(java-pkg_getjars ant-core)" $(use nls && echo i18n) compile jar
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	use doc && java-pkg_dohtml -r dist/doc
	use source && java-pkg_dosrc src/java/com
}

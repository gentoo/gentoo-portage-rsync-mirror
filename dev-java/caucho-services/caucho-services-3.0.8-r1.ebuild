# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/caucho-services/caucho-services-3.0.8-r1.ebuild,v 1.3 2006/11/28 03:57:13 nichoj Exp $

inherit java-pkg-2 java-ant-2

DESCRIPTION="The com.caucho.services package used by dev-java/hessian and dev-java/burlap."
HOMEPAGE="http://www.caucho.com/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="Apache-1.1"
SLOT="3.0"
KEYWORDS="amd64 x86"

IUSE="doc source"

COMMON_DEP="~dev-java/servletapi-2.3"

RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/ant-core
	source? ( app-arch/zip )
	${COMMON_DEP}"

src_compile() {
	eant jar -Dservletapi=$(java-pkg_getjars servletapi-2.3) $(use_doc)
}

src_install() {
	java-pkg_dojar dist/${PN}.jar

	use doc && java-pkg_dohtml -r dist/doc/api
	use source && java-pkg_dosrc src/*
}

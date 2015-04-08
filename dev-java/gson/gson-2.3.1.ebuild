# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/gson/gson-2.3.1.ebuild,v 1.1 2015/03/08 09:43:10 chewi Exp $

EAPI=5

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java library to convert JSON to Java objects and vice-versa"
HOMEPAGE="http://code.google.com/p/google-gson/"
SRC_URI="http://search.maven.org/remotecontent?filepath=com/google/code/${PN}/${PN}/${PV}/${P}-sources.jar"
LICENSE="Apache-2.0"
SLOT="2.2.2"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=virtual/jdk-1.5
	app-arch/unzip"

RDEPEND=">=virtual/jre-1.5"

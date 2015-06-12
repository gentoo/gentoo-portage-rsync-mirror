# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jsr250/jsr250-1.0.ebuild,v 1.9 2015/06/11 23:35:09 monsieurp Exp $

EAPI=5

inherit eutils java-pkg-2 java-pkg-simple

DESCRIPTION="JSR 250 Common Annotations"
HOMEPAGE="https://jcp.org/en/jsr/detail?id=250"
SRC_URI="http://download.java.net/maven/2/javax/annotation/${PN}-api/${PV}/${PN}-api-${PV}-sources.jar"

LICENSE="CDDL"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND=">=virtual/jre-1.6"
DEPEND=">=virtual/jdk-1.6
	app-arch/unzip
	${RDEPEND}"

JAVA_PKG_WANT_SOURCE="1.7"
JAVA_PKG_WANT_TARGET="1.7"
JAVA_SRC_DIR="src"

java_prepare() {
	mkdir src || die
	mv * src
}

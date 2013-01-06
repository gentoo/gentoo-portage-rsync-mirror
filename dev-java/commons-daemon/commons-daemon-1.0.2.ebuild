# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-daemon/commons-daemon-1.0.2.ebuild,v 1.7 2010/10/14 16:55:17 ranger Exp $

EAPI="2"
WANT_AUTOCONF=2.5
JAVA_PKG_IUSE="doc examples source"

inherit java-pkg-2 java-ant-2 eutils autotools

DESCRIPTION="Tools to allow java programs to run as unix daemons"
SRC_URI="mirror://apache/commons/daemon/source/${P}-src.tar.gz"
HOMEPAGE="http://commons.apache.org/daemon/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=">=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}/${P}-src

java_prepare() {
	# https://issues.apache.org/jira/browse/DAEMON-154
	find . -name "*.o" -delete -print || die

	cd "${S}/src/native/unix"
	sed -e "s/powerpc/powerpc|powerpc64/g" -i support/apsupport.m4
	eautoconf
}

src_configure() {
	java-ant-2_src_configure
	cd "${S}/src/native/unix"
	econf || die "configure failed"
}

src_compile() {
	# compile native stuff
	cd "${S}/src/native/unix"
	emake || die "make failed"

	# compile java stuff
	cd "${S}"
	java-pkg-2_src_compile
}

src_install() {
	dobin src/native/unix/jsvc || die
	java-pkg_newjar dist/*.jar

	dodoc README RELEASE-NOTES.txt *.html || die
	use doc && java-pkg_dohtml -r dist/docs/*
	use examples && java-pkg_doexamples src/samples
	use source && java-pkg_dosrc src/java/* src/native/unix/native
}

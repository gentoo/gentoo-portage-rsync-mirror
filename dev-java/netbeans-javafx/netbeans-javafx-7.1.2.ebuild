# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-javafx/netbeans-javafx-7.1.2.ebuild,v 1.3 2012/05/30 06:15:31 johu Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans JavaFX Cluster"
HOMEPAGE="http://netbeans.org/projects/javafx"
SLOT="7.1"
SOURCE_URL="http://dlc.sun.com.edgesuite.net/netbeans/7.1.2/final/zip/netbeans-7.1.2-201204101705-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/A806D99716C5E9441BFD8B401176FDDEFC673022-bindex-2.2.jar
	http://hg.netbeans.org/binaries/418FC62C8A6EF5311987B01FE389B1F88EFDDCA2-jemmy-2.3.0.0.jar"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-java-${PV}
	~dev-java/netbeans-platform-${PV}"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/javahelp:0
	dev-java/junit:4"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.javafx -Dext.binaries.downloaded=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-9999-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/A806D99716C5E9441BFD8B401176FDDEFC673022-bindex-2.2.jar apisupport.harness/external/bindex-2.2.jar || die
	ln -s "${DISTDIR}"/418FC62C8A6EF5311987B01FE389B1F88EFDDCA2-jemmy-2.3.0.0.jar jemmy/external/jemmy-2.3.0.0.jar || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-9999-r1-build.xml.patch

	# Support for custom patches
	if [ -n "${NETBEANS9999_PATCHES_DIR}" -a -d "${NETBEANS9999_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS9999_PATCHES_DIR}" -type f`

		if [ -n "${files}" ] ; then
			einfo "Applying custom patches:"

			for file in ${files} ; do
				epatch "${file}"
			done
		fi
	fi

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --build-only --into apisupport.harness/external javahelp jsearch.jar jsearch-2.0_05.jar
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --build-only --into libs.junit4/external junit-4 junit.jar junit-4.10.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-java-${SLOT} java || die
	cat /usr/share/netbeans-java-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.java.built

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans/javafx >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/javafx$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *

	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/javafx
}

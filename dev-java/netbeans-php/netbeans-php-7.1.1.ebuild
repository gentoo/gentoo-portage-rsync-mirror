# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-php/netbeans-php-7.1.1.ebuild,v 1.3 2012/05/07 06:32:34 phajdan.jr Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans PHP Cluster"
HOMEPAGE="http://netbeans.org/projects/php"
SLOT="7.1"
SOURCE_URL="http://dlc.sun.com.edgesuite.net/netbeans/7.1.1/final/zip/netbeans-7.1.1-201203012225-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/0702230EB3354A1687E4496D73A94F33A1E343BD-phpdocdesc.zip
	http://hg.netbeans.org/binaries/BB8CBBD70CCD7ABF40943487C48512D82FB01AE9-phpsigfiles.zip
	http://hg.netbeans.org/binaries/40BC40A6E6DBD598900E8FAB87E460FCC601275C-predefined_vars.zip"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-platform-${PV}
	~dev-java/netbeans-websvccommon-${PV}
	dev-java/javacup:0"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}
	dev-java/javahelp:0"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.php -Dext.binaries.downloaded=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-9999-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/0702230EB3354A1687E4496D73A94F33A1E343BD-phpdocdesc.zip php.phpdoc.documentation/external/phpdocdesc.zip || die
	ln -s "${DISTDIR}"/BB8CBBD70CCD7ABF40943487C48512D82FB01AE9-phpsigfiles.zip php.project/external/phpsigfiles.zip || die
	ln -s "${DISTDIR}"/40BC40A6E6DBD598900E8FAB87E460FCC601275C-predefined_vars.zip php.editor/external/predefined_vars.zip || die
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
	java-pkg_jar-from --build-only --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --into libs.javacup/external javacup javacup.jar java-cup-11a.jar

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	ln -s /usr/share/netbeans-websvccommon-${SLOT} websvccommon || die
	cat /usr/share/netbeans-websvccommon-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.websvccommon.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_install() {
	pushd nbbuild/netbeans/php >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/php$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *

	popd >/dev/null || die

	local instdir=${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	rm java-cup-11a.jar && dosym /usr/share/javacup/lib/javacup.jar ${instdir}/java-cup-11a.jar || die
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/php
}

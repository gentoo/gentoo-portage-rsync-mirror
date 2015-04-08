# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-platform/netbeans-platform-7.2.ebuild,v 1.3 2012/10/17 11:07:54 ago Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans Platform"
HOMEPAGE="http://netbeans.org/features/platform/"
SLOT="7.2"
SOURCE_URL="http://download.netbeans.org/netbeans/7.2/final/zip/netbeans-7.2-201207171143-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-7.2-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/14F630EDF137F54188636B5139432986D5FB19B7-felix-4.0.2.jar
	http://hg.netbeans.org/binaries/2D80F93B8803250F232902C46EBA850BF1F3E67F-org.eclipse.osgi_3.7.1.R37x_v20110808-1106.jar
	http://hg.netbeans.org/binaries/972E6455724DC6ADB1C1912F53B5E3D7DF20C5FD-osgi.cmpn-4.2.jar
	http://hg.netbeans.org/binaries/1C7FE319052EF49126CF07D0DB6953CB7007229E-swing-layout-1.0.4-doc.zip
	http://hg.netbeans.org/binaries/CFF0A34484AAF26F18BC15D0B2C226FD66769EAA-testng-6.5.1-dist.jar
	http://hg.netbeans.org/binaries/D9B2EEC6413BDD174D047F9B7804C2EA440B79A5-testng-6.5.1-javadoc.zip"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="dev-java/javahelp:0
	>=dev-java/jna-3.4:0
	dev-java/osgi-core-api:0
	dev-java/swing-layout:1[source]"
DEPEND="virtual/jdk:1.6
	app-arch/unzip
	${CDEPEND}"
RDEPEND=">=virtual/jdk-1.6
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.platform -Dext.binaries.downloaded=true -Djava.awt.headless=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-7.2-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/14F630EDF137F54188636B5139432986D5FB19B7-felix-4.0.2.jar libs.felix/external/felix-4.0.2.jar || die
	ln -s "${DISTDIR}"/2D80F93B8803250F232902C46EBA850BF1F3E67F-org.eclipse.osgi_3.7.1.R37x_v20110808-1106.jar netbinox/external/org.eclipse.osgi_3.7.1.R37x_v20110808-1106.jar || die
	ln -s "${DISTDIR}"/972E6455724DC6ADB1C1912F53B5E3D7DF20C5FD-osgi.cmpn-4.2.jar libs.osgi/external/osgi.cmpn-4.2.jar || die
	ln -s "${DISTDIR}"/1C7FE319052EF49126CF07D0DB6953CB7007229E-swing-layout-1.0.4-doc.zip o.jdesktop.layout/external/swing-layout-1.0.4-doc.zip || die
	ln -s "${DISTDIR}"/CFF0A34484AAF26F18BC15D0B2C226FD66769EAA-testng-6.5.1-dist.jar libs.testng/external/testng-6.5.1-dist.jar || die
	ln -s "${DISTDIR}"/D9B2EEC6413BDD174D047F9B7804C2EA440B79A5-testng-6.5.1-javadoc.zip libs.testng/external/testng-6.5.1-javadoc.zip || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	# upstream jna jar contains bundled binary libraries so we disable that feature
	epatch netbeans-7.2-r1-build.xml.patch

	# Support for custom patches
	if [ -n "${NETBEANS72_PATCHES_DIR}" -a -d "${NETBEANS72_PATCHES_DIR}" ] ; then
		local files=`find "${NETBEANS72_PATCHES_DIR}" -type f`

		if [ -n "${files}" ] ; then
			einfo "Applying custom patches:"

			for file in ${files} ; do
				epatch "${file}"
			done
		fi
	fi

	einfo "Symlinking external libraries..."
	java-pkg_jar-from --into core.nativeaccess/external jna platform.jar platform-3.4.0.jar
	java-pkg_jar-from --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --into libs.jna/external jna jna.jar jna-3.4.0.jar
	java-pkg_jar-from --into libs.osgi/external osgi-core-api osgi-core-api.jar osgi.core-4.3.jar
	java-pkg_jar-from --into o.jdesktop.layout/external swing-layout-1 swing-layout.jar swing-layout-1.0.4.jar
	ln -s /usr/share/swing-layout-1/sources/swing-layout-src.zip o.jdesktop.layout/external/swing-layout-1.0.4-src.zip || die

	java-pkg-2_src_prepare
}

src_compile() {
	unset DISPLAY
	eant -f ${EANT_BUILD_XML} ${EANT_EXTRA_ARGS} ${EANT_BUILD_TARGET} || die "Compilation failed"
}

src_install() {
	pushd nbbuild/netbeans/platform >/dev/null || die

	java-pkg_dojar lib/*.jar
	grep -E "/platform$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	insinto ${INSTALL_DIR}
	doins -r *
	rm "${D}"/${INSTALL_DIR}/docs/swing-layout-1.0.4-src.zip || die
	dosym /usr/share/swing-layout-1/sources/swing-layout-src.zip ${INSTALL_DIR}/docs/swing-layout-1.0.4-src.zip
	find "${D}"/${INSTALL_DIR} -name "*.exe" -delete
	find "${D}"/${INSTALL_DIR} -name "*.dll" -delete
	rm -fr "${D}"/modules/lib || die

	popd >/dev/null || die

	fperms 775 ${INSTALL_DIR}/lib/nbexec
	dosym ${INSTALL_DIR}/lib/nbexec /usr/bin/nbexec-${SLOT}

	local instdir=${INSTALL_DIR}/modules/ext
	pushd "${D}"/${instdir} >/dev/null || die
	rm jhall-2.0_05.jar && dosym /usr/share/javahelp/lib/jhall.jar ${instdir}/jhall-2.0_05.jar || die
	rm jna-3.4.0.jar && dosym /usr/share/jna/lib/jna.jar ${instdir}/jna-3.4.0.jar || die
	rm osgi.core-4.3.jar && dosym /usr/share/osgi-core-api/lib/osgi-core-api.jar ${instdir}/osgi.core-4.3.jar || die
	rm platform-3.4.0.jar && dosym /usr/share/jna/lib/platform.jar ${instdir}/platform-3.4.0.jar || die
	rm swing-layout-1.0.4.jar && dosym /usr/share/swing-layout-1/lib/swing-layout.jar ${instdir}/swing-layout-1.0.4.jar || die
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/platform
}

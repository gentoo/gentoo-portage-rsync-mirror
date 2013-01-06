# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-platform/netbeans-platform-7.1.1.ebuild,v 1.3 2012/05/07 06:32:55 phajdan.jr Exp $

EAPI="4"
WANT_ANT_TASKS="ant-nodeps"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans Platform"
HOMEPAGE="http://netbeans.org/features/platform/"
SLOT="7.1"
SOURCE_URL="http://dlc.sun.com.edgesuite.net/netbeans/7.1.1/final/zip/netbeans-7.1.1-201203012225-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-9999-r1-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/F1C19117B73A6819FA91EB646ECBA7F41073DC2A-felix-3.2.2.jar
	http://hg.netbeans.org/binaries/1D63B972926D053DFA427CA03841F67D4EAC6DB2-org.eclipse.osgi_3.6.0.v20100517.jar
	http://hg.netbeans.org/binaries/972E6455724DC6ADB1C1912F53B5E3D7DF20C5FD-osgi.cmpn-4.2.jar
	http://hg.netbeans.org/binaries/986195A7E31034EE73F7A896A36B24169692F142-osgi.core-4.2.jar
	http://hg.netbeans.org/binaries/1C7FE319052EF49126CF07D0DB6953CB7007229E-swing-layout-1.0.4-doc.zip"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="dev-java/javahelp:0
	>=dev-java/jna-3.2.7:0
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

	unpack netbeans-9999-r1-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/F1C19117B73A6819FA91EB646ECBA7F41073DC2A-felix-3.2.2.jar libs.felix/external/felix-3.2.2.jar || die
	ln -s "${DISTDIR}"/1D63B972926D053DFA427CA03841F67D4EAC6DB2-org.eclipse.osgi_3.6.0.v20100517.jar netbinox/external/org.eclipse.osgi_3.6.0.v20100517.jar || die
	ln -s "${DISTDIR}"/972E6455724DC6ADB1C1912F53B5E3D7DF20C5FD-osgi.cmpn-4.2.jar libs.osgi/external/osgi.cmpn-4.2.jar || die
	ln -s "${DISTDIR}"/986195A7E31034EE73F7A896A36B24169692F142-osgi.core-4.2.jar libs.osgi/external/osgi.core-4.2.jar || die
	ln -s "${DISTDIR}"/1C7FE319052EF49126CF07D0DB6953CB7007229E-swing-layout-1.0.4-doc.zip o.jdesktop.layout/external/swing-layout-1.0.4-doc.zip || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-9999-r1-build.xml.patch
	# upstream jna jar contains bundled binary libraries so we disable that feature

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
	java-pkg_jar-from --into core.nativeaccess/external jna platform.jar platform-3.2.7.jar
	java-pkg_jar-from --into javahelp/external javahelp jhall.jar jhall-2.0_05.jar
	java-pkg_jar-from --into libs.jna/external jna jna.jar jna-3.2.7.jar
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
	# felix-main-2.0.2.jar
	# felix-2.0.3.jar
	rm jhall-2.0_05.jar && dosym /usr/share/javahelp/lib/jhall.jar ${instdir}/jhall-2.0_05.jar || die
	rm jna-3.2.7.jar && dosym /usr/share/jna/lib/jna.jar ${instdir}/jna-3.2.7.jar || die
	# osgi.cmpn-4.2.jar
	# osgi.core-4.2.jar
	rm platform-3.2.7.jar && dosym /usr/share/jna/lib/platform.jar ${instdir}/platform-3.2.7.jar || die
	rm swing-layout-1.0.4.jar && dosym /usr/share/swing-layout-1/lib/swing-layout.jar ${instdir}/swing-layout-1.0.4.jar || die
	# updater.jar
	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/platform
}

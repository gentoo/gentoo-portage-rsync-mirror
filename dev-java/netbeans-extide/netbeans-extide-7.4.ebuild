# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/netbeans-extide/netbeans-extide-7.4.ebuild,v 1.1 2013/10/16 09:40:11 fordfrog Exp $

EAPI="4"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Netbeans ExtIDE Cluster"
HOMEPAGE="http://netbeans.org/projects/ide"
SLOT="7.4"
SOURCE_URL="http://download.netbeans.org/netbeans/7.4/final/zip/netbeans-7.4-201310111528-src.zip"
SRC_URI="${SOURCE_URL}
	http://dev.gentoo.org/~fordfrog/distfiles/netbeans-7.4-build.xml.patch.bz2
	http://hg.netbeans.org/binaries/32F6CF2B9EE5F69DCB020E7B5833227933FBEAA7-ant-libs-1.9.1.zip
	http://hg.netbeans.org/binaries/FCC654151181159A667BBCB5517880E96051FCE0-ant-misc-1.9.1.zip"
LICENSE="|| ( CDDL GPL-2-with-linking-exception )"
KEYWORDS="~amd64 ~x86"
IUSE=""
S="${WORKDIR}"

CDEPEND="~dev-java/netbeans-ide-${PV}
	~dev-java/netbeans-platform-${PV}"
DEPEND=">=virtual/jdk-1.7
	app-arch/unzip
	dev-java/javahelp:0
	${CDEPEND}"
RDEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

INSTALL_DIR="/usr/share/${PN}-${SLOT}"

EANT_BUILD_XML="nbbuild/build.xml"
EANT_BUILD_TARGET="rebuild-cluster"
EANT_EXTRA_ARGS="-Drebuild.cluster.name=nb.cluster.extide -Dext.binaries.downloaded=true -Djava.awt.headless=true"
EANT_FILTER_COMPILER="ecj-3.3 ecj-3.4 ecj-3.5 ecj-3.6 ecj-3.7"
JAVA_PKG_BSFIX="off"

src_unpack() {
	unpack $(basename ${SOURCE_URL})

	einfo "Deleting bundled jars..."
	find -name "*.jar" -type f -delete

	unpack netbeans-7.4-build.xml.patch.bz2

	pushd "${S}" >/dev/null || die
	ln -s "${DISTDIR}"/32F6CF2B9EE5F69DCB020E7B5833227933FBEAA7-ant-libs-1.9.1.zip o.apache.tools.ant.module/external/ant-libs-1.9.1.zip || die
	ln -s "${DISTDIR}"/FCC654151181159A667BBCB5517880E96051FCE0-ant-misc-1.9.1.zip o.apache.tools.ant.module/external/ant-misc-1.9.1.zip || die
	popd >/dev/null || die
}

src_prepare() {
	einfo "Deleting bundled class files..."
	find -name "*.class" -type f | xargs rm -vf

	epatch netbeans-7.4-build.xml.patch

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

	einfo "Linking in other clusters..."
	mkdir "${S}"/nbbuild/netbeans || die
	pushd "${S}"/nbbuild/netbeans >/dev/null || die

	ln -s /usr/share/netbeans-ide-${SLOT} ide || die
	cat /usr/share/netbeans-ide-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.ide.built

	ln -s /usr/share/netbeans-platform-${SLOT} platform || die
	cat /usr/share/netbeans-platform-${SLOT}/moduleCluster.properties >> moduleCluster.properties || die
	touch nb.cluster.platform.built

	popd >/dev/null || die

	java-pkg-2_src_prepare
}

src_compile() {
	unset DISPLAY
	eant -f ${EANT_BUILD_XML} ${EANT_EXTRA_ARGS} ${EANT_BUILD_TARGET} || die "Compilation failed"
}

src_install() {
	pushd nbbuild/netbeans/extide >/dev/null || die

	insinto ${INSTALL_DIR}

	grep -E "/extide$" ../moduleCluster.properties > "${D}"/${INSTALL_DIR}/moduleCluster.properties || die

	doins -r *

	popd >/dev/null || die

	dosym ${INSTALL_DIR} /usr/share/netbeans-nb-${SLOT}/extide
}

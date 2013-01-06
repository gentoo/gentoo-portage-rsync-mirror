# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/oracle-jdk-bin/oracle-jdk-bin-1.7.0.9.ebuild,v 1.2 2012/10/23 05:06:57 nativemad Exp $

EAPI="4"

inherit java-vm-2 eutils prefix versionator

# This URIs need to be updated when bumping!
JDK_URI="http://www.oracle.com/technetwork/java/javase/downloads/jdk7u9-downloads-1859576.html"
# api and fx docs for 7u6
#DOCS_URI=http://www.oracle.com/technetwork/java/javase/documentation/java-se-7-doc-download-435117.html
JCE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jce-7-download-432124.html"

# This is a list of archs supported by this update
# arm currently missing
JDK_AVAILABLE=( amd64 x86 x64-solaris x86-solaris sparc-solaris sparc64-solaris )
DEMOS_AVAILABLE=( amd64 x86 x64-solaris x86-solaris sparc-solaris sparc64-solaris )

FX_VERSION="2_2_3"
UPDATE="$(get_version_component_range 4)"
MY_PV="$(get_version_component_range 2)u${UPDATE}"
S="${WORKDIR}/jdk$(get_version_component_range 1-3)_0${UPDATE}"
# for when oracle messes with us again.
DEMOS_PV="${MY_PV}"
DEMOS_S="${S}"

at_x86="jdk-${MY_PV}-linux-i586.tar.gz"
at_amd64="jdk-${MY_PV}-linux-x64.tar.gz"
at_arm="jdk-${MY_PV}-linux-arm-sfp.tar.gz"
at_x86_solaris="jdk-${MY_PV}-solaris-i586.tar.gz"
at_x64_solaris="${at_x86_solaris} jdk-${MY_PV}-solaris-x64.tar.gz"
at_sparc_solaris="jdk-${MY_PV}-solaris-sparc.tar.gz"
at_sparc64_solaris="${at_sparc_solaris} jdk-${MY_PV}-solaris-sparcv9.tar.gz"

fx_demos_linux="javafx_samples-${FX_VERSION}-linux.zip"
demos_x86="${fx_demos_linux} jdk-${DEMOS_PV}-linux-i586-demos.tar.gz"
demos_amd64="${fx_demos_linux} jdk-${DEMOS_PV}-linux-x64-demos.tar.gz"
demos_arm="${fx_demos_linux} jdk-${DEMOS_PV}-linux-arm-sfp-demos.tar.gz"
demos_x86_solaris="jdk-${DEMOS_PV}-solaris-i586-demos.tar.gz"
demos_x64_solaris="${demos_x86_solaris} jdk-${DEMOS_PV}-solaris-x64-demos.tar.gz"
demos_sparc_solaris="jdk-${DEMOS_PV}-solaris-sparc-demos.tar.gz"
demos_sparc64_solaris="${demos_sparc_solaris} jdk-${DEMOS_PV}-solaris-sparcv9-demos.tar.gz"

# docs #67266
#JDK_API_DOCS="jdk-${MY_PV}-apidocs.zip"
#FX_API_DOCS="javafx-${FX_VERSION}-apidocs.zip"

JCE_DIR="UnlimitedJCEPolicy"
JCE_FILE="${JCE_DIR}JDK7.zip"

DESCRIPTION="Oracle's Java SE Development Kit"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
for d in "${JDK_AVAILABLE[@]}"; do
	SRC_URI+=" ${d}? ("
	SRC_URI+=" $(eval "echo \${$(echo at_${d/-/_})}")"
	if has ${d} "${DEMOS_AVAILABLE[@]}"; then
		SRC_URI+=" examples? ( $(eval "echo \${$(echo demos_${d/-/_})}") )"
	fi
	SRC_URI+=" )"
done
unset d
SRC_URI+=" jce? ( ${JCE_FILE} )"

LICENSE="Oracle-BCLA-JavaSE examples? ( BSD )" # doc? ( Oracle-DLA-JavaSE )
SLOT="1.7"
KEYWORDS="~amd64 x86 ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="+X alsa derby doc examples +fontconfig jce nsplugin pax_kernel +source"

RESTRICT="fetch strip"
QA_PREBUILT="*"

RDEPEND="
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXrender
		x11-libs/libXtst
		x11-libs/libX11
	)
	alsa? ( media-libs/alsa-lib )
	doc? ( dev-java/java-sdk-docs:1.7 )
	fontconfig? ( media-libs/fontconfig )
	!prefix? ( sys-libs/glibc )"
# scanelf won't create a PaX header, so depend on paxctl to avoid fallback
# marking. #427642
DEPEND="
	jce? ( app-arch/unzip )
	examples? ( kernel_linux? ( app-arch/unzip ) )
	pax_kernel? ( sys-apps/paxctl )"

check_tarballs_available() {
	local uri=$1; shift
	local dl= unavailable=
	for dl in "${@}"; do
		[[ ! -f "${DISTDIR}/${dl}" ]] && unavailable+=" ${dl}"
	done

	if [[ -n "${unavailable}" ]]; then
		if [[ -z ${_check_tarballs_available_once} ]]; then
			einfo
			einfo "Oracle requires you to download the needed files manually after"
			einfo "accepting their license through a javascript capable web browser."
			einfo
			_check_tarballs_available_once=done
		fi
		einfo "Downlod the following files:"
		for dl in ${unavailable}; do
			einfo "  ${dl}"
		done
		einfo "at '${uri}'"
		einfo "and move them to '${DISTDIR}'"
		einfo
	fi
}

pkg_nofetch() {
	local distfiles=( $(eval "echo \${$(echo at_${ARCH/-/_})}") )
	if use examples && has ${ARCH} "${DEMOS_AVAILABLE[@]}"; then
		distfiles+=( $(eval "echo \${$(echo demos_${ARCH/-/_})}") )
	fi
	check_tarballs_available "${JDK_URI}" "${distfiles[@]}"

	use jce && check_tarballs_available "${JCE_URI}" "${JCE_FILE}"
}

src_prepare() {
	if use jce; then
		mv "${WORKDIR}"/${JCE_DIR} "${S}"/jre/lib/security/ || die
	fi
}

src_compile() {
	# This needs to be done before CDS - #215225
	java-vm_set-pax-markings "${S}"

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	if use x86; then
		bin/java -client -Xshare:dump || die
	fi
	bin/java -server -Xshare:dump || die

	# Create files used as storage for system preferences.
	mkdir jre/.systemPrefs || die
	touch jre/.systemPrefs/.system.lock || die
	touch jre/.systemPrefs/.systemRootModFile || die
}

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}${dest}"

	dodoc COPYRIGHT
	dohtml README.html

	# We should not need the ancient plugin for Firefox 2 anymore, plus it has
	# writable executable segments
	if use x86; then
		rm -vf {,jre/}lib/i386/libjavaplugin_oji.so \
			{,jre/}lib/i386/libjavaplugin_nscp*.so
		rm -vrf jre/plugin/i386
	fi
	# Without nsplugin flag, also remove the new plugin
	local arch=${ARCH};
	use x86 && arch=i386;
	if ! use nsplugin; then
		rm -vf {,jre/}lib/${arch}/libnpjp2.so \
			{,jre/}lib/${arch}/libjavaplugin_jni.so
	fi

	dodir "${dest}"
	cp -pPR bin include jre lib man "${ddest}" || die

	if use derby; then
		cp -pPR db "${ddest}" || die
	fi

	if use examples; then
		cp -pPR "${DEMOS_S}"/{demo,sample} "${ddest}" || die
		if use kernel_linux && has ${ARCH} "${DEMOS_AVAILABLE[@]}"; then
			cp -pPR "${WORKDIR}"/javafx-samples-${FX_VERSION//_/.} \
				"${ddest}"/javafx-samples || die
		fi
	fi

	if use jce; then
		dodir "${dest}"/jre/lib/security/strong-jce
		mv "${ddest}"/jre/lib/security/US_export_policy.jar \
			"${ddest}"/jre/lib/security/strong-jce || die
		mv "${ddest}"/jre/lib/security/local_policy.jar \
			"${ddest}"/jre/lib/security/strong-jce || die
		dosym "${dest}"/jre/lib/security/${JCE_DIR}/US_export_policy.jar \
			"${dest}"/jre/lib/security/US_export_policy.jar
		dosym "${dest}"/jre/lib/security/${JCE_DIR}/local_policy.jar \
			"${dest}"/jre/lib/security/local_policy.jar
	fi

	if use nsplugin; then
		install_mozilla_plugin "${dest}"/jre/lib/${arch}/libnpjp2.so
	fi

	if use source; then
		cp src.zip "${ddest}" || die
	fi

	# Install desktop file for the Java Control Panel.
	# Using ${PN}-${SLOT} to prevent file collision with jre and or other slots.
	# make_desktop_entry can't be used as ${P} would end up in filename.
	newicon jre/lib/desktop/icons/hicolor/48x48/apps/sun-jcontrol.png \
		sun-jcontrol-${PN}-${SLOT}.png || die
	sed -e "s#Name=.*#Name=Java Control Panel for Oracle JDK ${SLOT}#" \
		-e "s#Exec=.*#Exec=/opt/${P}/jre/bin/jcontrol#" \
		-e "s#Icon=.*#Icon=sun-jcontrol-${PN}-${SLOT}#" \
		-e "s#Application;##" \
		-e "/Encoding/d" \
		jre/lib/desktop/applications/sun_java.desktop > \
		"${T}"/jcontrol-${PN}-${SLOT}.desktop || die
	domenu "${T}"/jcontrol-${PN}-${SLOT}.desktop

	# Prune all fontconfig files so libfontconfig will be used and only install
	# a Gentoo specific one if fontconfig is disabled.
	# http://docs.oracle.com/javase/7/docs/technotes/guides/intl/fontconfig.html
	rm "${ddest}"/jre/lib/fontconfig.*
	if ! use fontconfig; then
		cp "${FILESDIR}"/fontconfig.Gentoo.properties "${T}"/fontconfig.properties || die
		eprefixify "${T}"/fontconfig.properties
		insinto "${dest}"/jre/lib/
		doins "${T}"/fontconfig.properties
	fi

	# Remove empty dirs we might have copied
	find "${D}" -type d -empty -exec rmdir {} + || die

	set_java_env
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random /proc/self/coredump_filter
}

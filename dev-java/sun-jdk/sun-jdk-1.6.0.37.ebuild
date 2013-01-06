# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.6.0.37.ebuild,v 1.3 2012/10/23 05:03:16 nativemad Exp $

EAPI="4"

inherit java-vm-2 eutils prefix versionator

# This URIs need to be updated when bumping!
JDK_URI="http://www.oracle.com/technetwork/java/javase/downloads/jdk6u37-downloads-1859587.html"

MY_PV="$(get_version_component_range 2)u$(get_version_component_range 4)"
S_PV="$(replace_version_separator 3 '_')"
# for when oracle messes with us again.
DEMOS_PV="${MY_PV}"
DEMOS_S_PV="${S_PV}"

X86_AT="jdk-${MY_PV}-linux-i586.bin"
AMD64_AT="jdk-${MY_PV}-linux-x64.bin"
IA64_AT="jdk-${MY_PV}-linux-ia64.bin"
SOL_X86_AT="jdk-${MY_PV}-solaris-i586.sh"
SOL_AMD64_AT="jdk-${MY_PV}-solaris-x64.sh"
SOL_SPARC_AT="jdk-${MY_PV}-solaris-sparc.sh"
SOL_SPARCv9_AT="jdk-${MY_PV}-solaris-sparcv9.sh"

X86_DEMOS="jdk-${DEMOS_PV}-linux-i586-demos.tar.gz"
AMD64_DEMOS="jdk-${DEMOS_PV}-linux-x64-demos.tar.gz"
IA64_DEMOS="jdk-${DEMOS_PV}-linux-ia64-demos.tar.gz"
SOL_X86_DEMOS="jdk-${DEMOS_PV}-solaris-i586-demos.tar.Z"
SOL_AMD64_DEMOS="jdk-${DEMOS_PV}-solaris-x64-demos.tar.Z"
SOL_SPARC_DEMOS="jdk-${DEMOS_PV}-solaris-sparc-demos.tar.Z"
SOL_SPARCv9_DEMOS="jdk-${DEMOS_PV}-solaris-sparcv9-demos.tar.Z"

DESCRIPTION="Oracle's Java SE Development Kit"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="
	x86? ( ${X86_AT}
		examples? ( ${X86_DEMOS} ) )
	amd64? ( ${AMD64_AT}
		examples? ( ${AMD64_DEMOS} ) )
	ia64? ( ${IA64_AT}
		examples? ( ${IA64_DEMOS} ) )
	x86-solaris? ( ${SOL_X86_AT}
		examples? ( ${SOL_X86_DEMOS} ) )
	x64-solaris? ( ${SOL_X86_AT} ${SOL_AMD64_AT}
		examples? ( ${SOL_X86_DEMOS} ${SOL_AMD64_DEMOS} ) )
	sparc-solaris? ( ${SOL_SPARC_AT}
		examples? ( ${SOL_SPARC_DEMOS} ) )
	sparc64-solaris? ( ${SOL_SPARC_AT} ${SOL_SPARCv9_AT}
		examples? ( ${SOL_SPARC_DEMOS} ${SOL_SPARCv9_DEMOS} ) )"

LICENSE="Oracle-BCLA-JavaSE examples? ( BSD )"
SLOT="1.6"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

IUSE="X alsa derby doc examples jce kernel_SunOS nsplugin pax_kernel +source"

RESTRICT="fetch strip"
QA_PREBUILT="*"

RDEPEND="
	X? (
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXt
		x11-libs/libXtst
	)
	alsa? ( media-libs/alsa-lib )
	doc? ( dev-java/java-sdk-docs:1.6.0 )
	jce? ( dev-java/sun-jce-bin:1.6 )
	kernel_SunOS? ( app-arch/unzip )
	!prefix? ( sys-libs/glibc )"
# scanelf won't create a PaX header, so depend on paxctl to avoid fallback
# marking. #427642
DEPEND="
	pax_kernel? ( sys-apps/paxctl )"

S="${WORKDIR}/jdk${S_PV}"

_set_at() {
	if use x86; then
		AT=${X86_AT}
	elif use amd64; then
		AT=${AMD64_AT}
	elif use ia64; then
		AT=${IA64_AT}
	elif use x86-solaris; then
		AT=${SOL_X86_AT}
	elif use x64-solaris; then
		AT="${SOL_X86_AT} and ${SOL_AMD64_AT}"
	elif use sparc-solaris; then
		AT=${SOL_SPARC_AT}
	elif use sparc64-solaris; then
		AT="${SOL_SPARC_AT} and ${SOL_SPARCv9_AT}"
	fi
}

_set_demos() {
	if use x86; then
		DEMOS=${X86_DEMOS}
	elif use amd64; then
		DEMOS=${AMD64_DEMOS}
	elif use ia64; then
		DEMOS=${IA64_DEMOS}
	elif use x86-solaris; then
		DEMOS=${SOL_X86_DEMOS}
	elif use x64-solaris; then
		DEMOS="${SOL_X86_DEMOS} and ${SOL_AMD64_DEMOS}"
	elif use sparc-solaris; then
		DEMOS=${SOL_SPARC_AT}
	elif use sparc64-solaris; then
		DEMOS="${SOL_SPARC_AT_DEMOS} and ${SOL_SPARCv9_DEMOS}"
	fi
}

pkg_nofetch() {
	_set_at
	_set_demos

	einfo "Due to Oracle no longer providing the distro-friendly DLJ bundles, the package"
	einfo "has become fetch restricted again. Alternatives are switching to"
	einfo "dev-java/icedtea-bin:6 or the source-based dev-java/icedtea:6"
	einfo ""
	einfo "Please download ${AT} from:"
	einfo "${JDK_URI}"
	einfo "and move it to ${DISTDIR}"

	if use examples; then
		einfo ""
		einfo "Also download ${DEMOS} from:"
		einfo "${JDK_URI}"
		einfo "and move it to ${DISTDIR}"
	fi
}

_sol_src_unpack() {
	for i in ${AT}; do
		[[ ${i} == "and" ]] && continue
		rm -f "${S}"/jre/{LICENSE,README} "${S}"/LICENSE
		# don't die on unzip, it always "fails"
		unzip "${DISTDIR}"/${i}
	done
	for f in $(find "${S}" -name "*.pack") ; do
		"${S}"/bin/unpack200 ${f} ${f%.pack}.jar
		rm ${f}
	done
	if use examples ; then
		for i in ${DEMOS}; do
			[[ ${i} == "and" ]] && continue
			use examples && unpack ${i}
		done
		mv "${WORKDIR}"/SUNWj6dmo/reloc/jdk/instances/jdk1.6.0/{demo,sample} \
			"${S}"/ || die
	fi
}

src_unpack() {
	_set_at
	_set_demos
	if use kernel_SunOS; then
		_sol_src_unpack
	else
		sh "${DISTDIR}"/${AT} -noregister || die "Failed to unpack"
		use examples && unpack ${DEMOS}
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
	# limit heap size for large memory on x86 #405239
	# this is a workaround and shouldn't be needed.
	bin/java -server -Xmx64m -Xshare:dump || die
}

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}${dest}"

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
		cp -pPR "${WORKDIR}/jdk${DEMOS_S_PV}"/{demo,sample} "${ddest}" || die
	fi

	# Remove empty dirs we might have copied
	find "${D}" -type d -empty -exec rmdir -v {} + || die

	dodoc COPYRIGHT
	dohtml README.html

	if use jce; then
		dodir "${dest}"/jre/lib/security/strong-jce
		mv "${ddest}"/jre/lib/security/US_export_policy.jar \
			"${ddest}"/jre/lib/security/strong-jce || die
		mv "${ddest}"/jre/lib/security/local_policy.jar \
			"${ddest}"/jre/lib/security/strong-jce || die
		dosym /opt/sun-jce-bin-1.6.0/jre/lib/security/unlimited-jce/US_export_policy.jar \
			"${dest}"/jre/lib/security/US_export_policy.jar
		dosym /opt/sun-jce-bin-1.6.0/jre/lib/security/unlimited-jce/local_policy.jar \
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
	sed -e "s#Name=.*#Name=Java Control Panel for Oracle JDK ${SLOT} (sun-jdk)#" \
		-e "s#Exec=.*#Exec=/opt/${P}/jre/bin/jcontrol#" \
		-e "s#Icon=.*#Icon=sun-jcontrol-${PN}-${SLOT}#" \
		-e "s#Application;##" \
		-e "/Encoding/d" \
		jre/lib/desktop/applications/sun_java.desktop > \
		"${T}"/jcontrol-${PN}-${SLOT}.desktop || die
	domenu "${T}"/jcontrol-${PN}-${SLOT}.desktop

	# http://docs.oracle.com/javase/6/docs/technotes/guides/intl/fontconfig.html
	rm "${ddest}"/jre/lib/fontconfig.* || die
	cp "${FILESDIR}"/fontconfig.Gentoo.properties-r1 "${T}"/fontconfig.properties || die
	eprefixify "${T}"/fontconfig.properties
	insinto "${dest}"/jre/lib/
	doins "${T}"/fontconfig.properties

	set_java_env "${FILESDIR}/${VMHANDLE}.env-r1"
	java-vm_revdep-mask
	java-vm_sandbox-predict /dev/random
}

pkg_postinst() {
	java-vm-2_pkg_postinst

	elog "If you want Oracles JDK 7 'emerge oracle-jdk-bin' instead."
}

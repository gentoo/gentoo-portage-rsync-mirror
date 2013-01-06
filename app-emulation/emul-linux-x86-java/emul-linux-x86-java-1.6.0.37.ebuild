# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-java/emul-linux-x86-java-1.6.0.37.ebuild,v 1.2 2012/10/21 10:59:26 ago Exp $

EAPI="4"

inherit java-vm-2 eutils prefix versionator

# This URIs need to be updated when bumping!
JRE_URI="http://www.oracle.com/technetwork/java/javase/downloads/jre6u37-downloads-1859589.html"

MY_PV="$(get_version_component_range 2)u$(get_version_component_range 4)"
S_PV="$(replace_version_separator 3 '_')"

X86_AT="jre-${MY_PV}-linux-i586.bin"

DESCRIPTION="Oracle's Java SE Runtime Environment (32bit)"
HOMEPAGE="http://www.oracle.com/technetwork/java/javase/"
SRC_URI="${X86_AT}"

LICENSE="Oracle-BCLA-JavaSE"
SLOT="1.6"
KEYWORDS="-* amd64"
IUSE="X alsa nsplugin pax_kernel"

RESTRICT="fetch strip"
QA_PREBUILT="*"

RDEPEND="
	X? ( app-emulation/emul-linux-x86-xlibs )
	alsa? ( app-emulation/emul-linux-x86-soundlibs )"
# scanelf won't create a PaX header, so depend on paxctl to avoid fallback
# marking. #427642
DEPEND="
	pax_kernel? ( sys-apps/paxctl )"

S="${WORKDIR}/jre${S_PV}"

pkg_nofetch() {
	einfo "Due to Oracle no longer providing the distro-friendly DLJ bundles, the package has become fetch restricted again."
	einfo ""
	einfo "Please download '${X86_AT}' from:"
	einfo "'${JRE_URI}'"
	einfo "and move it to '${DISTDIR}'"
}

src_unpack() {
	sh "${DISTDIR}"/${A} -noregister || die "Failed to unpack"
}

src_compile() {
	# This needs to be done before CDS - #215225
	java-vm_set-pax-markings "${S}"

	# see bug #207282
	einfo "Creating the Class Data Sharing archives"
	bin/java -client -Xshare:dump || die
	bin/java -server -Xshare:dump || die
}

src_install() {
	local dest="/opt/${P}"
	local ddest="${ED}${dest}"

	# We should not need the ancient plugin for Firefox 2 anymore, plus it has
	# writable executable segments
	rm -vf lib/i386/libjavaplugin_oji.so \
		lib/i386/libjavaplugin_nscp*.so
	rm -vrf plugin/i386
	# Without nsplugin flag, also remove the new plugin
	arch=i386;
	if ! use nsplugin; then
		rm -vf lib/${arch}/libnpjp2.so \
			lib/${arch}/libjavaplugin_jni.so
	fi

	dodir "${dest}"
	cp -pPR bin lib man "${ddest}" || die

	# Remove empty dirs we might have copied
	find "${D}" -type d -empty -exec rmdir {} + || die

	dodoc COPYRIGHT README

	if use nsplugin; then
		install_mozilla_plugin "${dest}"/lib/${arch}/libnpjp2.so
	fi

	# Install desktop file for the Java Control Panel.
	# Using ${PN}-${SLOT} to prevent file collision with jre and or other slots.
	# make_desktop_entry can't be used as ${P} would end up in filename.
	newicon lib/desktop/icons/hicolor/48x48/apps/sun-jcontrol.png \
		sun-jcontrol-${PN}-${SLOT}.png || die
	sed -e "s#Name=.*#Name=Java Control Panel for Oracle JDK ${SLOT} (${PN})#" \
		-e "s#Exec=.*#Exec=${dest}/bin/jcontrol#" \
		-e "s#Icon=.*#Icon=sun-jcontrol-${PN}-${SLOT}#" \
		-e "s#Application;##" \
		-e "/Encoding/d" \
		lib/desktop/applications/sun_java.desktop > \
		"${T}"/jcontrol-${PN}-${SLOT}.desktop || die
	domenu "${T}"/jcontrol-${PN}-${SLOT}.desktop

	# http://docs.oracle.com/javase/6/docs/technotes/guides/intl/fontconfig.html
	rm "${ddest}"/lib/fontconfig.* || die
	cp "${FILESDIR}"/fontconfig.Gentoo.properties "${T}"/fontconfig.properties || die
	eprefixify "${T}"/fontconfig.properties
	insinto "${dest}"/lib/
	doins "${T}"/fontconfig.properties

	set_java_env "${FILESDIR}/${VMHANDLE}.env-r1"
	java-vm_revdep-mask
}

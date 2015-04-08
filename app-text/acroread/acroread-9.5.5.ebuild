# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-9.5.5.ebuild,v 1.7 2014/06/18 19:03:13 mgorny Exp $

EAPI=5

inherit eutils gnome2-utils nsplugins

DESCRIPTION="Adobe's PDF reader"
SRC_URI="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/${PV}/enu/AdbeRdr${PV}-1_i486linux_enu.tar.bz2"
HOMEPAGE="http://www.adobe.com/products/reader/"

LICENSE="Adobe"
KEYWORDS="-* amd64 x86 ~amd64-linux ~x86-linux"
SLOT="0"
IUSE="cups html ldap nsplugin"
# asian fonts from separate package:
IUSE+=" linguas_zh_CN linguas_zh_TW linguas_ja linguas_ko"

RESTRICT="strip mirror"

DEPEND="dev-util/bsdiff"
RDEPEND="media-libs/fontconfig
	cups? ( net-print/cups )
	x86? (
		=dev-libs/openssl-0.9.8*
		x11-libs/gtk+:2
		net-dns/libidn
		|| ( x11-libs/pangox-compat <x11-libs/pango-1.31[X] )
		ldap? ( net-nds/openldap )
		html? (
			|| (
				www-client/firefox
				www-client/firefox-bin
				www-client/seamonkey
			)
		)
	)
	amd64? (
		|| (
			app-emulation/emul-linux-x86-gtklibs[-abi_x86_32(-)]
			(
				>=x11-libs/gtk+-2.24.23:2[abi_x86_32(-)]
				|| (
					>=x11-libs/pangox-compat-0.0.2[abi_x86_32(-)]
					<x11-libs/pango-1.31[X,abi_x86_32(-)]
				)
			)
		)
		|| (
			app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
			(
				=dev-libs/openssl-0.9.8*[abi_x86_32(-)]
				>=net-dns/libidn-1.28[abi_x86_32(-)]
				ldap? ( >=net-nds/openldap-2.4.38-r1[abi_x86_32(-)] )
			)
		)
	)
	linguas_zh_CN? ( media-fonts/acroread-asianfonts[linguas_zh_CN] )
	linguas_ja? ( media-fonts/acroread-asianfonts[linguas_ja] )
	linguas_zh_TW? ( media-fonts/acroread-asianfonts[linguas_zh_TW] )
	linguas_ko? ( media-fonts/acroread-asianfonts[linguas_ko] )"

QA_EXECSTACK="
	opt/Adobe/Reader9/Reader/intellinux/bin/acroread
	opt/Adobe/Reader9/Reader/intellinux/lib/libauthplay.so.0.0.0
	opt/Adobe/Reader9/Reader/intellinux/lib/libsccore.so
	opt/Adobe/Reader9/Reader/intellinux/lib/libcrypto.so.0.9.8
	opt/Adobe/Reader9/Reader/intellinux/plug_ins/PPKLite.api
"
QA_FLAGS_IGNORED="
	opt/Adobe/Reader9/Reader/intellinux/plug_ins3d/.*.x3d
	opt/Adobe/Reader9/Reader/intellinux/lib/lib.*
	opt/Adobe/Reader9/Reader/intellinux/bin/SynchronizerApp-binary
	opt/Adobe/Reader9/Reader/intellinux/bin/acroread
	opt/Adobe/Reader9/Reader/intellinux/bin/xdg-user-dirs-update
	opt/Adobe/Reader9/Reader/intellinux/SPPlugins/ADMPlugin.apl
	opt/Adobe/Reader9/Reader/intellinux/plug_ins/AcroForm/PMP/.*.pmp
	opt/Adobe/Reader9/Reader/intellinux/plug_ins/Multimedia/MPP/.*.mpp
	opt/Adobe/Reader9/Reader/intellinux/plug_ins/.*.api
	opt/Adobe/Reader9/Reader/intellinux/sidecars/.*.DEU
	opt/Adobe/Reader9/Browser/intellinux/nppdf.so
	opt/netscape/plugins/nppdf.so
"
QA_TEXTRELS="
	opt/Adobe/Reader9/Reader/intellinux/lib/libextendscript.so
	opt/Adobe/Reader9/Reader/intellinux/lib/libsccore.so
"

INSTALLDIR=/opt

S="${WORKDIR}/AdobeReader"

# remove bundled libs to force use of system version, bug 340527
REMOVELIBS="libcrypto libssl"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	# lowercase tar extension required for unpack, bug 476734
	mv ./ILINXR.TAR ./ILINXR.tar || die
	mv ./COMMON.TAR ./COMMON.tar || die
	unpack ./ILINXR.tar ./COMMON.tar
}

src_prepare() {
	# remove cruft
	rm "${S}"/Adobe/Reader9/bin/UNINSTALL
	rm "${S}"/Adobe/Reader9/Browser/install_browser_plugin
	rm "${S}"/Adobe/Reader9/Resource/Support/vnd.*.desktop

	# replace some configuration sections
	for binfile in "${S}"/Adobe/Reader9/bin/* ; do
		sed -i -e '/Font-config/,+9d' \
			-e "/acrogre.conf/r ${FILESDIR}/gentoo_config" -e //N \
			"${binfile}" || die "sed configuration settings failed."
	done

	# fix erroneous Exec entry in .desktop
	sed -i \
		-e 's/^Exec=acroread[[:space:]]*$/Exec=acroread %U/' \
		"${S}"/Adobe/Reader9/Resource/Support/AdobeReader.desktop \
		||die "sed .desktop fix failed"

	# fix braindead error in nppdf.so (bug 412051)
	base64 -d > "${WORKDIR}/nppdf.so.patch" << ENDOFFILE
QlNESUZGNDBIAAAAAAAAAC8AAAAAAAAAYL0CAAAAAABCWmg5MUFZJlNZFBL6EAAAFvBh+DwgDAgQ
QAAAEABAIAAgACICaGjJtQoaaYAFPzpGDIjiUXSFYEuGy1ix8XckU4UJAUEvoQBCWmg5MUFZJlNZ
jrYrlQABYGAAwAAIAAAIIAAwzAUppgKbECni7kinChIR1sVyoEJaaDkxQVkmU1kzGPRGAAAAEYAA
AIYFAwAgACIHqbUIYAdBF8XckU4UJAzGPRGA
ENDOFFILE
	einfo "Patching nppdf.so"
	mv Adobe/Reader9/Browser/intellinux/nppdf.so Adobe/Reader9/Browser/intellinux/nppdf.so.orig || die
	bspatch Adobe/Reader9/Browser/intellinux/nppdf.so.orig Adobe/Reader9/Browser/intellinux/nppdf.so "${WORKDIR}/nppdf.so.patch" || die
	rm Adobe/Reader9/Browser/intellinux/nppdf.so.orig || die
}

src_install() {
	local LAUNCHER="Adobe/Reader9/bin/acroread"

	# Install desktop files
	domenu Adobe/Reader9/Resource/Support/AdobeReader.desktop

	# Install commonly used icon sizes
	for res in 16x16 22x22 32x32 48x48 64x64 128x128 ; do
		insinto /usr/share/icons/hicolor/${res}/apps
		doins Adobe/Reader9/Resource/Icons/${res}/*
	done

	dodir /opt
	chown -R --dereference -L root:0 Adobe
	cp -dpR Adobe "${ED}"opt/ || die

	# remove some bundled libs
	for mylib in ${REMOVELIBS}; do
		einfo Removing bundled ${mylib}
		rm -v "${ED}"/opt/Adobe/Reader9/Reader/intellinux/lib/${mylib}*
	done

	doman Adobe/Reader9/Resource/Shell/acroread.1.gz

	if use nsplugin; then
		exeinto /opt/netscape/plugins
		doexe Adobe/Reader9/Browser/intellinux/nppdf.so
		inst_plugin /opt/netscape/plugins/nppdf.so
	fi

	dodir /opt/bin
	dosym /opt/${LAUNCHER} /opt/bin/${LAUNCHER/*bin\/}

	# We need to set a MOZILLA_COMP_PATH for seamonkey and firefox since
	# they don't install a configuration file for libgtkembedmoz.so
	# detection in /etc/gre.d/ like xulrunner did.
	if use x86 && use html; then
		for lib in /opt/seamonkey /usr/lib/seamonkey /usr/lib/mozilla-firefox; do
			if [[ -f ${lib}/libgtkembedmoz.so ]] ; then
				echo "MOZILLA_COMP_PATH=${lib}" >> "${ED}"${INSTALLDIR}/Adobe/Reader9/Reader/GlobalPrefs/mozilla_config
				elog "Adobe Reader depends on libgtkembedmoz.so, which I've found on"
				elog "your system in ${lib}, and configured in ${INSTALLDIR}/Adobe/Reader9/Reader/GlobalPrefs/mozilla_config."
				break # don't search any more libraries
			fi
		done
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst () {
	if use x86 && ! use html; then
		echo
		ewarn "If you want html support and/or view the Adobe Reader help you have"
		ewarn "to re-emerge acroread with USE=\"html\"."
		echo
	fi

	if use amd64 && use nsplugin && ! has_version www-plugins/nspluginwrapper; then
		echo
		elog "If you're running a 64bit browser you may also want to install"
		elog "\"www-plugins/nspluginwrapper\" to be able to use the Adobe Reader"
		elog "browser plugin."
		echo
	fi

	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

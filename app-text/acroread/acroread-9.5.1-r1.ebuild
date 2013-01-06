# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/acroread/acroread-9.5.1-r1.ebuild,v 1.7 2012/12/19 16:57:44 tetromino Exp $

EAPI=4

inherit eutils gnome2-utils nsplugins

DESCRIPTION="Adobe's PDF reader"
HOMEPAGE="http://www.adobe.com/products/reader/"
IUSE="cups ldap minimal nsplugin"

SRC_HEAD="http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/${PV}"
SRC_FOOT=".tar.bz2"

# languages not available yet: it:ita es:esp pt:ptb sv:sve zh_CN:chs zh_TW:cht fi:suo nb:nor nl:nld ko:kor da:dan de:deu fr:fra ja:jpn
# asian fonts are handled separately
LINGUA_LIST="en:enu"
DEFAULT_URI="${SRC_HEAD}/enu/AdbeRdr${PV}-1_i486linux_enu${SRC_FOOT}"
for ll in ${LINGUA_LIST} ; do
	iuse_l="linguas_${ll/:*}"
	src_l=${ll/*:}
	IUSE="${IUSE} ${iuse_l}"
	DEFAULT_URI="!${iuse_l}? ( ${DEFAULT_URI} )"
	SRC_URI="${SRC_URI}
		${iuse_l}? ( ${SRC_HEAD}/${src_l}/AdbeRdr${PV}-1_i486linux_${src_l}${SRC_FOOT} )"
done

# asian fonts from separate package:
IUSE="${IUSE} linguas_zh_CN linguas_zh_TW linguas_ja linguas_ko"

SRC_URI="${SRC_URI}
	${DEFAULT_URI}"

LICENSE="Adobe"
SLOT="0"
KEYWORDS="-* amd64 x86 ~amd64-linux ~x86-linux"
RESTRICT="strip mirror"

DEPEND="dev-util/bsdiff"

# mozilla-firefox-bin won't work because it doesn't have gtkembedmoz.so
RDEPEND="media-libs/fontconfig
	x86? ( =dev-libs/openssl-0.9.8* )
	cups? ( net-print/cups )
	x86? ( x11-libs/gtk+:2 x11-libs/pango[X] net-dns/libidn
			|| ( x11-libs/pangox-compat <x11-libs/pango-1.31[X] )
			ldap? ( net-nds/openldap )
			!minimal? ( || ( www-client/firefox
						www-client/firefox-bin
						www-client/seamonkey ) ) )
	amd64? ( app-emulation/emul-linux-x86-gtklibs app-emulation/emul-linux-x86-baselibs )
	linguas_zh_CN? ( media-fonts/acroread-asianfonts[linguas_zh_CN] )
	linguas_ja? ( media-fonts/acroread-asianfonts[linguas_ja] )
	linguas_zh_TW? ( media-fonts/acroread-asianfonts[linguas_zh_TW] )
	linguas_ko? ( media-fonts/acroread-asianfonts[linguas_ko] )"

QA_EXECSTACK="opt/Adobe/Reader9/Reader/intellinux/bin/acroread
	opt/Adobe/Reader9/Reader/intellinux/lib/libauthplay.so.0.0.0
	opt/Adobe/Reader9/Reader/intellinux/lib/libsccore.so
	opt/Adobe/Reader9/Reader/intellinux/lib/libcrypto.so.0.9.8
	opt/Adobe/Reader9/Reader/intellinux/plug_ins/PPKLite.api"

QA_FLAGS_IGNORED="opt/Adobe/Reader9/Reader/intellinux/plug_ins3d/.*.x3d
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
	opt/netscape/plugins/nppdf.so"

QA_TEXTRELS="opt/Adobe/Reader9/Reader/intellinux/lib/libsccore.so"

INSTALLDIR=/opt

S="${WORKDIR}/AdobeReader"

# Actually, ahv segfaults when run standalone so presumably
# it isn't intended for direct use - so the only launcher is
# acroread after all.
LAUNCHERS="Adobe/Reader9/bin/acroread"
#	Adobe/HelpViewer/1.0/intellinux/bin/ahv"

# remove bundled libs to force use of system version, bug 340527
REMOVELIBS="libcrypto libssl"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"
}

# Determine lingua from filename
acroread_get_ll() {
	local f_src_l ll lingua src_l
	f_src_l=${1/${SRC_FOOT}}
	f_src_l=${f_src_l/*_}
	for ll in ${LINGUA_LIST} ; do
		lingua=${ll/:*}
		src_l=${ll/*:}
		if [[ ${src_l} == ${f_src_l} ]] ; then
			echo ${lingua}
			return
		fi
	done
	die "Failed to match file $1 to a LINGUA; please report."
}

src_unpack() {
	local ll linguas fl launcher
	# Unpack all into the same place; overwrite common files.
	fl=""
	for pkg in ${A} ; do
		cd "${WORKDIR}"
		unpack ${pkg}
		cd "${S}"
		tar xf ILINXR.TAR || die "Failed to unpack ILINXR.TAR."
		tar xf COMMON.TAR || die "Failed to unpack COMMON.TAR."
		ll=$(acroread_get_ll ${pkg})
		for launcher in ${LAUNCHERS} ; do
			mv ${launcher} ${launcher}.${ll}
		done
		if [[ -z ${fl} ]] ; then
			fl=${ll}
			linguas="${ll}"
		else
			linguas="${linguas} ${ll}"
		fi
	done
	if [[ ${linguas} == ${fl} ]] ; then
		# Only one lingua selected - skip building the wrappers
		for launcher in ${LAUNCHERS} ; do
			mv ${launcher}.${fl} ${launcher} ||
				die "Failed to put ${launcher}.${fl} back to ${launcher}; please report."
		done
	else
		# Build wrappers.  Launch the acroread for the environment variable
		# LANG (matched with a trailing * so that for example 'de_DE' matches
		# 'de', 'en_GB' matches 'en' etc).
		#
		# HelpViewer is new - We don't know if Adobe are likely to
		# internationalize it or not.
		for launcher in ${LAUNCHERS} ; do
			cat > ${launcher} <<-EOF
				#!/bin/bash
				# Copyright 1999-2009 Gentoo Foundation
				# Distributed under the terms of the GNU General Public License v2
				#
				# Automatically generated by ${CATEGORY}/${PF}

				# Exec the acroread script for the language chosen in
				# LC_ALL/LC_MESSAGES/LANG (first found takes precedence, as in glibc)
				L=\${LC_ALL}
				L=\${L:-\${LC_MESSAGES}}
				L=\${L:-\${LANG}}
				case \${L} in
			EOF
			for ll in ${linguas} ; do
				echo "${ll}*) exec ${INSTALLDIR}/${launcher}.${ll} \"\$@\";;" >> ${launcher}
			done
			# default to English (in particular for LANG=C)
			cat >> ${launcher} <<-EOF
				*) exec ${INSTALLDIR}/${launcher}.${fl} "\$@";;
				esac
			EOF
			chmod 755 ${launcher}
		done
	fi

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
	sed -i -e 's/^Exec=acroread[[:space:]]*$/Exec=acroread %U/' \
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
	for mylib in ${REMOVELIBS} ; do
		einfo Removing bundled ${mylib}
		rm -v "${ED}"/opt/Adobe/Reader9/Reader/intellinux/lib/${mylib}*
	done

	doman Adobe/Reader9/Resource/Shell/acroread.1.gz

	if use nsplugin ; then
		exeinto /opt/netscape/plugins
		doexe Adobe/Reader9/Browser/intellinux/nppdf.so
		inst_plugin /opt/netscape/plugins/nppdf.so
	fi

	dodir /opt/bin
	for launcher in ${LAUNCHERS} ; do
		dosym /opt/${launcher} /opt/bin/${launcher/*bin\/}
	done

	# We need to set a MOZILLA_COMP_PATH for seamonkey and firefox since
	# they don't install a configuration file for libgtkembedmoz.so
	# detection in /etc/gre.d/ like xulrunner did.
	if ! use minimal ; then
		if use x86 ; then
			for lib in /opt/seamonkey /usr/lib/seamonkey /usr/lib/mozilla-firefox ; do
				if [[ -f ${lib}/libgtkembedmoz.so ]] ; then
					echo "MOZILLA_COMP_PATH=${lib}" >> "${ED}"${INSTALLDIR}/Adobe/Reader9/Reader/GlobalPrefs/mozilla_config
					elog "Adobe Reader depends on libgtkembedmoz.so, which I've found on"
					elog "your system in ${lib}, and configured in ${INSTALLDIR}/Adobe/Reader9/Reader/GlobalPrefs/mozilla_config."
					break # don't search any more libraries
				fi
			done
		fi
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst () {
	local ll lc
	lc=0
	for ll in ${LINGUA_LIST} ; do
		use linguas_${ll/:*} && (( lc = ${lc} + 1 ))
	done
	if [[ ${lc} > 1 ]] ; then
		echo
		elog "Multiple languages have been installed, selected via a wrapper script."
		elog "The language is selected according to the LANG environment variable"
		elog "(defaulting to English if LANG is not set, or no matching language"
		elog "version is installed). Users may need to remove their preferences in"
		elog "~/.adobe to switch languages."
		echo
	fi

	if use minimal ; then
		echo
		ewarn "If you want html support and/or view the Adobe Reader help you have"
		ewarn "to re-emerge acroread with USE=\"-minimal\"."
		echo
	fi

	if use nsplugin ; then
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

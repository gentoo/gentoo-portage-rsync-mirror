# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/adobe-flash/adobe-flash-11.2.202.261.ebuild,v 1.2 2013/01/15 11:08:10 pinkbyte Exp $

EAPI=4
inherit nsplugins multilib toolchain-funcs versionator

AF_URI="http://fpdownload.macromedia.com/get/flashplayer/pdc"
MY_32B_URI="${AF_URI}/${PV}/install_flash_player_$(get_major_version)_linux.i386.tar.gz -> ${P}.i386.tar.gz"
MY_64B_URI="${AF_URI}/${PV}/install_flash_player_$(get_major_version)_linux.x86_64.tar.gz -> ${P}.x86_64.tar.gz"

DESCRIPTION="Adobe Flash Player"
SRC_URI="x86? ( ${MY_32B_URI} )
amd64? (
	multilib? (
		32bit? ( ${MY_32B_URI} )
		64bit? ( ${MY_64B_URI} )
	)
	!multilib? ( ${MY_64B_URI} )
)"
HOMEPAGE="http://www.adobe.com/products/flashplayer.html"
IUSE="multilib -32bit +64bit selinux vdpau kde +sse2check"
SLOT="0"

KEYWORDS="-* amd64 ~x86"
LICENSE="AdobeFlash-10.3"
RESTRICT="strip mirror"

S="${WORKDIR}"

NATIVE_DEPS="x11-libs/gtk+:2
	media-libs/fontconfig
	dev-libs/nss
	net-misc/curl
	vdpau? ( x11-libs/libvdpau )
	kde? ( kde-base/kcmshell )
	>=sys-libs/glibc-2.4"

EMUL_DEPS="vdpau? ( >=app-emulation/emul-linux-x86-xlibs-20110129 )
	>=app-emulation/emul-linux-x86-gtklibs-20100409-r1
	app-emulation/emul-linux-x86-soundlibs"

DEPEND="amd64? ( multilib? ( !64bit? ( www-plugins/nspluginwrapper ) ) )
	selinux? ( sec-policy/selinux-flash )"
RDEPEND="x86? ( $NATIVE_DEPS )
	amd64? (
		multilib? (
			64bit? ( $NATIVE_DEPS )
			32bit? ( $EMUL_DEPS )
		)
		!multilib? ( $NATIVE_DEPS )
	)
	|| ( media-fonts/liberation-fonts media-fonts/corefonts )
	${DEPEND}"

# Where should this all go? (Bug #328639)
INSTALL_BASE="opt/Adobe/flash-player"

# Ignore QA warnings in these closed-source binaries, since we can't fix them:
QA_PREBUILT="opt/*"

any_cpu_missing_flag() {
	local value=$1
	grep '^flags' /proc/cpuinfo | grep -qv "$value"
}

pkg_pretend() {
	if any_cpu_missing_flag 'sse2'; then
		eerror "This version of adobe-flash requires a CPU that supports the"
		eerror "SSE2 instruction set, and at least one of your CPUs does not"
		eerror "support this feature."
		eerror ""
		if use sse2check; then
			eerror "You should mask this version and use adobe-flash-10.3.* instead."
			eerror "To do so, add the following line to your package.mask file:"
			eerror "  =${CATEGORY}/${P}"
			eerror ""
			eerror "Or if you are trying to build a binary package for another host"
			eerror "that does support SSE2 instructions, you may override this"
			eerror "check by setting USE=\"-sse2check\""
			eerror ""
			die "${P} requires CPU with SSE2"
		else
			eerror "Continuing anyway due to USE=\"-sse2check\", but be aware that flash"
			eerror "will not function unless all of the CPUs on the system where it"
			eerror "is installed support the SSE2 instruction set."
		fi
	fi
}

pkg_setup() {
	if use x86; then
		export native_install=1
	elif use amd64; then
		# amd64 users may unselect the native 64bit binary, if they choose
		# TODO: In future revisions, remove this ability now that 64-bit
		# binaries are officially released and working.
		if ! use multilib || use 64bit; then
			export native_install=1
		else
			unset native_install
		fi

		if use multilib && use 32bit; then
			export amd64_32bit=1
		else
			unset amd64_32bit
		fi

		if use multilib && ! use 32bit && ! use 64bit; then
			eerror "You must select at least one architecture USE flag (32bit or 64bit)"
			die "No library version selected [-32bit -64bit]"
		fi

		unset need_lahf_wrapper
		if [[ $native_install ]]; then
			# 64bit flash requires the 'lahf' instruction (bug #268336)
			if any_cpu_missing_flag 'lahf_lm'; then
				export need_lahf_wrapper=1
			fi
		fi
	fi
}

src_unpack() {
	if [[ $amd64_32bit ]]; then
		# Since the 32-bit and 64-bit packages collide, put the 32-bit one
		# elsewhere:
		local my_32b_src=${MY_32B_URI##*>}
		local my_64b_src=${MY_64B_URI##*>}
		if [[ $native_install ]]; then
			unpack $my_64b_src
		fi
		mkdir 32bit
		pushd 32bit >/dev/null
		unpack $my_32b_src
		popd >/dev/null
	else
		default_src_unpack
	fi
}

src_compile() {
	if [[ $need_lahf_wrapper ]]; then
		# This experimental wrapper, from Maks Verver via bug #268336 should
		# emulate the missing lahf instruction affected platforms.
		$(tc-getCC) -fPIC -shared -nostdlib -lc -oflashplugin-lahf-fix.so \
			"${FILESDIR}/flashplugin-lahf-fix.c" \
			|| die "Compile of flashplugin-lahf-fix.so failed"
	fi
}

src_install() {
	if [[ $native_install ]]; then
		if use x86; then
			local PKGLIB=lib
		else
			local PKGLIB=lib64
		fi
		local BASE=${INSTALL_BASE}

		# The plugin itself
		exeinto /${BASE}/flash-plugin
		doexe libflashplayer.so
		inst_plugin /${BASE}/flash-plugin/libflashplayer.so

		# The optional KDE4 KCM plugin
		if use kde; then
			exeinto /${BASE}/kde4
			doexe usr/${PKGLIB}/kde4/kcm_adobe_flash_player.so
			dosym /${BASE}/kde4/kcm_adobe_flash_player.so \
				/usr/$(get_libdir)/kde4/kcm_adobe_flash_player.so
			insinto /usr/share/kde4/services
			doins usr/share/kde4/services/kcm_adobe_flash_player.desktop
		else
			# No KDE applet, so allow the GTK utility to show up in KDE:
			sed -i usr/share/applications/flash-player-properties.desktop \
				-e "/^NotShowIn=KDE;/d" || die "sed of .desktop file failed"
		fi

		# The userland 'flash-player-properties' standalone app:
		exeinto /${BASE}/bin
		doexe usr/bin/flash-player-properties
		dosym /${BASE}/bin/flash-player-properties \
			usr/bin/flash-player-properties

		# Icon and .desktop for 'flash-player-properties'
		for icon in $(find usr/share/icons/ -name '*.png'); do
			insinto /$(dirname $icon)
			doins $icon
		done
		dosym ../icons/hicolor/48x48/apps/flash-player-properties.png \
			  usr/share/pixmaps/flash-player-properties.png
		insinto usr/share/applications
		sed -i usr/share/applications/flash-player-properties.desktop \
			-e "s:^Exec=:Exec=/${BASE}/bin/:" || die "sed of .desktop file failed"
		doins usr/share/applications/flash-player-properties.desktop
	fi

	if [[ $need_lahf_wrapper ]]; then
		# This experimental wrapper, from Maks Verver via bug #268336 should
		# emulate the missing lahf instruction affected platforms.
		exeinto /${INSTALL_BASE}
		doexe flashplugin-lahf-fix.so
		inst_plugin /${INSTALL_BASE}/flashplugin-lahf-fix.so
	fi

	if [[ $amd64_32bit ]]; then
		# Only install the plugin, nothing else for 32-bit.
		local oldabi="${ABI}"
		ABI="x86"

		# 32b plugin
		pushd "${S}/32bit"
			exeinto /${INSTALL_BASE}32
			doexe libflashplayer.so
			inst_plugin /${INSTALL_BASE}32/libflashplayer.so
		popd

		ABI="${oldabi}"
	fi

	# The magic config file!
	insinto "/etc/adobe"
	doins "${FILESDIR}/mms.cfg"
}

pkg_postinst() {
	if use amd64; then
		if [[ $need_lahf_wrapper ]]; then
			ewarn "Your processor does not support the 'lahf' instruction which is used"
			ewarn "by Adobe's 64-bit flash binary.  We have installed a wrapper which"
			ewarn "should allow this plugin to run.  If you encounter problems, please"
			ewarn "adjust your USE flags to install only the 32-bit version and reinstall:"
			ewarn "  ${CATEGORY}/$PN[+32bit -64bit]"
			elog
		fi
		if has_version 'www-plugins/nspluginwrapper'; then
			if [[ $native_install ]]; then
				# TODO: Perhaps parse the output of 'nspluginwrapper -l'
				#       However, the 64b flash plugin makes
				#       'nspluginwrapper -l' segfault.
				local FLASH_WRAPPER="${ROOT}/usr/lib64/nsbrowser/plugins/npwrapper.libflashplayer.so"
				if [[ -f ${FLASH_WRAPPER} ]]; then
					einfo "Removing duplicate 32-bit plugin wrapper: Native 64-bit plugin installed"
					nspluginwrapper -r "${FLASH_WRAPPER}"
				fi
			else
				einfo "nspluginwrapper detected: Installing plugin wrapper"
				local oldabi="${ABI}"
				ABI="x86"
				local FLASH_SOURCE="${ROOT}/${INSTALL_BASE}32/libflashplayer.so"
				nspluginwrapper -i "${FLASH_SOURCE}"
				ABI="${oldabi}"
			fi
		elif [[ ! $native_install ]]; then
			elog "To use the 32-bit flash player in a native 64-bit browser,"
			elog "you must install www-plugins/nspluginwrapper"
		fi
	fi
}
